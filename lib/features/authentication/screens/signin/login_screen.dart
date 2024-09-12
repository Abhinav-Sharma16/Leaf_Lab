import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaf_lab/common/styles/spacing.dart';
import 'package:leaf_lab/features/authentication/screens/signup/widget/login_signup/Sicialbuttons.dart';
import 'package:leaf_lab/utils/constants/image_strings.dart';
import 'package:leaf_lab/utils/constants/sizes.dart';
import 'package:leaf_lab/utils/constants/text_strings.dart';
import 'package:leaf_lab/utils/helpers/helper_functions.dart';
import '../signup/widget/login_signup/Dividerform.dart';
import '../signup/widget/login_signup/SigninForm.dart';

class loginScreen extends StatelessWidget {
  const loginScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: Spacings.paddingwithAppbar,
          child: Column(
            children: [
              LoginHeader(dark: dark),

              LoginForm(),

              DividerForm(dividerText: TTexts.orSignInWith.capitalize!,),

              SizedBox(height: TSizes.spaceBtwSections),

              SocialButtons()

            ],
          ),
        ),
      ),
    );
  }
}




class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(dark ? TImages.darkAppLogo: TImages.lightAppLogo),
          height: 150,
        ),
        Text(TTexts.loginTitle, style: Theme.of(context).textTheme.headlineMedium,),
        SizedBox(height: TSizes.sm,),
        Text(TTexts.loginSubTitle, style: Theme.of(context).textTheme.bodyMedium,),
      ],
    );
  }
}




