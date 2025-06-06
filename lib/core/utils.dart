// lib/core/utils.dart
// Esta clase contiene utilidades comunes para la aplicación

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

class StringUtils {
  // Validar si un string no está vacío
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }
  
  // Capitalizar primera letra
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
  
  // Truncar texto con ellipsis
  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
}

class PriceUtils {
  // Formatear precio a string con símbolo de moneda
  static String formatPrice(double price, {String currency = '\$'}) {
    return '$currency${price.toStringAsFixed(2)}';
  }
  
  // Calcular descuento
  static double calculateDiscount(double originalPrice, double discountPercent) {
    return originalPrice * (discountPercent / 100);
  }
  
  // Precio final después del descuento
  static double getFinalPrice(double originalPrice, double discountPercent) {
    final discount = calculateDiscount(originalPrice, discountPercent);
    return originalPrice - discount;
  }
}