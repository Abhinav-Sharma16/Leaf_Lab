import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaf_lab/utils/popups/fullScreennloader.dart';
import '../../../../data/repositries/authentication_repo.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/loader.dart';
import '../../screens/password/reset_pass_screen.dart';

class forgotPassController extends GetxController{
  static forgotPassController get instance => Get.find();

  ///variable

  final email = TextEditingController();
  GlobalKey<FormState> forgotPassFormKey= GlobalKey<FormState>();

  ///send reset password email
  sendForgotPassword()async{
    try{
      //satrt loading
      fullScreenLoader.openLoadingDialog('Processing your request...', 'assets/images/animations/141594-animation-of-docer.json');

      //cehck internet
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){fullScreenLoader.stopLoading(); return;}

      //formValidation
      if(!forgotPassFormKey.currentState!.validate()){
        fullScreenLoader.stopLoading();
        return;
      }

      //send email to reset password
      await AuthenicationRepository.instance.sendForgotPassword(email.text.trim());

      //remove loader
      fullScreenLoader.stopLoading();
      
      //show success snack bar
      Tloader.successSnackBar(title: 'Email sent',message: "Email Link sent to Reset your Password".tr);

      //redirect to forgot password screen
      Get.to(()=>ResetPassword(email: email.text.toString(),));
    } catch(e){
      //remove loader
      fullScreenLoader.stopLoading();
      Tloader.errorSnackBar(title: 'oh snap!!',message: e.toString());
    }
  }

  ///resend email

  resendForgotPassword(String email)async{
    try{
      //satrt loading
      fullScreenLoader.openLoadingDialog('Processing your request...', 'assets/images/animations/141594-animation-of-docer.json');

      //cehck internet
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){fullScreenLoader.stopLoading(); return;}

      //send email to reset password
      await AuthenicationRepository.instance.sendForgotPassword(email);

      //remove loader
      fullScreenLoader.stopLoading();

      //show success snack bar
      Tloader.successSnackBar(title: 'Email sent',message: "Email Link sent to Reset your Password".tr);

    } catch(e){
      //remove loader
      fullScreenLoader.stopLoading();
      Tloader.errorSnackBar(title: 'oh snap!!',message: e.toString());
    }
  }
}