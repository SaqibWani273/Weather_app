import 'package:flutter/material.dart';

class TransitionImageWidget extends StatefulWidget {
  final String url;
  final bool isAssetFile;
  const TransitionImageWidget(this.url, {super.key, required this.isAssetFile});

  @override
  State<TransitionImageWidget> createState() => _TransitionImageWidgetState();
}

class _TransitionImageWidgetState extends State<TransitionImageWidget>
    with SingleTickerProviderStateMixin {
  var isFirstBuild = true;
  late AnimationController animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    // Start the animation
    animationController.forward();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      isFirstBuild = false;
    });
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isFirstBuild) {
      //note: this is working as expected but might cause issues in ux
      animationController.forward(from: 0.2);
    }

    return FadeTransition(
      opacity: _animation,
      child: widget.isAssetFile
          ? Image.asset(widget.url, fit: BoxFit.fill)
          : Image.network(
              widget.url,
              fit: BoxFit.fill,
            ),
    );
  }
}
