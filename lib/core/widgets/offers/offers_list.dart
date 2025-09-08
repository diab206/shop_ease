import 'package:flutter/material.dart';
import 'package:shop_ease/core/widgets/offers/animated_offer_card.dart';

class OffersList extends StatefulWidget {
  const OffersList({super.key});

  @override
  State<OffersList> createState() => _OffersListState();
}

class _OffersListState extends State<OffersList>
    with SingleTickerProviderStateMixin {
  final List<Map<String, String>> _offers = [
    {
      "title": "50% Off Electronics",
      "subtitle": "Limited time offer on all tech gadgets",
      "badge": "50% OFF"
    },
    {
      "title": "Free Shipping Weekend",
      "subtitle": "No delivery charges on orders above \$50",
      "badge": "FREE SHIP"
    },
    {
      "title": "Buy 2 Get 1 Free",
      "subtitle": "On selected accessories and peripherals",
      "badge": "B2G1"
    },
    {
      "title": "Student Discount",
      "subtitle": "Extra 20% off with valid student ID",
      "badge": "20% OFF"
    },
    {
      "title": "Bundle Deals",
      "subtitle": "Save more when you buy complete setups",
      "badge": "BUNDLE"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(_offers.length, (index) {
        final offer = _offers[index];
        return AnimatedOfferCard(
          title: offer["title"]!,
          subtitle: offer["subtitle"]!,
          badgeText: offer["badge"]!,
          delay: index * 300, // each card animates with delay
        );
      }),
    );
  }
}
