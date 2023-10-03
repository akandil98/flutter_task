import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/core/utils/utils.dart';
import 'package:flutter_task/features/card_transaction_analytics/presentation/cubit/card_transaction_analytics_cubit.dart';
import 'package:flutter_task/features/card_transaction_analytics/presentation/widgets/widgets.dart';

class BarChartWidget extends StatefulWidget {
  final CardTransactionAnalyticsCubit cubit;

  const BarChartWidget({
    super.key,
    required this.cubit,
  });

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.5.sh,
      child: widget.cubit.response == null
          ? const Stack(
              children: [
                BarAnimatedWidget(),
                AlignAndRoationTransitionWidget(),
              ],
            )
          : RotatedBox(
              quarterTurns: 9,
              child: AspectRatio(
                aspectRatio: 1,
                child: BarChart(
                  BarChartData(
                    barTouchData: barTouchData,
                    titlesData: titlesData,
                    borderData: borderData,
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(
                            borderRadius: BorderRadius.zero,
                            width: 65,
                            toY: widget.cubit.response?.shoppingPct ?? 50,
                            color: AppColors.crystalFalls,
                            // gradient: _barsGradient,
                          )
                        ],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(
                            borderRadius: BorderRadius.zero,
                            width: 65,
                            toY: widget.cubit.response?.wellnessPct ?? 50,
                            color: AppColors.aquaTint,
                            // gradient: _barsGradient,
                          )
                        ],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                          BarChartRodData(
                            borderRadius: BorderRadius.zero,
                            width: 65,
                            toY: widget.cubit.response?.transportPct ?? 100,
                            color: AppColors.justPinkEnough,
                            // gradient: _barsGradient,
                          )
                        ],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barRods: [
                          BarChartRodData(
                            borderRadius: BorderRadius.zero,
                            width: 65,
                            toY: widget.cubit.response?.barsAndResturantPct ??
                                50,
                            color: AppColors.strawberryDust,
                            // gradient: _barsGradient,
                          )
                        ],
                      ),
                      BarChartGroupData(
                        x: 4,
                        barRods: [
                          BarChartRodData(
                            borderRadius: BorderRadius.zero,
                            width: 65,
                            toY: widget.cubit.response?.subscriptionsPct ?? 50,
                            color: AppColors.aircraftWhite,
                            // gradient: _barsGradient,
                          )
                        ],
                      ),
                    ],
                    gridData: const FlGridData(show: false),
                    alignment: BarChartAlignment.spaceBetween,
                    groupsSpace: 30,
                    maxY: 100,
                  ),
                ),
              ),
            ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mn';
        break;
      case 1:
        text = 'Te';
        break;
      case 2:
        text = 'Wd';
        break;
      case 3:
        text = 'Tu';
        break;
      case 4:
        text = 'Fr';
        break;
      case 5:
        text = 'St';
        break;
      case 6:
        text = 'Sn';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );
}
