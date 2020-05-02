import 'package:flutter/widgets.dart';
import 'animation_configuration.dart';
import 'animation_executor.dart';

class AnimationConfigurator extends StatelessWidget {
  final Duration duration;
  final Duration delay;
  final Widget Function(Animation<double>) animatedChildBuilder;

  const AnimationConfigurator({
    Key key,
    this.duration,
    this.delay,
    @required this.animatedChildBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animationConfiguration = AnimationConfiguration.of(context);

    if (animationConfiguration == null) {
      throw FlutterError.fromParts(
        <DiagnosticsNode>[
          ErrorSummary('Animation not wrapped in an AnimationConfiguration.'),
          ErrorDescription(
              'This error happens if you use an Animation that is not wrapped in an '
              'AnimationConfiguration.'),
          ErrorHint(
              'The solution is to wrap your Animation(s) with an AnimationConfiguration. '
              'Reminder: an AnimationConfiguration provides the configuration '
              'used as a base for every children Animation. Configuration made in AnimationConfiguration '
              'can be overridden in Animation children if needed.'),
        ],
      );
    }

    final _position = animationConfiguration.position ?? 0 + 1;
    final _duration = duration ?? animationConfiguration.duration;
    final _delay = delay ?? animationConfiguration.delay;
    final _columnCount = animationConfiguration.columnCount;
    final _resetDelayEvery = animationConfiguration.resetDelayEvery;

    return AnimationExecutor(
      duration: _duration,
      delay:
          stagger(_position, _duration, _delay, _columnCount, _resetDelayEvery),
      builder: (context, animationController) =>
          animatedChildBuilder(animationController),
    );
  }

  Duration stagger(int position, Duration duration, Duration delay,
      int columnCount, int resetDelayEvery) {
    final delayInMilliseconds =
        (delay?.inMilliseconds ?? duration.inMilliseconds ~/ 6);

    int _computeStaggeredGridDuration() {
      var row = position ~/ columnCount;
      if (resetDelayEvery != null) {
        row = row % resetDelayEvery;
      }
      var calculatedPosition = row + position % columnCount;
      return calculatedPosition * delayInMilliseconds;
    }

    int _computeStaggeredListDuration() {
      if (resetDelayEvery != null) {
        return (position ~/ resetDelayEvery) * delayInMilliseconds;
      }

      return position * delayInMilliseconds;
    }

    return Duration(
        milliseconds: columnCount > 1
            ? _computeStaggeredGridDuration()
            : _computeStaggeredListDuration());
  }
}
