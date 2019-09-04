import 'package:flutter/material.dart';

/// Automatically rebuild [child] widget after the given [duration]
class AutoRefresh extends StatefulWidget {
  final Duration duration;
  final Widget child;

  AutoRefresh({
    Key key,
    @required this.duration,
    @required this.child,
  })  : assert(duration != null),
        super(key: key);

  @override
  _AutoRefreshState createState() => _AutoRefreshState();
}

class _AutoRefreshState extends State<AutoRefresh> {
  int keyValue;
  ValueKey key;

  @override
  void initState() {
    super.initState();

    keyValue = 0;
    key = ValueKey(keyValue);

    _recursiveBuild();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: widget.child,
    );
  }

  void _recursiveBuild() {
    Future.delayed(
      widget.duration,
      () {
        setState(() {
          keyValue = keyValue + 1;
          key = ValueKey(keyValue);
          _recursiveBuild();
        });
      },
    );
  }
}
