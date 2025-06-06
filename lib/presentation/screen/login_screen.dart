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
  final AuthService authService = AuthService();
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleEmailLogin() async {
    _showInfoMessage("Email login coming soon! Use Google Sign In for now.");
  }

  void _handleRegister() async {
    _showInfoMessage("Registration coming soon! Use Google Sign In for now.");
  }

  void _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    try {
      final user = await authService.signInWithGoogle();
      if (user != null && mounted) {
        Navigator.pushReplacementNamed(context, '/products');
      } else {
        _showErrorMessage("Sign in cancelado");
      }
    } catch (e) {
      _showErrorMessage("Error al iniciar sesión con Google: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showErrorMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    }
  }

  void _showInfoMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.blue),
      );
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email es requerido';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Email inválido';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password es requerido';
    if (value.length < 6) return 'Password debe tener al menos 6 caracteres';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 14, 13, 13),
      body: SafeArea(
        top: true,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),

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

                  // Campo de Email
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

                  // Campo de Password
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
                      child: const Text("Login"),
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

                  // Botón de Google Sign In
                  _socialButton(
                    icon: Icons.g_mobiledata,
                    label: _isLoading ? "Signing in..." : "Continue with Google",
                    onTap: _isLoading ? null : _handleGoogleSignIn,
                    isGoogleButton: true,
                  ),

                  const SizedBox(height: 12),

                  // Facebook
                  _socialButton(
                    icon: Icons.facebook,
                    label: "Continue with Facebook",
                    onTap: _isLoading ? null : () {
                      _showInfoMessage("Facebook login coming soon!");
                    },
                  ),

                  const SizedBox(height: 12),

                  // Apple
                  _socialButton(
                    icon: Icons.apple,
                    label: "Continue with Apple",
                    onTap: _isLoading ? null : () {
                      _showInfoMessage("Apple login coming soon!");
                    },
                  ),

                  const SizedBox(height: 32),

                  // ────────── Cajita verde (altura = 50px) ──────────
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Google Sign In Available",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
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
      ),
    );
  }

  Widget _socialButton({
    IconData? icon,
    String? iconAsset,
    required String label,
    required VoidCallback? onTap,
    bool isGoogleButton = false,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        gradient: isGoogleButton && onTap != null
            ? const LinearGradient(
                colors: [Color(0xFF4285F4), Color(0xFF1565C0)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        color: !isGoogleButton 
            ? (onTap == null 
                ? const Color(0xFF1E1E1E).withOpacity(0.5)
                : const Color(0xFF1E1E1E))
            : null,
        borderRadius: BorderRadius.circular(20),
        boxShadow: isGoogleButton && onTap != null
            ? [
                BoxShadow(
                  color: const Color(0xFF4285F4).withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ]
            : null,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon, 
                size: 20, 
                color: onTap == null 
                    ? Colors.white.withOpacity(0.5)
                    : Colors.white,
              )
            else if (iconAsset != null)
              Image.asset(iconAsset, height: 20),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: onTap == null 
                      ? Colors.white.withOpacity(0.5)
                      : Colors.white,
                  fontWeight: isGoogleButton ? FontWeight.w600 : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (_isLoading && isGoogleButton) ...[
              const SizedBox(width: 10),
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
