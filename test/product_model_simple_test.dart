// test/product_model_simple_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:practica_1/data/models/product_model.dart';
import 'package:practica_1/data/models/rating_model.dart';

void main() {
  group('Product Model Tests', () {
    test('debería crear Product desde JSON correctamente', () {
      // Arrange - Preparar datos JSON como los que vienen de la API
      final jsonData = {
        "id": 1,
        "title": "Fjallraven - Foldsack No. 1 Backpack",
        "price": 109.95,
        "description": "Your perfect pack for everyday use",
        "category": "men's clothing",
        "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
        "rating": {
          "rate": 3.9,
          "count": 120
        }
      };

      // Act - Convertir JSON a Product
      final product = Product.fromJson(jsonData);

      // Assert - Verificar que todos los campos se asignaron correctamente
      expect(product.id, equals(1));
      expect(product.title, equals("Fjallraven - Foldsack No. 1 Backpack"));
      expect(product.price, equals(109.95));
      expect(product.description, equals("Your perfect pack for everyday use"));
      expect(product.category, equals("men's clothing"));
      expect(product.image, equals("https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"));
      expect(product.rating.rate, equals(3.9));
      expect(product.rating.count, equals(120));
    });

    test('debería manejar datos nulos y usar valores por defecto', () {
      // Arrange - JSON con campos nulos (caso edge)
      final incompleteJson = {
        "id": null,
        "title": null,
        "price": null,
        "description": null,
        "category": null,
        "image": null,
        "rating": {
          "rate": null,
          "count": null
        }
      };

      // Act
      final product = Product.fromJson(incompleteJson);

      // Assert - Verificar valores por defecto
      expect(product.id, equals(0));
      expect(product.title, equals(''));
      expect(product.price, equals(0.0));
      expect(product.description, equals(''));
      expect(product.category, equals(''));
      expect(product.image, equals(''));
      expect(product.rating.rate, equals(0.0));
      expect(product.rating.count, equals(0));
    });

    test('debería crear Product manualmente con todos los campos', () {
      // Arrange
      final rating = Rating(rate: 4.5, count: 200);

      // Act
      final product = Product(
        id: 999,
        title: "Test Product",
        price: 29.99,
        description: "Test description",
        category: "test category",
        image: "test.jpg",
        rating: rating,
      );

      // Assert
      expect(product.id, equals(999));
      expect(product.title, equals("Test Product"));
      expect(product.price, equals(29.99));
      expect(product.description, equals("Test description"));
      expect(product.category, equals("test category"));
      expect(product.image, equals("test.jpg"));
      expect(product.rating, equals(rating));
      expect(product.rating.rate, equals(4.5));
      expect(product.rating.count, equals(200));
    });
  });
}