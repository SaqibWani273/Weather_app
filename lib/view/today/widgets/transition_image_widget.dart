import 'package:flutter/material.dart';

class TransitionImageWidget extends StatefulWidget {
  final String url;
  const TransitionImageWidget(this.url, {super.key});

  @override
  State<TransitionImageWidget> createState() => _TransitionImageWidgetState();
}

class _TransitionImageWidgetState extends State<TransitionImageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    // _animation = Tween<double>(
    //   begin: 0.2, // Starting opacity (fully transparent)
    //   end: 1.0, // Ending opacity (fully opaque)
    // ).animate(animationController);
    _animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    // Start the animation
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Image.network(
        widget.url,
        fit: BoxFit.fill,
      ),
    );
  }
}
