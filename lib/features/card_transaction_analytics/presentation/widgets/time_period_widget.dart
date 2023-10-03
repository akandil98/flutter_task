import 'package:flutter/material.dart';
import 'package:flutter_task/core/utils/utils.dart';
import 'package:flutter_task/features/card_transaction_analytics/presentation/cubit/card_transaction_analytics_cubit.dart';

class TimePeriodWidget extends StatelessWidget {
  final CardTransactionAnalyticsCubit cubit;
  const TimePeriodWidget({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Sizes.s24,
        right: Sizes.s24,
        bottom: Sizes.s20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: IconButton(
              onPressed: (cubit.currentTimePeriodIndex ==
                          cubit.timePeriodsList.length - 1) ||
                      cubit.response == null
                  ? null
                  : () async {
                      cubit.goToPrevious();
                    },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: cubit.currentTimePeriodIndex ==
                            cubit.timePeriodsList.length - 1 ||
                        cubit.response == null
                    ? AppColors.namaraGrey
                    : AppColors.corbeau,
              ),
            ),
          ),
          Text(
            cubit.formatDateTimeRange(
              cubit.timePeriodsList[cubit.currentTimePeriodIndex].startDate,
              cubit.timePeriodsList[cubit.currentTimePeriodIndex].endDate,
              cubit.groupBy,
            ),
            textAlign: TextAlign.center,
            style: AppTextStyles.medium20.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.corbeau,
            ),
          ),
          Flexible(
            child: IconButton(
              onPressed:
                  (cubit.currentTimePeriodIndex == 0) || cubit.response == null
                      ? null
                      : () async {
                          cubit.goToNext();
                        },
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                color:
                    cubit.currentTimePeriodIndex == 0 || cubit.response == null
                        ? AppColors.namaraGrey
                        : AppColors.corbeau,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
