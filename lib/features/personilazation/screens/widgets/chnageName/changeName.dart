
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:leaf_lab/utils/constants/sizes.dart';
import 'package:leaf_lab/utils/constants/text_strings.dart';
import 'package:leaf_lab/utils/validators/validation.dart';

import '../../../../../common/appBar/appbar.dart';
import 'nameController.dart';

class changeName extends StatelessWidget {
  const changeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(updateNameController());
    return Scaffold(
      appBar: Appbar(
        showBackArrow: true,
        title: Text(
          'Change Name',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Use your real name for easy verification. This name will appear on saveral pages.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Form(
              key: controller.updateNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        TValidator.validateEmptyText('firstName', value),
                    expands: false,
                    decoration: InputDecoration(
                      labelText: TTexts.firstName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) =>
                        TValidator.validateEmptyText('lastName', value),
                    expands: false,
                    decoration: InputDecoration(
                      labelText: TTexts.lastName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: TSizes.spaceBtwSections,),
            SizedBox(width: double.infinity,
              child: ElevatedButton(onPressed:()=> controller.updateUserName(), child: Text('Save')),
            ),
          ],
        ),
      ),
    );
  }
}
