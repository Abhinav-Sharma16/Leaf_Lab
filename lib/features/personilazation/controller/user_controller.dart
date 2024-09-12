import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaf_lab/features/personilazation/controller/reAuthenticate.dart';
import 'package:leaf_lab/utils/popups/fullScreennloader.dart';
import '../../../data/repositries/authentication_repo.dart';
import '../../../data/repositries/userRepo.dart';
import '../../../user/userModel.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/loader.dart';
import '../../authentication/screens/signin/login_screen.dart';

class userController extends GetxController {
  static userController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userrepository = Get.put(userRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();


  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async{
    try{
      profileLoading.value = true;
      final usr = await userRepository.instance.fetchUserDetails();
      this.user(usr);
    } catch(e){
      user(UserModel.empty());
    } finally{
      profileLoading.value = false;
    }
  }


  //save user record from registration provider
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      if (userCredential != null) {
        //convert name into first and last name
        final nameParts =
            UserModel.nameParts(userCredential.user!.displayName ?? "");
        final userName =
            UserModel.generateUsername(userCredential.user!.displayName ?? "");

        //map data
        final user = UserModel(
            id: userCredential.user!.uid,
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : "",
            userName: userName,
            email: userCredential.user!.email ?? "",
            phoneNumber: userCredential.user!.phoneNumber ?? "",
            profilePic: userCredential.user!.photoURL ?? "");

        //save user data
        await userrepository.saveUserRecord(user);
      }
    } catch (e) {
      Tloader.warningSnackBar(
          title: 'Data not saved!',
          message:
              'Something went wrong while saving your data. You can re-save it from profile tab.');
    }
  }

  void deleteAccountWarning(){
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(TSizes.md),
      title: 'Delete Account',
      middleText: 'Are you sure want to delete account permanently? This action is not reversible and all of your data will be removed permanently.',
      confirm: ElevatedButton(onPressed: ()async=> deleteUserAccount(), style: ElevatedButton.styleFrom(backgroundColor: Colors.red,side: BorderSide(color: Colors.red)),child: Padding(padding: EdgeInsets.symmetric(horizontal: TSizes.lg,),child: Text('Delete'),),),
      cancel: OutlinedButton(onPressed: ()=>Navigator.of(Get.overlayContext!).pop(), child: Text('Cancel'),),
    );
  }

  void deleteUserAccount()async{
    try{
      fullScreenLoader.openLoadingDialog('Processing', 'assets/images/animations/141594-animation-of-docer.json');

      //first reauthenthicate user
      final auth = AuthenicationRepository.instance;
      final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
      if(provider.isNotEmpty){
        if(provider == 'google.com'){
          await auth.signInwithGoogle();
          await auth.deleteAccount();
          fullScreenLoader.stopLoading();
          Get.offAll(()=> loginScreen());
        } else if(provider == 'password'){
          fullScreenLoader.stopLoading();
          Get.to(()=> reAuthenticateForm());
        }
      }
    }catch(e){
      fullScreenLoader.stopLoading();
      Tloader.warningSnackBar(title: 'oh snap!!', message: e.toString());
    }
  }

  Future<void> reAuthenticateuserEmailPassword() async{
    try{
      fullScreenLoader.openLoadingDialog('Processing', 'assets/images/animations/141594-animation-of-docer.json');

      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        fullScreenLoader.stopLoading();
        return;
      }

      if(!reAuthFormKey.currentState!.validate()){
        fullScreenLoader.stopLoading();
        return;
      }

      await AuthenicationRepository.instance.reAuthenticateWithEmailPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenicationRepository.instance.deleteAccount();
      fullScreenLoader.stopLoading();
      Get.offAll(()=>loginScreen());
    }catch(e){
      fullScreenLoader.stopLoading();
      Tloader.warningSnackBar(title: 'oh snap!', message: e.toString());
    }
  }
}
