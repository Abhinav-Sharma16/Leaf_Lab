import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:leaf_lab/features/authentication/controller/login/signIn_controller.dart';
import 'package:leaf_lab/features/authentication/screens/password/forgot_pass_screen.dart';
import 'package:leaf_lab/features/authentication/screens/signup/signup_screen.dart';
import 'package:leaf_lab/utils/constants/sizes.dart';
import 'package:leaf_lab/utils/constants/text_strings.dart';
import 'package:leaf_lab/utils/validators/validation.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(signInController());
    return Form(
      key: controller.signInFormKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value),
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email,
              ),
            ),
            SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            Obx(
              () => TextFormField(
                controller: controller.password,
                obscureText: controller.hidePass.value,
                validator: (value) =>
                    TValidator.validateEmptyText('Password', value),
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check),
                  labelText: TTexts.password,
                  suffixIcon: IconButton(
                      onPressed: () => controller.hidePass.value =
                          !controller.hidePass.value,
                      icon: Icon(controller.hidePass.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye)),
                ),
              ),
            ),
            SizedBox(
              height: TSizes.spaceBtwInputFields / 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                    ()=> Row(
                    children: [
                      Checkbox(value: controller.rememberMe.value, onChanged: (value)=> controller.rememberMe.value =  !controller.rememberMe.value,),
                      Text(TTexts.rememberMe),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => Get.to(() => ForgotPassword()),
                  child: Text(TTexts.forgetPassword),
                ),
              ],
            ),
            SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.emailPassSignIn(),
                  child: Text(TTexts.signIn),
                )),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Get.to(() => Signup());
                  },
                  child: Text(TTexts.createAccount),
                )),
            SizedBox(
              height: TSizes.spaceBtwSections,
            ),
          ],
        ),
      ),
    );
  }
}
