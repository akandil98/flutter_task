import 'package:flutter/material.dart';
import 'package:flutter_task/core/utils/utils.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  Size get preferredSize => Size.fromHeight(0.08.sh);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(AppStrings.expenses),
      leading: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.s22,
        ),
        child: Icon(
          Icons.arrow_back_ios,
          color: AppColors.corbeau,
        ),
      ),
    );
  }
}
