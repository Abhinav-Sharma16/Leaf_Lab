
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaf_lab/data/repositries/userRepo.dart';
import 'package:leaf_lab/features/personilazation/controller/user_controller.dart';
import 'package:leaf_lab/utils/constants/image_strings.dart';
import 'package:leaf_lab/utils/popups/fullScreennloader.dart';

import '../../../../../utils/helpers/network_manager.dart';
import '../../../../../utils/popups/loader.dart';
import '../../profile.dart';

class updateNameController extends GetxController {
  static updateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final UserController = userController.instance;
  final userRepo = Get.put(userRepository());
  GlobalKey<FormState> updateNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeName();
    super.onInit();
  }

  Future<void> initializeName() async {
    firstName.text = UserController.user.value.firstName;
    lastName.text = UserController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      fullScreenLoader.openLoadingDialog(
          'We are updating your credentials', 'assets/images/animations/141594-animation-of-docer.json');

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        Tloader.errorSnackBar(
            title: 'Network Error',
            message:
                'Check your internet connection and try again after some time');
        return;
      }

      if (!updateNameFormKey.currentState!.validate()) {
        fullScreenLoader.stopLoading();
        return;
      }

      //update user's first and last name in the firestore
      Map<String, dynamic> name = {
        'firstName': firstName.text.trim(),
        'lastName': lastName.text.trim()
      };
      await userRepo.updateSingleField(name);

      //update Rx values
      UserController.user.value.firstName = firstName.text.trim();
      UserController.user.value.lastName = lastName.text.trim();

      fullScreenLoader.stopLoading();

      Tloader.successSnackBar(
          title: 'Congratulations', message: 'Your name has been updated');

      Get.off(Profile());
    } catch (e) {
      fullScreenLoader.stopLoading();
      Tloader.errorSnackBar(title: 'oh snap!!', message: e.toString());
    }
  }
}
