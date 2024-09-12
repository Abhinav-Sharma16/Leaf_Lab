import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:leaf_lab/utils/constants/image_strings.dart';
import 'package:leaf_lab/utils/constants/text_strings.dart';
import '../../../../data/repositries/authentication_repo.dart';
import '../../../../utils/popups/loader.dart';
import '../../screens/signup/success_mail.dart';

class verifyEmailController extends GetxController {
  static verifyEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    setTimerforAutoRedirect();
    super.onInit();
  }

  sendEmailVerification() async {
    try {
      await AuthenicationRepository.instance.sendEmailVerification();
      Tloader.successSnackBar(
          title: 'Email Sent',
          message: 'Please check your inbox and verify your email');
    } catch (e) {
      Tloader.errorSnackBar(title: 'oh Snap!', message: e.toString());
    }
  }

  setTimerforAutoRedirect() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(
          () => SuccessMail(
              image: TImages.staticSuccessIllustration,
              title: TTexts.yourAccountCreatedTitle,
              subtitle: TTexts.yourAccountCreatedSubTitle,
              onPressed: () =>
                  AuthenicationRepository.instance.screenRedirect()),
        );
      }
    });
  }

  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.offAll(
        () => SuccessMail(
            image: TImages.staticSuccessIllustration,
            title: TTexts.yourAccountCreatedTitle,
            subtitle: TTexts.yourAccountCreatedSubTitle,
            onPressed: () => AuthenicationRepository.instance.screenRedirect()),
      );
    }
  }
}
