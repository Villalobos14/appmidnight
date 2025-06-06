// test/cart_service_simple_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:practica_1/data/services/cart_service.dart';
import 'package:practica_1/data/models/product_model.dart';
import 'package:practica_1/data/models/rating_model.dart';

void main() {
  group('Cart Service Tests', () {
    // Helper para crear productos de prueba
    Product createTestProduct({
      int id = 1,
      String title = 'Test Product',
      double price = 19.99,
    }) {
      return Product(
        id: id,
        title: title,
        price: price,
        description: 'Test Description',
        category: 'test',
        image: 'test.jpg',
        rating: Rating(rate: 4.5, count: 100),
      );
    }

    setUp(() {
      // Limpiar el carrito antes de cada test
      Cart.items.clear();
    });

    test('debería agregar productos al carrito correctamente', () {
      // Arrange
      final product1 = createTestProduct(id: 1, price: 10.0);
      final product2 = createTestProduct(id: 2, price: 20.0);
      
      expect(Cart.items.length, equals(0)); // Verificar que inicia vacío

      // Act
      Cart.add(product1);
      Cart.add(product2);

      // Assert
      expect(Cart.items.length, equals(2));
      expect(Cart.items[0], equals(product1));
      expect(Cart.items[1], equals(product2));
    });

    test('debería calcular el total del carrito correctamente', () {
      // Arrange
      final product1 = createTestProduct(id: 1, price: 15.50);
      final product2 = createTestProduct(id: 2, price: 25.75);
      final product3 = createTestProduct(id: 3, price: 8.25);

      // Act
      Cart.add(product1);
      Cart.add(product2);
      Cart.add(product3);

      // Assert
      expect(Cart.total, equals(49.50)); // 15.50 + 25.75 + 8.25
    });

    test('debería remover productos del carrito correctamente', () {
      // Arrange
      final product1 = createTestProduct(id: 1, price: 10.0);
      final product2 = createTestProduct(id: 2, price: 20.0);
      
      Cart.add(product1);
      Cart.add(product2);
      Cart.add(product1); // Agregar producto1 dos veces
      
      expect(Cart.items.length, equals(3));
      expect(Cart.total, equals(40.0)); // 10 + 20 + 10

      // Act - Remover solo una instancia del product1
      Cart.remove(product1);

      // Assert
      expect(Cart.items.length, equals(2)); // Ahora debe haber 2 items
      expect(Cart.total, equals(30.0)); // 20 + 10
      expect(Cart.items.contains(product1), isTrue); // product1 aún está (una vez)
      expect(Cart.items.contains(product2), isTrue); // product2 sigue ahí
    });

    test('debería manejar carrito vacío correctamente', () {
      // Arrange - Carrito vacío (ya limpio por setUp)
      
      // Assert - Estado inicial
      expect(Cart.items, isEmpty);
      expect(Cart.items.length, equals(0));
      expect(Cart.total, equals(0.0));

      // Act - Intentar remover de carrito vacío
      final product = createTestProduct();
      Cart.remove(product); // No debería causar error

      // Assert - Sigue vacío
      expect(Cart.items, isEmpty);
      expect(Cart.total, equals(0.0));
    });

    test('debería manejar productos con precios decimales precisos', () {
      // Arrange - Productos con precios que pueden tener problemas de precisión
      final product1 = createTestProduct(id: 1, price: 9.99);
      final product2 = createTestProduct(id: 2, price: 0.01);
      final product3 = createTestProduct(id: 3, price: 15.50);

      // Act
      Cart.add(product1);
      Cart.add(product2);
      Cart.add(product3);

      // Assert
      expect(Cart.total, equals(25.50)); // 9.99 + 0.01 + 15.50
      expect(Cart.items.length, equals(3));
    });
  });
}