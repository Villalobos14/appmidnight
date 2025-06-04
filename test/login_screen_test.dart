import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practica_1/presentation/screen/login_screen.dart';

void main() {
  testWidgets('LoginScreen muestra los campos y botón básicos', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    expect(
      find.byType(TextField),
      findsNWidgets(2),
      reason:
          'Debe haber exactamente 2 TextField: uno para email/user y otro para password.',
    );

    expect(
      find.widgetWithText(TextField, 'Email / Username'),
      findsOneWidget,
      reason: 'Debe existir un TextField con hint "Email / Username".',
    );

    expect(
      find.widgetWithText(TextField, 'Password'),
      findsOneWidget,
      reason: 'Debe existir un TextField con hint "Password".',
    );

    expect(
      find.widgetWithText(ElevatedButton, 'Login'),
      findsOneWidget,
      reason: 'Debe haber un ElevatedButton cuyo texto sea "Login".',
    );

    expect(
      find.text('Login to your\naccount!'),
      findsOneWidget,
      reason: 'Debe verse el título principal "Login to your\\naccount!".',
    );

    expect(
      find.text("Don't have an account?"),
      findsOneWidget,
      reason: 'Debe mostrar la frase "Don\'t have an account?"',
    );
    expect(
      find.text("Sign Up"),
      findsOneWidget,
      reason: 'Debe mostrar el enlace “Sign Up”.',
    );
  });
}
