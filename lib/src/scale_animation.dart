import 'package:flutter/widgets.dart';
import 'animation_configurator.dart';

/// An animation that scales its child.
class ScaleAnimation extends StatelessWidget {
  /// The duration of the child animation.
  final Duration duration;

  /// The delay between the beginning of two children's animations.
  final Duration delay;

  /// Scaling factor to apply at the start of the animation.
  final double scale;

  /// The child Widget to animate.
  final Widget child;

  /// Creates a scale animation that scales its child for its center.
  ///
  /// Default value for [scale] is 0.0.
  ///
  /// The [child] argument must not be null.
  const ScaleAnimation({
    Key key,
    this.duration,
    this.delay,
    this.scale = 0.0,
    @required this.child,
  })  : assert(child != null),
        assert(scale != null && scale >= 0.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfigurator(
      duration: duration,
      delay: delay,
      animatedChildBuilder: _landingAnimation,
    );
  }

  Widget _landingAnimation(Animation<double> animation) {
    final _landingAnimation = Tween<double>(begin: scale, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(0.0, 1.0, curve: Curves.ease),
      ),
    );

    return Transform.scale(
      scale: _landingAnimation.value,
      child: child,
    );
  }
}
