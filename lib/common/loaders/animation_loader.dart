import 'package:flutter/material.dart';
import 'package:leaf_lab/utils/helpers/helper_functions.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';

class animationLoaderWidget extends StatelessWidget {
  animationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.actionText,
    this.showAction = false,
    this.onActionPressed,
  });

  final String text, animation;
  final String? actionText;
  final bool showAction;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset(animation,
              width: MediaQuery.of(context).size.width * 0.8),
          SizedBox(
            height: TSizes.defaultSpace
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: TSizes.defaultSpace
          ),
          showAction
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                    onPressed: onActionPressed,
                    style:
                        OutlinedButton.styleFrom(backgroundColor: TColors.dark),
                    child: Text(
                      actionText!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: TColors.light),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

class shimmerEffect extends StatelessWidget {
  const shimmerEffect(
      {super.key,
      required this.width,
      required this.hieght,
      this.radius = 15,
      this.color});

  final double width, hieght, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        width: width,
        height: hieght,
        decoration: BoxDecoration(
          color: color ?? (dark ? TColors.darkGrey : TColors.white),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
