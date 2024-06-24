import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(), // Adds flexible space above the animation
        Transform.scale(
          scale: 0.8, // Adjust the scale factor as needed
          child: Lottie.asset(
            "assets/animation/Animation - 1719177251039.json",
            controller: _controller,
            onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                ..forward().then((value) => _controller.stop()); // Play once and stop
            },
          ),
        ),
        const Spacer(flex: 8), // Adds more flexible space below the animation
      ],
    );
  }
}
