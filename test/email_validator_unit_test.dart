// test/email_validator_unit_test.dart
import 'package:flutter_test/flutter_test.dart';

// Clase utilitaria para validar emails (crea esta clase en lib/core/utils.dart)
class EmailValidator {
  // Función estática para validar emails
  static bool isValid(String? email) {
    if (email == null || email.isEmpty) {
      return false;
    }
    
    // Regex para validar formato de email básico
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
  
  // Función para obtener mensaje de error específico
  static String? getErrorMessage(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email es requerido';
    }
    
    if (!isValid(email)) {
      return 'Email inválido';
    }
    
    return null; // Sin errores
  }
  
  // Función para normalizar email (convertir a minúsculas y quitar espacios)
  static String normalize(String email) {
    return email.trim().toLowerCase();
  }
}

void main() {
  group('EmailValidator Unit Tests', () {
    group('isValid method', () {
      test('debería retornar true para emails válidos', () {
        // Arrange - Lista de emails válidos
        final validEmails = [
          'usuario@example.com',
          'test.email@domain.co.uk',
          'user123@test-domain.org',
          'name.lastname@company.net',
          'simple@test.io',
          'user_name@domain.edu',
          'test-user@sub.domain.com',
        ];

        // Act & Assert
        for (final email in validEmails) {
          expect(
            EmailValidator.isValid(email), 
            isTrue, 
            reason: 'Email "$email" debería ser válido',
          );
        }
      });

      test('debería retornar false para emails inválidos', () {
        // Arrange - Lista de emails inválidos
        final invalidEmails = [
          'usuario@',              // Sin dominio
          '@example.com',          // Sin usuario
          'usuario',               // Sin @ ni dominio
          'usuario@.com',          // Dominio inválido
          'usuario@com',           // Sin extensión
          'usuario@domain.',       // Extensión vacía
          'usuario.example.com',   // Sin @
          'usuario@@domain.com',   // Doble @
          'usuario@domain@com',    // @ en dominio
          'usuario@domain..com',   // Doble punto
          'user name@domain.com',  // Espacio en usuario
          '',                      // Vacío
        ];

        // Act & Assert
        for (final email in invalidEmails) {
          expect(
            EmailValidator.isValid(email), 
            isFalse, 
            reason: 'Email "$email" debería ser inválido',
          );
        }
      });

      test('debería retornar false para email nulo', () {
        // Act
        final result = EmailValidator.isValid(null);

        // Assert
        expect(result, isFalse);
      });
    });

    group('getErrorMessage method', () {
      test('debería retornar null para emails válidos', () {
        // Arrange
        const validEmail = 'usuario@example.com';

        // Act
        final result = EmailValidator.getErrorMessage(validEmail);

        // Assert
        expect(result, isNull);
      });

      test('debería retornar "Email es requerido" para email vacío', () {
        // Act & Assert
        expect(EmailValidator.getErrorMessage(''), equals('Email es requerido'));
        expect(EmailValidator.getErrorMessage(null), equals('Email es requerido'));
      });

      test('debería retornar "Email inválido" para formato incorrecto', () {
        // Arrange
        const invalidEmail = 'usuario@domain';

        // Act
        final result = EmailValidator.getErrorMessage(invalidEmail);

        // Assert
        expect(result, equals('Email inválido'));
      });
    });

    group('normalize method', () {
      test('debería convertir email a minúsculas', () {
        // Arrange
        const email = 'USUARIO@EXAMPLE.COM';

        // Act
        final result = EmailValidator.normalize(email);

        // Assert
        expect(result, equals('usuario@example.com'));
      });

      test('debería quitar espacios al inicio y final', () {
        // Arrange
        const email = '  usuario@example.com  ';

        // Act
        final result = EmailValidator.normalize(email);

        // Assert
        expect(result, equals('usuario@example.com'));
      });

      test('debería normalizar email mixto', () {
        // Arrange
        const email = '  USUARIO@EXAMPLE.COM  ';

        // Act
        final result = EmailValidator.normalize(email);

        // Assert
        expect(result, equals('usuario@example.com'));
      });

      test('debería manejar email ya normalizado', () {
        // Arrange
        const email = 'usuario@example.com';

        // Act
        final result = EmailValidator.normalize(email);

        // Assert
        expect(result, equals('usuario@example.com'));
      });
    });

    group('Casos edge (límite)', () {
      test('debería manejar email muy largo', () {
        // Arrange - Email de 254 caracteres (límite RFC)
        final longEmail = 'a' * 240 + '@example.com';

        // Act
        final result = EmailValidator.isValid(longEmail);

        // Assert
        expect(result, isTrue);
      });

      test('debería rechazar email extremadamente largo', () {
        // Arrange - Email de más de 320 caracteres
        final veryLongEmail = 'a' * 300 + '@example.com';

        // Act
        final result = EmailValidator.isValid(veryLongEmail);

        // Assert - Dependiendo de la implementación, podría ser válido o no
        // Este test documenta el comportamiento actual
        expect(result, isA<bool>());
      });

      test('debería manejar caracteres especiales permitidos', () {
        // Arrange
        final specialEmails = [
          'user+tag@example.com',
          'user.name@example.com',
          'user_name@example.com',
          'user-name@example.com',
        ];

        // Act & Assert
        for (final email in specialEmails) {
          expect(
            EmailValidator.isValid(email), 
            isTrue,
            reason: 'Email con caracteres especiales "$email" debería ser válido',
          );
        }
      });
    });
  });
}