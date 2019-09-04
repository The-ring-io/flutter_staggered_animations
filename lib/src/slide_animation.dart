import 'package:flutter/widgets.dart';
import 'animation_configurator.dart';

/// An animation that slides its child.
class SlideAnimation extends StatelessWidget {
  /// The duration of the child animation.
  final Duration duration;

  /// The delay between the beginning of two children's animations.
  final Duration delay;

  /// The vertical offset to apply at the start of the animation (can be negative).
  final double verticalOffset;

  /// The horizontal offset to apply at the start of the animation (can be negative).
  final double horizontalOffset;

  /// The child Widget to animate.
  final Widget child;

  /// Creates a slide animation that slides its child from the given
  /// [verticalOffset] and [horizontalOffset] to its final position.
  ///
  /// A default value of 50.0 is applied to [verticalOffset] if
  /// [verticalOffset] and [horizontalOffset] are both undefined or null.
  ///
  /// The [child] argument must not be null.
  const SlideAnimation({
    Key key,
    this.duration,
    this.delay,
    verticalOffset,
    this.horizontalOffset = 0.0,
    @required this.child,
  })  : this.verticalOffset = (verticalOffset == null && horizontalOffset == null) ? 50.0 : (verticalOffset ?? 0.0),
        assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfigurator(
      duration: duration,
      delay: delay,
      animatedChildBuilder: _slideAnimation,
    );
  }

  Widget _slideAnimation(animationController) {
    Animation<double> offsetAnimation(double offset, AnimationController animationController) {
      return Tween<double>(begin: offset, end: 0.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Interval(0.0, 1.0, curve: Curves.ease),
        ),
      );
    }

    return Transform.translate(
      offset: Offset(
        horizontalOffset == 0.0 ? 0.0 : offsetAnimation(horizontalOffset, animationController).value,
        verticalOffset == 0.0 ? 0.0 : offsetAnimation(verticalOffset, animationController).value,
      ),
      child: child,
    );
  }
}
