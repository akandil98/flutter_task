import 'package:flutter/material.dart';
import 'package:flutter_task/core/utils/utils.dart';
import 'package:flutter_task/features/card_transaction_analytics/presentation/cubit/card_transaction_analytics_cubit.dart';

class TotalSpentWidget extends StatelessWidget {
  const TotalSpentWidget({
    super.key,
    required this.cubit,
  });

  final CardTransactionAnalyticsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.totalSpent,
              style: AppTextStyles.small14.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.silverStar,
              ),
            ),
            Text(
              '\$${cubit.response?.totalSpent ?? ''}',
              style: AppTextStyles.large32.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.corbeau,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
