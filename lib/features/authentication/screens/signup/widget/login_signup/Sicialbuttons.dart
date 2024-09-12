import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaf_lab/features/authentication/controller/login/signIn_controller.dart';
import 'package:leaf_lab/utils/constants/colors.dart';
import 'package:leaf_lab/utils/constants/image_strings.dart';
import 'package:leaf_lab/utils/constants/sizes.dart';
import '../../../../../../data/services/auth.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(signInController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: TColors.grey),borderRadius: BorderRadius.circular(100),),
          child: IconButton(onPressed: ()=>AuthMethods().signInWithGoogle(context), icon: Image(
            height: TSizes.iconMd,
            width: TSizes.iconMd,
            image: AssetImage(TImages.google),
          )),
        ),
      ],
    );
  }
}