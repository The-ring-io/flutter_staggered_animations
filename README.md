# Flutter Staggered Animations

Easily add staggered animations to your `ListView`, `GridView`, `Column` and `Row` children as shown in [Material Design guidelines](https://material.io/design/motion/customization.html#sequencing)

## Showcase

| ListView                  | GridView                   | Column                       |
| ---                       | ---                        | ---                          |
|![](https://github.com/mobiten/flutter_staggered_animations/blob/master/assets/card_list.gif?raw=true)  | ![](https://github.com/mobiten/flutter_staggered_animations/blob/master/assets/card_grid.gif?raw=true)  | ![](https://github.com/mobiten/flutter_staggered_animations/blob/master/assets/card_column.gif?raw=true)  |

## Flutter 2.0 and null-safety

From 1.0.0 and onwards, `flutter_staggered_animations` is null-safe and requires Dart SDK 2.12.0 minimum.
If you want to keep using `flutter_staggered_animations` but cannot migrate to null-safety yet, use the version 0.1.3 instead.

## Installation

### Dependency
Add the package as a dependency in your pubspec.yaml file.
```yaml
dependencies:
  flutter_staggered_animations: "^1.0.0"
```

### Import
Import the package in your code file.
```dart
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
```

## Basic usage
Here is a sample code to apply a staggered animation on `ListView` items.
```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: AnimationLimiter(
      child: ListView.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: YourListChild(),
              ),
            ),
          );
        },
      ),
    ),
  );
}
```


## API Overview

This package contains three type of classes:
- Animation
- AnimationConfiguration
- AnimationLimiter


### Animations

Animations are split into 4 classes: 
- `FadeInAnimation`
- `SlideAnimation`
- `ScaleAnimation`
- `FlipAnimation`

Animations can be composed to produce advanced animations effects by wrapping them.

Example of a SlideAnimation combined with a FadeInAnimation:
```dart
child: SlideAnimation(
  verticalOffset: 50.0,
    child: FadeInAnimation(
      child: YourListChild(),
    ),
)
```

Animations must be direct children of `AnimationConfiguration`.


### AnimationConfiguration  

`AnimationConfiguration` is an `InheritedWidget` that shares its animation settings with its children (mainly duration and delay).

#### Named constructors

Depending on the scenario in which you will present your animations, you should use one of `AnimationConfiguration`'s named constructors. 

- `AnimationConfiguration.synchronized` if you want to launch all children's animations at the same time.
- `AnimationConfiguration.staggeredList` if you want to delay the animation of each child to produce a single-axis staggered animations (from top to bottom or from left to right).
- `AnimationConfiguration.staggeredGrid` if you want to delay the animation of each child to produce a dual-axis staggered animations (from left to right and top to bottom).

If you're not in the context of a `ListView` or `GridView`, an utility static method is available to help you apply staggered animations to the children of a `Row` or `Column`:

- `AnimationConfiguration.toStaggeredList`

> You can override `duration` and `delay` in each child Animation if needed.


### AnimationLimiter

In the context of a scrollable view, your children's animations are only built when the user scrolls and they appear on the screen.
This create a situation where your animations will be run as you scroll through the content. If this is not a behaviour you want in your app, you can use `AnimationLimiter`.

`AnimationLimiter` is an `InheritedWidget` that prevents the children widgets to be animated if they don't appear in the first frame where `AnimationLimiter` is built.

To be effective, `AnimationLimiter` must be a direct parent of your scrollable list of widgets.

> You can omit `AnimationLimiter` if your view is not scrollable.

##  Quick samples 

### ListView

Here is a sample code to apply a staggered animation on the children of a `ListView`.

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: AnimationLimiter(
      child: ListView.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: YourListChild(),
              ),
            ),
          );
        },
      ),
    ),
  );
}
```

### GridView

Here is a sample code to apply a staggered animation on the children of a `GridView`.

```dart
@override
Widget build(BuildContext context) {
  int columnCount = 3;

  return Scaffold(
    body: AnimationLimiter(
      child: GridView.count(
        crossAxisCount: columnCount,
        children: List.generate(
          100,
          (int index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 375),
              columnCount: columnCount,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: YourListChild(),
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}
```

### Column

Here is a sample code to apply a staggered animation on the children of a `Column`.

```dart
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: AnimationLimiter(
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: YourColumnChildren(),
            ),
          ),
        ),
      ),
    );
  }
```

## License

Flutter Staggered Animations is released under the [MIT License](LICENSE)

## About us

We are a french mobile design and development team.

Website : <a href="https://www.mobiten.com" target="_blank">https://www.mobiten.com</a>

<a href="https://www.mobiten.com" target="_blank">
    <img src="https://raw.githubusercontent.com/mobiten/flutter_staggered_animations/develop/assets/mobiten_white_on_black.png" height="56">
</a>
