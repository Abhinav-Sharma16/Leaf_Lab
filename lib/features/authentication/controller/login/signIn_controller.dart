import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:leaf_lab/utils/popups/fullScreennloader.dart';
import '../../../../data/repositries/authentication_repo.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/loader.dart';
import '../../../personilazation/controller/user_controller.dart';

class signInController extends GetxController{

  ///variables
  final rememberMe = false.obs;
  final hidePass = true.obs;
  final localStorage = GetStorage();
  final email =  TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  final usercontroller = Get.put(userController());

  ///Email nd Password SignIn

  Future<void> emailPassSignIn() async{
    try{
      //start loading
      fullScreenLoader.openLoadingDialog('Logging you...', 'assets/images/animations/141594-animation-of-docer.json');

      //check network connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        fullScreenLoader.stopLoading();
        return;
      }

      //form Validation
      if(!signInFormKey.currentState!.validate()){
        fullScreenLoader.stopLoading();
        return;
      }

      //save data if Remember me is sekected
      if(rememberMe.value){
        localStorage.write("Remember_Me_Email", email.text.trim());
        localStorage.write("Rememebr_Me_Password", password.text.trim());
      }

      @override
      void onInit() {
        email.text =  localStorage.read("Remember_Me_Email");
        password.text =  localStorage.read("Rememebr_Me_Password");
        super.onInit();
      }
      //signIn user with email and Password authentication

      final userCredentials = await AuthenicationRepository.instance.signInwithEmailPass(email.text.trim(), password.text.trim());

      //remove loader
      fullScreenLoader.stopLoading();

      //redirect
      AuthenicationRepository.instance.screenRedirect();
    }catch(e){
      fullScreenLoader.stopLoading();
      Tloader.errorSnackBar(title: 'Oh snap!!!', message: e.toString());
    }
  }

  ///Google SignIn
  Future<void> googleSignIn()async{
    try{
      //loading
      fullScreenLoader.openLoadingDialog('logging you...', 'assets/images/animations/141594-animation-of-docer.json');

      //check network
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        fullScreenLoader.stopLoading();
        return;
      }

      //google authentication
      final userCredentials = await AuthenicationRepository.instance.signInwithGoogle();

      //save user record
      await usercontroller.saveUserRecord(userCredentials);

      //remove loader
      fullScreenLoader.stopLoading();

      //redirect screen
      AuthenicationRepository.instance.screenRedirect();
    }catch(e){
      Tloader.errorSnackBar(title: 'oh Snap!!!', message: e.toString());
    }
  }
}