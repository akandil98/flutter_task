import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/core/utils/utils.dart';
import 'package:flutter_task/features/card_transaction_analytics/presentation/cubit/card_transaction_analytics_cubit.dart';
import 'package:flutter_task/features/card_transaction_analytics/presentation/widgets/touched_badge_widget.dart';
import 'package:flutter_task/features/card_transaction_analytics/presentation/widgets/widgets.dart';

class PieChartWidget extends StatefulWidget {
  final CardTransactionAnalyticsCubit cubit;
  const PieChartWidget({
    super.key,
    required this.cubit,
  });

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 5), // Adjust the duration as needed
      vsync: this,
    );

    _animation =
        Tween<double>(begin: 0.0, end: 20.0).animate(_animationController);

    // Listen for data changes in the cubit and trigger the animation

    if (widget.cubit.response == null) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    _animationController.reset();
    _animationController.forward();
  }

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: _animation,
        child: AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              startDegreeOffset: 270,
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 8,
              centerSpaceRadius: 120.r,
              sections: showingSections(
                shoppingPct: widget.cubit.response?.shoppingPct ?? 20,
                wellnessPct: widget.cubit.response?.wellnessPct ?? 20,
                transportPct: widget.cubit.response?.transportPct ?? 20,
                barsAndResturantPct:
                    widget.cubit.response?.barsAndResturantPct ?? 20,
                subscriptionsPct: widget.cubit.response?.subscriptionsPct ?? 20,
                touchedIndex: touchedIndex,
              ),
            ),
            swapAnimationDuration: const Duration(milliseconds: 500),
            swapAnimationCurve: Curves.easeInOut,
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections({
    required double shoppingPct,
    required double wellnessPct,
    required double transportPct,
    required double barsAndResturantPct,
    required double subscriptionsPct,
    required int touchedIndex,
  }) {
    final sectionDataList = List.generate(
      5,
      (i) {
        // final isTouched = i == touchedIndex;
        final isTouched = touchedIndex != -1 ? true : false;
        final radius = isTouched ? 20.0 : 10.0;
        // const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
        switch (i) {
          case 0:
            return PieChartSectionData(
              badgeWidget: widget.cubit.response == null
                  ? const BadgeWidget(
                      color: AppColors.blueHydrangea,
                    )
                  : (widget.cubit.response != null && isTouched)
                      ? const TouchedBadgeWidget(
                          icon: Icons.shopping_bag_outlined,
                          iconColor: AppColors.blueHydrangea,
                          borderColor: AppColors.corbeau,
                        )
                      : null,
              showTitle: false,
              color: AppColors.blueHydrangea,
              value: shoppingPct,
              radius: widget.cubit.response == null ? -20 : radius,
            );
          case 1:
            return PieChartSectionData(
              badgeWidget: widget.cubit.response == null
                  ? const BadgeWidget(
                      color: AppColors.floweringCactus,
                    )
                  : (widget.cubit.response != null && isTouched)
                      ? const TouchedBadgeWidget(
                          icon: Icons.favorite_border,
                          iconColor: AppColors.floweringCactus,
                          borderColor: AppColors.corbeau,
                        )
                      : null,
              showTitle: false,
              color: AppColors.floweringCactus,
              value: wellnessPct,
              radius: widget.cubit.response == null ? -20 : radius,
            );
          case 2:
            return PieChartSectionData(
              badgeWidget: widget.cubit.response == null
                  ? const BadgeWidget(
                      color: AppColors.poodleSkirt,
                    )
                  : (widget.cubit.response != null && isTouched)
                      ? const TouchedBadgeWidget(
                          icon: Icons.airplanemode_active_outlined,
                          iconColor: AppColors.poodleSkirt,
                          borderColor: AppColors.corbeau,
                        )
                      : null,
              showTitle: false,
              color: AppColors.poodleSkirt,
              value: transportPct,
              radius: widget.cubit.response == null ? -20 : radius,
            );
          case 3:
            return PieChartSectionData(
              badgeWidget: widget.cubit.response == null
                  ? const BadgeWidget(
                      color: AppColors.lavenderLustre,
                    )
                  : (widget.cubit.response != null && isTouched)
                      ? const TouchedBadgeWidget(
                          icon: Icons.local_pizza_outlined,
                          iconColor: AppColors.lavenderLustre,
                          borderColor: AppColors.corbeau,
                        )
                      : null,
              showTitle: false,
              color: AppColors.lavenderLustre,
              value: barsAndResturantPct,
              radius: widget.cubit.response == null ? -20 : radius,
            );
          case 4:
            return PieChartSectionData(
              badgeWidget: widget.cubit.response == null
                  ? const BadgeWidget(
                      color: AppColors.porcellana,
                    )
                  : (widget.cubit.response != null && isTouched)
                      ? const TouchedBadgeWidget(
                          icon: Icons.percent_outlined,
                          iconColor: AppColors.porcellana,
                          borderColor: AppColors.corbeau,
                        )
                      : null,
              showTitle: false,
              color: AppColors.porcellana,
              value: subscriptionsPct,
              radius: widget.cubit.response == null ? -20 : radius,
            );

          default:
            throw Error();
        }
      },
    );
    // final sectionsWithIndex = sectionDataList
    //     .asMap()
    //     .map((index, sectionData) => MapEntry(
    //           index,
    //           PieChartSectionWithIndex(
    //             sectionData: sectionData,
    //             originalIndex: index,
    //           ),
    //         ))
    //     .values
    //     .toList();

    // sectionsWithIndex
    //     .sort((a, b) => b.sectionData.value.compareTo(a.sectionData.value));

    // final sortedSectionData =
    //     sectionsWithIndex.map((item) => item.sectionData).toList();
    sectionDataList.sort((a, b) => b.value.compareTo(a.value));

    return sectionDataList;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class PieChartSectionWithIndex {
  final PieChartSectionData sectionData;
  final int originalIndex;

  PieChartSectionWithIndex({
    required this.sectionData,
    required this.originalIndex,
  });
}
