import 'package:flutter/widgets.dart';

/// In the context of a scrollable view, your children's animations are only built
/// as the user scrolls and they appear on the screen.
///
/// This create a situation
/// where your animations will be run as you scroll through the content.
///
/// If this is not a behaviour you want in your app, you can use AnimationLimiter.
///
/// AnimationLimiter is an InheritedWidget that prevents the children widgets to be
/// animated if they don't appear in the first frame where AnimationLimiter is built.
///
/// To be effective, AnimationLimiter musts be a direct parent of your scrollable list of widgets.
class AnimationLimiter extends StatefulWidget {
  /// The child Widget to animate.
  final Widget child;

  /// Creates an [AnimationLimiter] that will prevents the children widgets to be
  /// animated if they don't appear in the first frame where AnimationLimiter is built.
  ///
  /// The [child] argument must not be null.
  const AnimationLimiter({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _AnimationLimiterState createState() => _AnimationLimiterState();

  static bool? shouldRunAnimation(BuildContext context) {
    return _AnimationLimiterProvider.of(context)?.shouldRunAnimation;
  }
}

class _AnimationLimiterState extends State<AnimationLimiter> {
  bool _shouldRunAnimation = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((Duration value) {
      if (!mounted) return;
      setState(() {
        _shouldRunAnimation = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _AnimationLimiterProvider(
      shouldRunAnimation: _shouldRunAnimation,
      child: widget.child,
    );
  }
}

class _AnimationLimiterProvider extends InheritedWidget {
  final bool? shouldRunAnimation;

  _AnimationLimiterProvider({
    this.shouldRunAnimation,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static _AnimationLimiterProvider? of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<_AnimationLimiterProvider>();
  }
}
