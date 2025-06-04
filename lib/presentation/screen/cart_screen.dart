// lib/presentation/screen/cart_screen.dart

import 'package:flutter/material.dart';
import 'package:practica_1/data/services/cart_service.dart';

/// Pantalla que muestra los items en el carrito, permite eliminarlos y
/// muestra el total al pie.
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = Cart.items;

    return Scaffold(
      backgroundColor: const Color(0xFF0E0D0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        title: const Text(
          'Carrito de Compras',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: items.isEmpty
          ? const Center(
              child: Text(
                'El carrito está vacío',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final product = items[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        product.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      product.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.remove_shopping_cart,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {
                        Cart.remove(product);
                        // Reconstruimos la pantalla para reflejar cambio
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CartScreen()),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1E1E1E),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '\$${Cart.total.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.greenAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
