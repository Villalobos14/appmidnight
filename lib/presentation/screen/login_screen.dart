import 'package:flutter/material.dart';
import '../../../data/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  bool _isLoading = false;
  
  // Controladores para los campos de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Función para login con email/password
  void _handleEmailLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final user = await AuthService().signInWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text,
      );
      
      if (user != null && mounted) {
        Navigator.pushReplacementNamed(context, '/products');
      } else {
        _showErrorMessage("Credenciales incorrectas");
      }
    } catch (e) {
      _showErrorMessage("Error en el login: $e");
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // Función para registro
  void _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final user = await AuthService().registerWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text,
      );
      
      if (user != null && mounted) {
        Navigator.pushReplacementNamed(context, '/products');
      } else {
        _showErrorMessage("Error al crear la cuenta");
      }
    } catch (e) {
      _showErrorMessage("Error en el registro: $e");
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // Login temporal sin autenticación (para testing)
  void _handleTemporaryLogin() {
    Navigator.pushReplacementNamed(context, '/products');
  }

  void _showErrorMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email es requerido';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Email inválido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password es requerido';
    }
    if (value.length < 6) {
      return 'Password debe tener al menos 6 caracteres';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 14, 13, 13),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                const Text(
                  "Login to your\naccount!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 38,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 12),
                const Text(
                  "Welcome back. We're here to help you!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 32),

                // Campo de Email con validación
                TextFormField(
                  controller: _emailController,
                  validator: _validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    filled: true,
                    fillColor: const Color(0xFF1E1E1E),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),

                // Campo de Password con validación
                TextFormField(
                  controller: _passwordController,
                  validator: _validatePassword,
                  obscureText: _obscurePassword,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    filled: true,
                    fillColor: const Color(0xFF1E1E1E),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey[600],
                      ),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Botón de Login
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleEmailLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    child: _isLoading 
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.black,
                            ),
                          )
                        : const Text("Login"),
                  ),
                ),

                const SizedBox(height: 16),

                // Enlace para registro
                GestureDetector(
                  onTap: _isLoading ? null : _handleRegister,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "Sign Up",
                          style: TextStyle(
                            color: Color.fromARGB(255, 35, 194, 17),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Botón temporal para continuar sin autenticación
                _socialButton(
                  icon: Icons.skip_next,
                  label: "Continue without login (Temporal)",
                  onTap: _handleTemporaryLogin,
                ),

                const SizedBox(height: 12),

                // Botones sociales deshabilitados temporalmente
                _socialButton(
                  icon: Icons.facebook,
                  label: "Continue with Facebook (Próximamente)",
                  onTap: () {
                    _showErrorMessage("Facebook login próximamente");
                  },
                ),
                const SizedBox(height: 12),
                
                _socialButton(
                  icon: Icons.g_mobiledata,
                  label: "Continue with Google (Próximamente)",
                  onTap: () {
                    _showErrorMessage("Google login próximamente");
                  },
                ),
                const SizedBox(height: 12),
                
                _socialButton(
                  icon: Icons.apple,
                  label: "Continue with Apple (Próximamente)",
                  onTap: () {
                    _showErrorMessage("Apple login próximamente");
                  },
                ),

                const SizedBox(height: 32),

                // Información de prueba
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.withOpacity(0.3)),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        "Para probar:",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "1. Usar 'Continue without login'\n2. O crear cuenta con email válido",
                        style: TextStyle(color: Colors.blue),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton({
    IconData? icon,
    String? iconAsset,
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(icon, size: 20, color: Colors.white)
            else if (iconAsset != null)
              Image.asset(iconAsset, height: 20),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                label,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}