import 'package:flutter/material.dart';
import 'package:flutter_task/core/utils/utils.dart';
import 'package:flutter_task/features/card_transaction_analytics/presentation/cubit/card_transaction_analytics_cubit.dart';
import 'package:flutter_task/features/card_transaction_analytics/presentation/widgets/custom_list_tile_widget.dart';

class ExpenseCategoriesWidget extends StatelessWidget {
  const ExpenseCategoriesWidget({
    super.key,
    required this.cubit,
  });

  final CardTransactionAnalyticsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.50.sh,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomListTileWidget(
            ontap: () => cubit.toggleOnBarChartAnimation(barChartIndex: 0),
            cubit: cubit,
            index: 0,
            icon: Icons.shopping_bag_outlined,
            iconColor: AppColors.lavenderLustre,
            title: AppStrings.shopping,
            transactionsNo: cubit.response?.shoppingTransactions ?? 0,
            amount: '${cubit.response?.shoppingTotal}',
            percentage: '${cubit.response?.shoppingPct.floorToDouble()}',
          ),
          CustomListTileWidget(
            ontap: () => cubit.toggleOnBarChartAnimation(barChartIndex: 1),
            cubit: cubit,
            index: 1,
            icon: Icons.favorite_border,
            iconColor: AppColors.floweringCactus,
            title: AppStrings.wellness,
            transactionsNo: cubit.response?.wellnessTransactions ?? 0,
            amount: '${cubit.response?.wellnessTotal}',
            percentage: '${cubit.response?.wellnessPct.floorToDouble()}',
          ),
          CustomListTileWidget(
            ontap: () => cubit.toggleOnBarChartAnimation(barChartIndex: 2),
            cubit: cubit,
            index: 2,
            icon: Icons.airplanemode_active_outlined,
            iconColor: AppColors.poodleSkirt,
            title: AppStrings.transport,
            transactionsNo: cubit.response?.transportTransactions ?? 0,
            amount: '${cubit.response?.transportTotal}',
            percentage: '${cubit.response?.transportPct.floorToDouble()}',
          ),
          CustomListTileWidget(
            ontap: () => cubit.toggleOnBarChartAnimation(barChartIndex: 3),
            cubit: cubit,
            index: 3,
            icon: Icons.local_pizza_outlined,
            iconColor: AppColors.porcellana,
            title: AppStrings.barsAndResturant,
            transactionsNo: cubit.response?.barsAndResturantTransactions ?? 0,
            amount: '${cubit.response?.barsAndResturantTotal}',
            percentage:
                '${cubit.response?.barsAndResturantPct.floorToDouble()}',
          ),
          CustomListTileWidget(
            ontap: () => cubit.toggleOnBarChartAnimation(barChartIndex: 4),
            cubit: cubit,
            index: 4,
            icon: Icons.percent,
            iconColor: AppColors.blueHydrangea,
            title: AppStrings.subscriptions,
            transactionsNo: cubit.response?.subscriptionsTransactions ?? 0,
            amount: '${cubit.response?.subscriptionsTotal}',
            percentage: '${cubit.response?.subscriptionsPct.floorToDouble()}',
          ),
        ],
      ),
    );
  }
}
