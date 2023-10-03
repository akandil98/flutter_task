import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/core/utils/utils.dart';
import 'package:flutter_task/features/card_transaction_analytics/presentation/cubit/card_transaction_analytics_cubit.dart';
import 'package:flutter_task/features/card_transaction_analytics/presentation/widgets/signle_align_and_rotation_transition_widget.dart';

class CustomListTileWidget extends StatelessWidget {
  final CardTransactionAnalyticsCubit cubit;
  final IconData icon;
  final Color iconColor;
  final String title;
  final int transactionsNo;
  final String amount;
  final String percentage;
  final VoidCallback? ontap;

  final int index;
  const CustomListTileWidget({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.transactionsNo,
    required this.amount,
    required this.percentage,
    required this.index,
    required this.cubit,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return index == cubit.barChartIndex && cubit.isTapped == true
        ? SingleAlignAndRoationTransitionWidget(
            index: cubit.barChartIndex,
          )
        : ListTile(
            onTap: ontap,
            contentPadding: const EdgeInsets.all(0),
            leading: Padding(
              padding: const EdgeInsets.only(
                left: Sizes.s10,
                right: Sizes.s10,
              ),
              child: Icon(
                icon,
                color: iconColor,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: Sizes.s8),
              child: Text(
                title,
              ),
            ),
            titleTextStyle: AppTextStyles.medium18.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.corbeau,
              fontFamily: AppConstants.appFontFamily,
            ),
            subtitle: Text(
              '$transactionsNo ${AppStrings.transactions}',
              style: AppTextStyles.small14.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.namaraGrey,
                fontFamily: AppConstants.appFontFamily,
              ),
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '\$$amount',
                  style: AppTextStyles.medium16.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.corbeau,
                    fontFamily: AppConstants.appFontFamily,
                  ),
                ),
                Text(
                  '${Decimal.parse(percentage)} %',
                  style: AppTextStyles.small14.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.namaraGrey,
                    fontFamily: AppConstants.appFontFamily,
                  ),
                ),
              ],
            ),
          );
  }
}
