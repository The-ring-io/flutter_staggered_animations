import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../widgets/auto_refresh.dart';
import '../widgets/empty_card.dart';

class CardColumnScreen extends StatefulWidget {
  CardColumnScreen({Key? key}) : super(key: key);

  @override
  _CardColumnScreenState createState() => _CardColumnScreenState();
}

class _CardColumnScreenState extends State<CardColumnScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoRefresh(
      duration: const Duration(milliseconds: 2000),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: AnimationLimiter(
              child: Column(
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 375),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: MediaQuery.of(context).size.width / 2,
                    child: FadeInAnimation(child: widget),
                  ),
                  children: [
                    EmptyCard(
                      width: MediaQuery.of(context).size.width,
                      height: 166.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const EmptyCard(height: 50.0, width: 50.0),
                          const EmptyCard(height: 50.0, width: 50.0),
                          const EmptyCard(height: 50.0, width: 50.0),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Flexible(child: EmptyCard(height: 150.0)),
                        const Flexible(child: EmptyCard(height: 150.0)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          const Flexible(child: EmptyCard(height: 50.0)),
                          const Flexible(child: EmptyCard(height: 50.0)),
                          const Flexible(child: EmptyCard(height: 50.0)),
                        ],
                      ),
                    ),
                    EmptyCard(
                      width: MediaQuery.of(context).size.width,
                      height: 166.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
