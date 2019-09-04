import 'dart:math';
import 'package:flutter/widgets.dart';
import 'animation_configurator.dart';

/// An enum representing a flix axis.
///
/// [x] represents a vertical flip.
/// [y] represents a horizontal flip.
enum FlipAxis { x, y }

/// An animation that flips its child either vertically or horizontally.
class FlipAnimation extends StatelessWidget {
  /// The duration of the child animation.
  final Duration duration;

  /// The delay between the beginning of two children's animations.
  final Duration delay;

  /// The [FlipAxis] in which the child widget will be flipped.
  final FlipAxis flipAxis;

  /// The child Widget to animate.
  final Widget child;

  /// Creates a flip animation that flips its child.
  ///
  /// Default value for [flipAxis] is [FlipAxis.x].
  ///
  /// The [child] argument must not be null.
  const FlipAnimation({
    Key key,
    this.duration,
    this.delay,
    this.flipAxis = FlipAxis.x,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfigurator(
      duration: duration,
      delay: delay,
      animatedChildBuilder: _flipAnimation,
    );
  }

  Widget _flipAnimation(animationController) {
    final _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.0, 1.0, curve: Curves.ease),
      ),
    );

    Matrix4 _computeTransformationMatrix() {
      double radians = (1 - _flipAnimation.value) * pi / 2;

      switch (flipAxis) {
        case FlipAxis.y:
          return Matrix4.rotationY(radians);
        case FlipAxis.x:
        default:
          return Matrix4.rotationX(radians);
      }
    }

    return new Transform(
      transform: _computeTransformationMatrix(),
      alignment: Alignment.center,
      child: child,
    );
  }
}
