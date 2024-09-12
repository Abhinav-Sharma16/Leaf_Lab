import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaf_lab/utils/popups/fullScreennloader.dart';
import '../../../../data/repositries/authentication_repo.dart';
import '../../../../data/repositries/userRepo.dart';
import '../../../../user/userModel.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/loader.dart';
import '../../screens/signup/verify.dart';


class signUpController extends GetxController {
  static signUpController get instance => Get.find();

  ///variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  /// signup
  Future<void> signup() async {
    try {
      //start loading
      fullScreenLoader.openLoadingDialog(
          'We are processing your information...', 'assets/images/animations/141594-animation-of-docer.json');

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        fullScreenLoader.stopLoading();
        return;
      }

      //form validation
      if (!signupFormKey.currentState!.validate()) {
        fullScreenLoader.stopLoading();
        return;
      }

      //privacy check
      if (!privacyPolicy.value) {
        Tloader.warningSnackBar(
            title: 'Accept Privacy Policy!!',
            message:
                'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use');
        fullScreenLoader.stopLoading();

        return;
      }

      //register user in firebase and save user data
      final userCredentials = await AuthenicationRepository.instance
          .registerEmailandPassword(email.text.trim(), password.text.trim());

      //save auntenticated user data in firestore
      final newUser = UserModel(
          id: userCredentials.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          userName: username.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePic: '');

      final UserRepository = Get.put(userRepository());
      await UserRepository.saveUserRecord(newUser);

      //show success message
      Tloader.successSnackBar(title: 'Congratulations', message: 'Your account has been created! Verify email to continue.',);

      //move to verify email screen
      Get.to(()=>VerifyScreen(email: email.text.trim(),));

    } catch (e) {
      fullScreenLoader.stopLoading();
      //show some generic error to user
      Tloader.errorSnackBar(title: 'oh snap!', message: e.toString());
    }
  }
}
