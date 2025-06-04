import 'package:flutter_test/flutter_test.dart';
import 'package:practica_1/data/services/product_service.dart';
import 'package:practica_1/data/models/product_model.dart';

void main() {
  group('ProductService', () {
    final service = ProductService();

    test('fetchProducts devuelve lista no vacía de productos', () async {

      // Se asume que siempre hay al menos un producto en la API pública.
      final products = await service.fetchProducts();
      expect(products, isA<List<Product>>());
      expect(products.isNotEmpty, true);
      // Verificamos que el primer elemento tenga campos razonables:
      final first = products.first;
      expect(first.id, isNonZero);
      expect(first.title, isNotEmpty);
      expect(first.price, greaterThan(0.0));
    });

    test('fetchProductById(1) devuelve un producto con id == 1', () async {
      final product = await service.fetchProductById(1);
      expect(product, isA<Product>());
      expect(product.id, 1);
      expect(product.title, isNotEmpty);
      expect(product.price, greaterThan(0.0));
    });

    test('fetchProductById con id inválido lanza excepción', () async {
      expect(() => service.fetchProductById(9999), throwsException);
    });
  });
}
