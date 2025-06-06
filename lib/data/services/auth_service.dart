// lib/data/services/auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login con email y password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw Exception('No se encontró un usuario con este email');
        case 'wrong-password':
          throw Exception('Contraseña incorrecta');
        case 'invalid-email':
          throw Exception('Email inválido');
        case 'user-disabled':
          throw Exception('Esta cuenta ha sido deshabilitada');
        default:
          throw Exception('Error de autenticación: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }

  // Registro con email y password
  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw Exception('La contraseña es muy débil');
        case 'email-already-in-use':
          throw Exception('Ya existe una cuenta con este email');
        case 'invalid-email':
          throw Exception('Email inválido');
        default:
          throw Exception('Error al crear cuenta: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }

  // Logout
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Error al cerrar sesión: $e');
    }
  }

  // Obtener usuario actual
  User? get currentUser => _auth.currentUser;

  // Stream para escuchar cambios de autenticación
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Verificar si está autenticado
  bool get isSignedIn => currentUser != null;

  // Enviar email de restablecimiento de contraseña
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw Exception('No se encontró un usuario con este email');
        case 'invalid-email':
          throw Exception('Email inválido');
        default:
          throw Exception('Error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }
}