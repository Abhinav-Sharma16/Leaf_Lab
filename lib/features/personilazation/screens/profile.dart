import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:leaf_lab/common/appBar/appbar.dart';
import 'package:leaf_lab/common/images/circularImage.dart';
import 'package:leaf_lab/common/text/section_heading.dart';
import 'package:leaf_lab/features/authentication/screens/signin/login_screen.dart';
import 'package:leaf_lab/features/personilazation/controller/user_controller.dart';
import 'package:leaf_lab/utils/constants/sizes.dart';
import 'widgets/Profilemenu.dart';
import 'widgets/chnageName/changeName.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put( userController());
    return Scaffold(
      backgroundColor:  Colors.green[50],
      appBar: Appbar(
        title: Text('Profile'),
        backgroundColor: Colors.green[50],
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              ///profile picture
              Center(
                child: Column(

                  children: [
                    circularImage(image: 'assets/images/content/user.png', height: 100, width: 100, backgroundColor: Colors.green[50], ),
                    TextButton(onPressed: (){}, child: Text('Change Profile Picture'),),
                  ],
                ),
              ),

              ///Details
              SizedBox(height: TSizes.md,),
              Divider(),
              SizedBox(height: TSizes.md,),
              SectionHeading(title: 'Profile Information'),
              SizedBox(height: TSizes.md,),
              profileMenu(onPressed: () =>Get.to(()=> changeName()), title: 'Name', value:  "Abhinav",),
              profileMenu(onPressed: () {  }, title: 'Username', value:"Ak16", icon: Iconsax.copy,),

              SizedBox(height: TSizes.md,),
              Divider(),
              SizedBox(height: TSizes.md,),
              SectionHeading(title: 'Personal Information'),
              SizedBox(height: TSizes.md,),
              profileMenu(onPressed: (){}, title: 'User_ID', value: "Leaf_Lab007", icon: Iconsax.copy,),
              profileMenu(onPressed: (){}, title: 'Email_ID', value: "coc.aj.styles.17@gmail.com"),
              profileMenu(onPressed: (){}, title: 'Phone No.', value: '+91 5615423157'),
              profileMenu(onPressed: (){}, title: 'Gender', value: 'Male'),
              profileMenu(onPressed: (){}, title: 'Date of Birth', value: '16 Sep, 2003'),
              Divider(),

              ///Close account
              TextButton(onPressed: ()=> controller.deleteAccountWarning(), child: Text('Close Account', style: TextStyle(color: Colors.red, fontSize: 15),),),
              SizedBox(width: double.infinity,child: OutlinedButton(onPressed: ()=> Get.offAll(()=> loginScreen()), child: Text('Logout'),),),
            ],
          ),
        ),
      ),
    );
  }
}


