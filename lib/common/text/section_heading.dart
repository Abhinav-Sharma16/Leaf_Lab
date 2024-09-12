
import 'package:flutter/material.dart';
import 'package:leaf_lab/utils/constants/colors.dart';
import 'package:leaf_lab/utils/helpers/helper_functions.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    this.showActionButton = false,
    this.textColor,
    required this.title,
    this.buttonTitle = 'view all',
    this.onPressed,
  });

  final bool showActionButton;
  final Color? textColor;
  final String title, buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: THelperFunctions.isDarkMode(context)? TColors.white: TColors.black),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(onPressed: onPressed, child: Text(buttonTitle)),
      ],
    );
  }
}