import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/utils/utils.dart';
import 'package:flutter_task/features/card_transaction_analytics/presentation/cubit/card_transaction_analytics_cubit.dart';

class SingleAlignAndRoationTransitionWidget extends StatefulWidget {
  final int index;
  const SingleAlignAndRoationTransitionWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<SingleAlignAndRoationTransitionWidget> createState() =>
      _SingleAlignAndRoationTransitionWidgetState();
}

class _SingleAlignAndRoationTransitionWidgetState
    extends State<SingleAlignAndRoationTransitionWidget>
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
      )..addStatusListener((status) {
          log(status.toString());
          if (status == AnimationStatus.forward) {
            context
                .read<CardTransactionAnalyticsCubit>()
                .toggleOffBarChartAnimation(barChartIndex: widget.index);
          }
        }),
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
      child: AlignTransition(
        alignment: _alignAnimation,
        child: RotationTransition(
          turns: _rotationAnimation,
          child: AnimatedIconWidget(
            icon: widget.index == 0
                ? Icons.shopping_bag_outlined
                : widget.index == 1
                    ? Icons.favorite_border
                    : widget.index == 2
                        ? Icons.airplanemode_active_outlined
                        : widget.index == 3
                            ? Icons.local_pizza_outlined
                            : widget.index == 4
                                ? Icons.percent
                                : Icons.error_outline,
            iconColor: widget.index == 0
                ? AppColors.lavenderLustre
                : widget.index == 1
                    ? AppColors.floweringCactus
                    : widget.index == 2
                        ? AppColors.poodleSkirt
                        : widget.index == 3
                            ? AppColors.porcellana
                            : widget.index == 4
                                ? AppColors.blueHydrangea
                                : AppColors.corbeau,
            gradientColors: widget.index == 0
                ? [
                    AppColors.lavenderLustre,
                    AppColors.crystalFalls,
                    AppColors.lavenderLustre,
                  ]
                : widget.index == 1
                    ? [
                        AppColors.floweringCactus,
                        AppColors.aquaTint,
                        AppColors.floweringCactus,
                      ]
                    : widget.index == 2
                        ? [
                            AppColors.poodleSkirt,
                            AppColors.justPinkEnough,
                            AppColors.poodleSkirt,
                          ]
                        : widget.index == 3
                            ? [
                                AppColors.porcellana,
                                AppColors.strawberryDust,
                                AppColors.porcellana,
                              ]
                            : widget.index == 4
                                ? [
                                    AppColors.blueHydrangea,
                                    AppColors.aircraftWhite,
                                    AppColors.blueHydrangea,
                                  ]
                                : [],
          ),
        ),
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


       // AlignTransition(
          //   alignment: _alignAnimation,
          //   child: RotationTransition(
          //     turns: _rotationAnimation,
          //     child: const AnimatedIconWidget(
          //       icon: Icons.favorite_border,
          //       iconColor: AppColors.floweringCactus,
          //       gradientColors: [
          //         AppColors.aquaTint,
          //         AppColors.floweringCactus,
          //         AppColors.aquaTint,
          //       ],
          //     ),
          //   ),
          // ),
          // AlignTransition(
          //   alignment: _alignAnimation,
          //   child: RotationTransition(
          //     turns: _rotationAnimation,
          //     child: const AnimatedIconWidget(
          //       icon: Icons.airplanemode_active_outlined,
          //       iconColor: AppColors.poodleSkirt,
          //       gradientColors: [
          //         AppColors.justPinkEnough,
          //         AppColors.poodleSkirt,
          //         AppColors.justPinkEnough,
          //       ],
          //     ),
          //   ),
          // ),
          // AlignTransition(
          //   alignment: _alignAnimation,
          //   child: RotationTransition(
          //     turns: _rotationAnimation,
          //     child: const AnimatedIconWidget(
          //       icon: Icons.local_pizza_outlined,
          //       iconColor: AppColors.porcellana,
          //       gradientColors: [
          //         AppColors.strawberryDust,
          //         AppColors.porcellana,
          //         AppColors.strawberryDust,
          //       ],
          //     ),
          //   ),
          // ),
          // AlignTransition(
          //   alignment: _alignAnimation,
          //   child: RotationTransition(
          //     turns: _rotationAnimation,
          //     child: const AnimatedIconWidget(
          //       icon: Icons.percent,
          //       iconColor: AppColors.blueHydrangea,
          //       gradientColors: [
          //         AppColors.aircraftWhite,
          //         AppColors.blueHydrangea,
          //         AppColors.aircraftWhite,
          //       ],
          //     ),
          //   ),
          // ),