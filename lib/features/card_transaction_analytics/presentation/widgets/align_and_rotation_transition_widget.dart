import 'package:flutter/material.dart';
import 'package:flutter_task/core/utils/utils.dart';

class AlignAndRoationTransitionWidget extends StatefulWidget {
  const AlignAndRoationTransitionWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AlignAndRoationTransitionWidget> createState() =>
      _AlignAndRoationTransitionWidgetState();
}

class _AlignAndRoationTransitionWidgetState
    extends State<AlignAndRoationTransitionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<AlignmentGeometry> _alignAnimation;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _alignAnimation = Tween<AlignmentGeometry>(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.s4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AlignTransition(
            alignment: _alignAnimation,
            child: RotationTransition(
              turns: _rotationAnimation,
              child: const AnimatedIconWidget(
                icon: Icons.shopping_bag_outlined,
                iconColor: AppColors.lavenderLustre,
                gradientColors: [
                  AppColors.lavenderLustre,
                  AppColors.crystalFalls,
                  AppColors.lavenderLustre,
                ],
              ),
            ),
          ),
          AlignTransition(
            alignment: _alignAnimation,
            child: RotationTransition(
              turns: _rotationAnimation,
              child: const AnimatedIconWidget(
                icon: Icons.favorite_border,
                iconColor: AppColors.floweringCactus,
                gradientColors: [
                  AppColors.floweringCactus,
                  AppColors.aquaTint,
                  AppColors.floweringCactus,
                ],
              ),
            ),
          ),
          AlignTransition(
            alignment: _alignAnimation,
            child: RotationTransition(
              turns: _rotationAnimation,
              child: const AnimatedIconWidget(
                icon: Icons.airplanemode_active_outlined,
                iconColor: AppColors.poodleSkirt,
                gradientColors: [
                  AppColors.poodleSkirt,
                  AppColors.justPinkEnough,
                  AppColors.poodleSkirt,
                ],
              ),
            ),
          ),
          AlignTransition(
            alignment: _alignAnimation,
            child: RotationTransition(
              turns: _rotationAnimation,
              child: const AnimatedIconWidget(
                icon: Icons.local_pizza_outlined,
                iconColor: AppColors.porcellana,
                gradientColors: [
                  AppColors.porcellana,
                  AppColors.strawberryDust,
                  AppColors.porcellana,
                ],
              ),
            ),
          ),
          AlignTransition(
            alignment: _alignAnimation,
            child: RotationTransition(
              turns: _rotationAnimation,
              child: const AnimatedIconWidget(
                icon: Icons.percent,
                iconColor: AppColors.blueHydrangea,
                gradientColors: [
                  AppColors.blueHydrangea,
                  AppColors.aircraftWhite,
                  AppColors.blueHydrangea,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedIconWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final List<Color> gradientColors;
  const AnimatedIconWidget({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white),
      ),
      child: Icon(
        icon,
        color: iconColor,
      ),
    );
  }
}
