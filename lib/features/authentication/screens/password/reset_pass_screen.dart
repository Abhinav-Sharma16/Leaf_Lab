import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaf_lab/common/styles/spacing.dart';
import 'package:leaf_lab/features/authentication/controller/forgotPassword/password_controller.dart';
import 'package:leaf_lab/utils/constants/sizes.dart';
import 'package:leaf_lab/utils/constants/text_strings.dart';
import 'package:leaf_lab/utils/helpers/helper_functions.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.email});

final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: ()=> Get.back(), icon: Icon(CupertinoIcons.clear)),
        ],
      ),
      body: SingleChildScrollView(
        padding: Spacings.paddingwithAppbar,
        child: Column(

          children: [
            ///Image
            Image(image: AssetImage("assets/images/animations/sammy-line-man-receives-a-mail.png"), width: THelperFunctions.screenWidth()*0.6,),
            SizedBox(height: TSizes.spaceBtwItems,),

            ///headings
            Text(TTexts.changeYourPasswordTitle, style: Theme.of(context).textTheme.headlineMedium,),
            SizedBox(height: TSizes.spaceBtwItems,),
            Text(TTexts.changeYourPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium,),
            SizedBox(height: TSizes.spaceBtwSections,),

            ///buttons
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){}, child: Text('Done')),),
            SizedBox(width: double.infinity,child: TextButton(onPressed: ()=> forgotPassController.instance.resendForgotPassword(email), child: Text(TTexts.resendEmail)),),
          ],
        ),
      ),
    );
  }
}
