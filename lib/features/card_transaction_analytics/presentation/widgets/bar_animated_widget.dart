import 'package:flutter/material.dart';
import 'package:flutter_task/core/utils/utils.dart';

class BarAnimatedWidget extends StatefulWidget {
  const BarAnimatedWidget({Key? key}) : super(key: key);

  @override
  BarAnimatedWidgetState createState() => BarAnimatedWidgetState();
}

class BarAnimatedWidgetState extends State<BarAnimatedWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Column(
          children: [
            LinearGradientContainer(
              controller: _controller,
              colors: const [
                AppColors.lavenderLustre,
                AppColors.crystalFalls,
                AppColors.lavenderLustre,
              ],
            ),
            LinearGradientContainer(
              controller: _controller,
              colors: const [
                AppColors.floweringCactus,
                AppColors.aquaTint,
                AppColors.floweringCactus,
              ],
            ),
            LinearGradientContainer(
              controller: _controller,
              colors: const [
                AppColors.poodleSkirt,
                AppColors.justPinkEnough,
                AppColors.poodleSkirt,
              ],
            ),
            LinearGradientContainer(
              controller: _controller,
              colors: const [
                AppColors.porcellana,
                AppColors.strawberryDust,
                AppColors.porcellana,
              ],
            ),
            LinearGradientContainer(
              controller: _controller,
              colors: const [
                AppColors.blueHydrangea,
                AppColors.aircraftWhite,
                AppColors.blueHydrangea,
              ],
            ),
          ],
        );
      },
    );
  }
}

class LinearGradientContainer extends StatelessWidget {
  final List<Color> colors;
  const LinearGradientContainer({
    super.key,
    required AnimationController controller,
    required this.colors,
  }) : _controller = controller;

  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          stops: [0, _controller.value, 1],
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white),
      ),
    );
  }
}
