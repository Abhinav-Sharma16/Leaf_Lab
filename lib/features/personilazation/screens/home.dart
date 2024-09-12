import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leaf_lab/utils/constants/sizes.dart';
import 'package:leaf_lab/utils/helpers/helper_functions.dart';
import '../../../camera/details.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {

  late File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const SizedBox(height: 24.7,),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                child: Image(height: 240,
                    image: AssetImage(THelperFunctions.isDarkMode(context)
                        ? 'assets/logos/dark app logo.png'
                        : 'assets/logos/light app logo.png')),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.green),
                        color: Colors.green[100]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(TSizes.xs),
                      child: TextFormField(
                        textAlign: TextAlign.left,
                        autofillHints: const {'nef', 'sfkjse', 'fhk'},
                        textAlignVertical: TextAlignVertical.top,
                        decoration: const InputDecoration(
                            hintText: 'Aloe Vera',
                            hintStyle: TextStyle(
                                fontSize: 12, color: Colors.grey),
                            floatingLabelStyle: TextStyle(fontSize: 10),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent)),
                            prefixIcon: Icon(Iconsax.direct_right),
                            labelText: 'Search Plant',
                            floatingLabelBehavior: FloatingLabelBehavior.never
                        ),),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50,),
              InkWell(
                onTap: _optionDialogBox,
                splashColor: Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  //color: Colors.white,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  width: 180,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Icon(CupertinoIcons.camera_on_rectangle, size: 50,
                        color: Colors.green,),

                      Icon(CupertinoIcons.photo_on_rectangle, size: 50,
                        color: Colors.green,),
                      Text('Tap to Identify',
                        style: TextStyle(fontWeight: FontWeight.bold),)
                    ],),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _optionDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.greenAccent,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    onTap: openCamera,
                    child: const Text(
                      'Take a Picture',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  GestureDetector(
                    onTap: openGallery,
                    child: const Text(
                      'Select  from Gallery',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  //Camera Method
  Future openCamera() async {
    Navigator.pop(context);

    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Details(imageFile: _image),
        ),
      );
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future openGallery() async {
    Navigator.pop(context);

    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picture != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Details(imageFile: _image),
        ),
      );
      setState(() {
        _image = File(picture.path);
      });
    }
  }
}
