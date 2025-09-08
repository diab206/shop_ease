import 'dart:async';
import 'package:flutter/material.dart';
import 'offer_card.dart';

class AnimatedOfferCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String badgeText;
  final int delay; // in milliseconds

  const AnimatedOfferCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.badgeText,
    this.delay = 0,
  });

  @override
  State<AnimatedOfferCard> createState() => _AnimatedOfferCardState();
}

class _AnimatedOfferCardState extends State<AnimatedOfferCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  // ignore: unused_field
  late Animation<double> _fadeAnimation;
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        setState(() => _visible = true);
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: const Duration(milliseconds: 400),
      child: SlideTransition(
        position: _slideAnimation,
        child: OfferCard(
          title: widget.title,
          subtitle: widget.subtitle,
          badgeText: widget.badgeText,
        ),
      ),
    );
  }
}
