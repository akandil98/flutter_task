import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/utils/utils.dart';
import 'package:flutter_task/features/card_transaction_analytics/presentation/cubit/card_transaction_analytics_cubit.dart';
import 'package:group_button/group_button.dart';

class GroupByWidget extends StatefulWidget {
  const GroupByWidget({
    super.key,
  });

  @override
  State<GroupByWidget> createState() => _GroupByWidgetState();
}

class _GroupByWidgetState extends State<GroupByWidget> {
  GroupButtonController? _radioController;

  final _radioButtons = [
    AppStrings.week,
    AppStrings.month,
    AppStrings.year,
  ];

  @override
  void initState() {
    _radioController = GroupButtonController(
      selectedIndex: 1,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Sizes.s14,
        right: Sizes.s24,
      ),
      child: GroupButton(
        controller: _radioController,
        onSelected: (value, index, isSelected) {
          String? groupBy;
          if (index == 0) {
            groupBy = 'week';
          } else if (index == 1) {
            groupBy = 'month';
          } else if (index == 2) {
            groupBy = 'year';
          }
          context
              .read<CardTransactionAnalyticsCubit>()
              .changeGroupByFun(groupBy: groupBy!);
        },
        buttons: _radioButtons,
        options: GroupButtonOptions(
          selectedTextStyle: AppTextStyles.medium18.copyWith(
            color: AppColors.picoVoid,
            fontWeight: FontWeight.w600,
          ),
          unselectedTextStyle: AppTextStyles.medium16.copyWith(
            color: AppColors.silverStar,
            fontWeight: FontWeight.w400,
          ),
          selectedShadow: [],
          unselectedShadow: [],
          borderRadius: AppBorderRadius.borderAll24,
          mainGroupAlignment: MainGroupAlignment.spaceBetween,
          selectedColor: AppColors.scaffoldBackgroundColor,
          unselectedColor: AppColors.scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
