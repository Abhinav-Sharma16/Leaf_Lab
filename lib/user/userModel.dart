import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leaf_lab/utils/formatters/formatter.dart';

class UserModel {
  // keep values final which do not want to update

  final String id, userName, email;
  String firstName, lastName, phoneNumber, profilePic;

  //costructor for userModel
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePic
  });

  //helper fn to get full name
  String get fullName => '$firstName $lastName';

  //helper fn to formate phone number
  String get formattedPhoneNumber => TFormatter.formatPhoneNumber(phoneNumber);

  //static fn to split full name into first and last name
  static List<String> nameParts(fullName) => fullName.split(" ");

  //static fn to generate username from the full name
  static String generateUsername(fullName){
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase(): "";

    String cameCaseUsername = "$firstName$lastName";
    String userNamewithPrefix = "leafLab_$cameCaseUsername";
    return userNamewithPrefix;
  }

  ///static fn to create empty usermodel
  static UserModel empty()=> UserModel(id: '', firstName: '', lastName: '', userName: '', email: '', phoneNumber: '', profilePic: '');

  /// convert model to JSON Structure to store in firebase
  Map<String, dynamic> toJson(){
    return{
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePic,
    };
  }

  ///factory method to create usermoidel from firebase document snapshot
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    if(document.data()!=null){
      final data = document.data()!;
      return UserModel(id: document.id, firstName: data['firstName'] ?? '', lastName: data['lastName'] ?? '', userName: data['userName'] ?? '', email: data['email'] ?? '', phoneNumber: data['phoneNumber'] ?? '', profilePic: data['profilePicture'] ?? '');
    }
    return empty();
  }
}
