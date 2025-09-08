import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_ease/core/providers/localization_provider.dart';

import 'package:shop_ease/core/widgets/carousel_slider.dart';
import 'package:shop_ease/core/widgets/offers/offers_list.dart';
import 'package:shop_ease/core/widgets/productCard/product_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationProvider>(
      builder: (context, localization, _) {
        return Directionality(
          textDirection:
              localization.isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              title: Text(localization.text("ShopEase", "تسوق بسهولة")),
              actions: [
                // 🔘 Language toggle button
                TextButton(
                  onPressed: () => localization.toggleLanguage(),
                  child: Text(
                    localization.isArabic ? "EN" : "عربي",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Featured section
                    Text(
                      localization.text("Featured Products", "منتجات مميزة"),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const BannerCarousel(),

                    const SizedBox(height: 20),

                    // Shop Collection section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          localization.text(
                            "Shop Our Collection",
                            "تسوق مجموعتنا",
                          ),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const ProductGrid(),

                    const SizedBox(height: 10),

                    // Hot Offers
                    Text(
                      localization.text("Hot Offers 🔥", "العروض الساخنة 🔥"),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    const OffersList(), // Reusable widget
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
