import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:leaf_lab/features/authentication/controller/signup/signup_controller.dart';
import 'package:leaf_lab/features/authentication/screens/signup/widget/login_signup/Dividerform.dart';
import 'package:leaf_lab/features/authentication/screens/signup/widget/login_signup/Sicialbuttons.dart';
import 'package:leaf_lab/utils/constants/colors.dart';
import 'package:leaf_lab/utils/constants/sizes.dart';
import 'package:leaf_lab/utils/constants/text_strings.dart';
import 'package:leaf_lab/utils/helpers/helper_functions.dart';
import 'package:leaf_lab/utils/validators/validation.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(signUpController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Title
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Form
              Form(
                key: controller.signupFormKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.firstName,
                            expands: false,
                            validator: (value)=> TValidator.validateEmptyText('firstName', value),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Iconsax.user),
                              labelText: TTexts.firstName,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: TSizes.spaceBtwInputFields,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: controller.lastName,
                            expands: false,
                            validator: (value)=> TValidator.validateEmptyText('lastName', value),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Iconsax.user),
                              labelText: TTexts.lastName,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    TextFormField(
                      controller: controller.username,
                      expands: false,
                      validator: (value)=> TValidator.validateEmptyText('userName', value),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.user_edit),
                        labelText: TTexts.username,
                      ),
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    TextFormField(
                      controller: controller.email,
                      expands: false,
                      validator: (value)=> TValidator.validateEmail(value),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.direct),
                        labelText: TTexts.email,
                      ),
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    TextFormField(
                      controller: controller.phoneNumber,
                      expands: false,
                      validator: (value)=> TValidator.validatePhoneNumber(value),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.mobile),
                        labelText: TTexts.phoneNo,
                      ),
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    Obx(
                      ()=> TextFormField(
                        controller: controller.password,
                        obscureText: controller.hidePassword.value,
                        validator: (value)=> TValidator.validatePassword(value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.password_check),
                          suffixIcon: IconButton(
                              onPressed: () => controller.hidePassword.value =
                              !controller.hidePassword.value,
                              icon: Icon(controller.hidePassword.value? Iconsax.eye_slash: Iconsax.eye)),
                          labelText: TTexts.password,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    Row(
                      children: [
                        Obx(()=> Checkbox(value: controller.privacyPolicy.value, onChanged: (value) => controller.privacyPolicy.value= !controller.privacyPolicy.value)),
                        SizedBox(),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: '${TTexts.iAgreeTo}',
                                  style: Theme.of(context).textTheme.bodySmall),
                              TextSpan(
                                  text: ' ${TTexts.privacyPolicy}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .apply(
                                        color: dark
                                            ? TColors.white
                                            : TColors.primary,
                                        decoration: TextDecoration.underline,
                                        decorationColor: dark
                                            ? TColors.white
                                            : TColors.primary,
                                      )),
                              TextSpan(
                                  text: ' and ',
                                  style: Theme.of(context).textTheme.bodySmall),
                              TextSpan(
                                  text: '${TTexts.termsOfUse}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .apply(
                                        color: dark
                                            ? TColors.white
                                            : TColors.primary,
                                        decoration: TextDecoration.underline,
                                        decorationColor: dark
                                            ? TColors.white
                                            : TColors.primary,
                                      )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: double.infinity,child: ElevatedButton(onPressed: () => controller.signup(), child: Text(TTexts.createAccount)),)
                  ],
                ),
              ),
              SizedBox(height:TSizes.spaceBtwItems,),
              DividerForm(dividerText: TTexts.signupTitle),
              SizedBox(height: TSizes.spaceBtwInputFields,),
              SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
