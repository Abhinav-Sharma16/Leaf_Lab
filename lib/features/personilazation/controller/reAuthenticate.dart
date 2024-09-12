import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:leaf_lab/features/personilazation/controller/user_controller.dart';
import 'package:leaf_lab/utils/constants/sizes.dart';
import 'package:leaf_lab/utils/constants/text_strings.dart';
import 'package:leaf_lab/utils/validators/validation.dart';
import '../../../common/appBar/appbar.dart';

class reAuthenticateForm extends StatelessWidget {
  const reAuthenticateForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = userController.instance;
    return Scaffold(
      appBar: Appbar(
        title: Text('Re-Authenticate User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: TValidator.validateEmail,
                  decoration: InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: TTexts.email),
                ),
                SizedBox(height: TSizes.spaceBtwInputFields,),
                Obx(
                  ()=> TextFormField(
                    controller: controller.verifyPassword,
                    obscureText: controller.hidePassword.value,
                    validator: (value)=>TValidator.validateEmptyText('Password', value),
                    decoration: InputDecoration(prefixIcon: Icon(Iconsax.password_check), labelText: TTexts.password, suffixIcon: IconButton(onPressed: ()=>controller.hidePassword.value = !controller.hidePassword.value, icon: Icon(Iconsax.eye_slash),),),
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwSections,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: ()=>controller.reactive, child: Text('Verify'),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
