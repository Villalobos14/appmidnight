// test/login_ui_simple_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practica_1/presentation/screen/login_screen.dart';

void main() {
  group('Login Screen UI Tests', () {
    // Helper para crear la pantalla de login con MaterialApp
    Widget createLoginScreen() {
      return MaterialApp(
        home: const LoginScreen(),
        routes: {
          '/products': (context) => const Scaffold(
            body: Center(child: Text('Products Screen')),
          ),
        },
      );
    }

    testWidgets('debería mostrar todos los elementos básicos de la UI', (tester) async {
      // Act - Construir la pantalla
      await tester.pumpWidget(createLoginScreen());

      // Assert - Verificar que todos los elementos principales están presentes
      expect(find.text('Login to your\naccount!'), findsOneWidget);
      expect(find.text("Welcome back. We're here to help you!"), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2)); // Email y Password
      expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
      expect(find.text("Don't have an account?"), findsOneWidget);
      expect(find.text("Sign Up"), findsOneWidget);
      expect(find.text('Continue with Google'), findsOneWidget);
      expect(find.text('Google Sign In Available'), findsOneWidget);
    });

    testWidgets('debería permitir ingresar texto en los campos de email y password', (tester) async {
      // Arrange
      await tester.pumpWidget(createLoginScreen());

      // Act - Ingresar texto en el campo de email
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email').first,
        'usuario@test.com',
      );

      // Act - Ingresar texto en el campo de password
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password').first,
        'mipassword123',
      );

      await tester.pump(); // Rebuild después de los cambios

      // Assert - Verificar que el texto se ingresó correctamente
      expect(find.text('usuario@test.com'), findsOneWidget);
      expect(find.text('mipassword123'), findsOneWidget);
    });

    testWidgets('debería mostrar/ocultar password al tocar el icono', (tester) async {
      // Arrange
      await tester.pumpWidget(createLoginScreen());

      // Assert - Verificar estado inicial (password oculto)
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      expect(find.byIcon(Icons.visibility), findsNothing);

      // Act - Tocar el icono para mostrar password
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      // Assert - Verificar que cambió a visible
      expect(find.byIcon(Icons.visibility), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off), findsNothing);

      // Act - Tocar nuevamente para ocultar
      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pump();

      // Assert - Verificar que volvió a oculto
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      expect(find.byIcon(Icons.visibility), findsNothing);
    });

    testWidgets('debería mostrar SnackBar al presionar botón de Login', (tester) async {
      // Arrange
      await tester.pumpWidget(createLoginScreen());

      // Act - Presionar el botón de Login
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pump(); // Procesar el tap
      
      // Assert - Verificar que aparece el SnackBar
      expect(find.byType(SnackBar), findsOneWidget);
      expect(
        find.text('Email login coming soon! Use Google Sign In for now.'), 
        findsOneWidget,
      );
    });

    testWidgets('debería mostrar SnackBar al presionar "Sign Up"', (tester) async {
      // Arrange
      await tester.pumpWidget(createLoginScreen());

      // Act - Presionar el texto "Sign Up"
      await tester.tap(find.text('Sign Up'));
      await tester.pump();

      // Assert - Verificar que aparece el SnackBar correspondiente
      expect(find.byType(SnackBar), findsOneWidget);
      expect(
        find.text('Registration coming soon! Use Google Sign In for now.'), 
        findsOneWidget,
      );
    });

    testWidgets('debería tener estructura responsive con SingleChildScrollView', (tester) async {
      // Arrange - Simular pantalla pequeña
      tester.view.physicalSize = const Size(360, 640);
      tester.view.devicePixelRatio = 1.0;

      // Act
      await tester.pumpWidget(createLoginScreen());

      // Assert - Verificar que tiene scroll para pantallas pequeñas
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(LoginScreen), findsOneWidget);

      // Cleanup
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
    });
  });
}