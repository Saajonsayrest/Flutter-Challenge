import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

final CatmullRomSpline path1 = CatmullRomSpline(
  const <Offset>[
    Offset(0.06, 0.42),
    Offset(0.07, 0.37),
    Offset(0.08, 0.42),
    Offset(0.088, 0.527),
  ],
  startHandle: const Offset(1, 1),
  endHandle: const Offset(0, 0),
);
final CatmullRomSpline path2 = CatmullRomSpline(
  const <Offset>[
    Offset(0.16, 0.42),
    Offset(0.125, 0.38),
    Offset(0.100, 0.42),
    Offset(0.088, 0.527),
  ],
  startHandle: const Offset(1, 1),
  endHandle: const Offset(0, 0),
);
final CatmullRomSpline path3 = CatmullRomSpline(
  const <Offset>[
    Offset(0.31, 0.42),
    Offset(0.2, 0.38),
    Offset(0.1, 0.42),
    Offset(0.088, 0.527),
  ],
  startHandle: const Offset(1, 1),
  endHandle: const Offset(0, 0),
);

class Animations extends StatefulWidget {
  Animations({Key? key, required this.reactionName}) : super(key: key);
  String reactionName;

  @override
  State<Animations> createState() => _AnimationsState();
}

class _AnimationsState extends State<Animations> with TickerProviderStateMixin {
  late AnimationController controller;
  bool isAnimationVisible = true;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this)
      ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.stop();
        controller.reset();
        controller.forward();
        setState(() {
          isAnimationVisible = false;
        });
      }
    });
    controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Offset curvePathFunction() {
    if (widget.reactionName == 'like_button') {
      return path1.transform(animation.value) * 2.0 - const Offset(1.0, 1.0);
    } else if (widget.reactionName == 'heart_button') {
      return path2.transform(animation.value) * 2.0 - const Offset(1.0, 1.0);
    } else {
      return path3.transform(animation.value) * 2.0 - const Offset(1.0, 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Offset position = curvePathFunction();
    return Visibility(
      visible: isAnimationVisible,
      child: Stack(
        children: [
          Text(widget.reactionName),
          Align(
              alignment: Alignment(position.dx, position.dy),
              child: SvgPicture.asset(
                'assets/svg/${widget.reactionName}.svg',
                width: 19,
              ))
        ],
      ),
    );
  }
}
