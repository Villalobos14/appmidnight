import 'package:flutter_test/flutter_test.dart';
import 'package:practica_1/data/models/product_model.dart'; 
import 'package:practica_1/data/models/rating_model.dart';

void main() {
  group('Product.fromJson', () {
    test('debería convertir correctamente un Map<String, dynamic> a Product', () {
      // Simulamos un JSON tal como lo devuelve fakestoreapi.com para un producto:
      final jsonMap = {
        "id": 42,
        "title": "Zapatillas de prueba",
        "price": 199.99,
        "description": "Descripción de prueba",
        "category": "calzado",
        "image": "https://ejemplo.com/zapatillas.png",
        "rating": {"rate": 4.5, "count": 120}
      };

      final product = Product.fromJson(jsonMap);

      expect(product.id, 42);
      expect(product.title, "Zapatillas de prueba");
      expect(product.price, 199.99);
      expect(product.description, "Descripción de prueba");
      expect(product.category, "calzado");
      expect(product.image, "https://ejemplo.com/zapatillas.png");
      expect(product.rating, isA<Rating>());
      expect(product.rating.rate, 4.5);
      expect(product.rating.count, 120);
    });

    test('debería manejar campos faltantes (usar valores por defecto)', () {
      // Simulamos un JSON con campos nulos o faltantes:
      final incompleteJson = {
        "id": null,
        "title": null,
        "price": null,
        // description, category y image faltan
        "rating": {"rate": null, "count": null}
      };

      final product = Product.fromJson(incompleteJson);

      // En nuestro factory usamos ?? para valores por defecto
      expect(product.id, 0);
      expect(product.title, '');
      expect(product.price, 0.0);
      expect(product.description, '');
      expect(product.category, '');
      expect(product.image, '');
      expect(product.rating.rate, 0.0);
      expect(product.rating.count, 0);
    });
  });
}
