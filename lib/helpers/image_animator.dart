import 'package:flutter/material.dart';

class ImageAnimator extends StatefulWidget {
  const ImageAnimator({super.key, this.duration, required this.child});
  final Duration? duration;
  final Widget? child;

  @override
  State<ImageAnimator> createState() => _ImageAnimatorState();
}

class _ImageAnimatorState extends State<ImageAnimator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration ?? const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    // _animation = CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.easeInOutCubic,
    // );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playAnimation() {
    if ((widget.key as ValueKey).value == 'man') {
      _controller.forward();
    }
    if ((widget.key as ValueKey).value == 'woman') {
      Future.delayed(const Duration(seconds: 2))
          .then((value) => _controller.forward());
    }
  }

  void _onEndAnimation() {
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse().then((value) => _controller.forward());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _playAnimation();
    _onEndAnimation();
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Transform.translate(
          offset: Offset(0, 5 * (1 - _animation.value)),
          child: widget.child,
        );
      },
    );
  }
}
