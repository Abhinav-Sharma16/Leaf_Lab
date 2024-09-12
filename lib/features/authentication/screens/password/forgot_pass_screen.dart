
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:leaf_lab/common/styles/spacing.dart';
import 'package:leaf_lab/features/authentication/screens/password/reset_pass_screen.dart';
import 'package:leaf_lab/utils/constants/sizes.dart';
import 'package:leaf_lab/utils/constants/text_strings.dart';
import 'package:leaf_lab/utils/validators/validation.dart';

import '../../controller/forgotPassword/password_controller.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(forgotPassController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(padding: Spacings.paddingwithAppbar,child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///headings
            Text(TTexts.forgetPasswordTitle, style: Theme.of(context).textTheme.headlineMedium,),
            SizedBox(height: TSizes.spaceBtwItems,),
            Text(TTexts.forgetPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium,),
            SizedBox(height: TSizes.spaceBtwSections,),
            ///text field
            Form(
              key: controller.forgotPassFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: TValidator.validateEmail,
                decoration: InputDecoration(
                  labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct_right),
                ),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwSections,),

            ///submit button
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()=>controller.sendForgotPassword(), child: Text(TTexts.submit)),),
          ],
        ),),
      ),
    );
  }
}
