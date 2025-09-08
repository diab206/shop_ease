import 'package:flutter/material.dart';
import 'package:shop_ease/core/widgets/carousel_slider.dart';
import 'package:shop_ease/core/widgets/offers/offers_list.dart';
import 'package:shop_ease/core/widgets/productCard/product_grid.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("YallaNebi3")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              SizedBox(height: 20),
              Text('Featured Products', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              BannerCarousel(),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Center(
                    child: Text(
                      "Shop Our Collection",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              ProductGrid(),
               SizedBox(height: 10),
              Text(
                "Hot Offers 🔥",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              OffersList(), // Reusable widget
            ],
          ),
        ),
      ),
    );
  }
}
