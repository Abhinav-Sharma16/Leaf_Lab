import 'package:flutter/material.dart';
import 'package:leaf_lab/utils/constants/colors.dart';
import 'package:leaf_lab/utils/device/device_utility.dart';
import 'package:leaf_lab/utils/helpers/helper_functions.dart';

class tabBar extends StatelessWidget implements PreferredSizeWidget {
  const tabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Material(
      color: dark?TColors.black:TColors.white,
      child: TabBar(tabs: tabs,isScrollable: true,indicatorColor: TColors.primary,labelColor: dark? TColors.white:TColors.black,unselectedLabelColor: TColors.darkGrey,),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
