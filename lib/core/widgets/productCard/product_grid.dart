import 'package:flutter/material.dart';
import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  final List<Map<String, dynamic>> products = const [
    {"name": "iPhone 14", "image": "assets/images/iphone.jpg", "price": 999.99},
    {"name": "Nike Shoes", "image": "assets/images/nike.jpg", "price": 120.00},
    {"name": "Smart Watch", "image": "assets/images/watch.jpg", "price": 250.50},
    {"name": "iPhone 14", "image": "assets/images/iphone.jpg", "price": 150.00},
    {"name": "Nike Shoes", "image": "assets/images/nike.jpg", "price": 1999.00},
    {"name": "Smart Watch", "image": "assets/images/watch.jpg", "price": 80.00},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // two per row
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.70, // ⬆️ bigger cards
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          name: product["name"],
          image: product["image"],
          price: product["price"],
        );
      },
    );
  }
}
