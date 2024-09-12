import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaf_lab/utils/constants/colors.dart';
import 'package:leaf_lab/utils/helpers/helper_functions.dart';
import '../../common/loaders/animation_loader.dart';

class fullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) =>
          PopScope(
            canPop: false,
            child: Container(
              color: THelperFunctions.isDarkMode(Get.context!) ? TColors.dark : TColors
                  .white,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 250,),
                  animationLoaderWidget(text: text, animation: animation),
                ],
              ),
            ),
          ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}