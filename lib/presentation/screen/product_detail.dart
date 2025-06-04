import 'package:flutter/material.dart';
import '../../../data/models/product_model.dart';
import "../../data/services/cart_service.dart";

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.image,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(product.description, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text(
              'Precio: \$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Categoría: ${product.category}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'Calificación: ${product.rating.rate} (${product.rating.count} votos)',
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Cart.add(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${product.title} agregado al carrito"),
                    ),
                  );
                },
                child: const Text("Agregar al carrito"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
