import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RegisterModel {
  final String? uid;
  final String uName;
  final String uEmail;
  final String uPassword;
  final String uPhone;
  final String uProfilePic;
  final bool isActive;
  final bool isOnline;
  final String? gender;
  RegisterModel({
    this.uid,
    required this.uPassword,
    required this.uName,
    required this.uEmail,
    required this.uPhone,
    this.uProfilePic = "",
    this.isActive = true,
    this.isOnline = false,
    this.gender,
  });

  RegisterModel copyWith({
    String? uid,
    String? uName,
    String? uEmail,
    String? uPassword,
    String? uPhone,
    String? uProfilePic,
    bool? isActive,
    bool? isOnline,
    String? gender,
  }) {
    return RegisterModel(
      uid: uid ?? this.uid,
      uPassword: uPassword ?? this.uPassword,
      uName: uName ?? this.uName,
      uEmail: uEmail ?? this.uEmail,
      uPhone: uPhone ?? this.uPhone,
      uProfilePic: uProfilePic ?? this.uProfilePic,
      isActive: isActive ?? this.isActive,
      isOnline: isOnline ?? this.isOnline,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'uName': uName,
      'uEmail': uEmail,
      'uPassword': uPassword,
      'uPhone': uPhone,
      'uProfilePic': uProfilePic,
      'isActive': isActive,
      'isOnline': isOnline,
      'gender': gender,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      uid: map['uid'] as String,
      uName: map['uName'] as String,
      uEmail: map['uEmail'] as String,
      uPassword: map['uPassword'] as String,
      uPhone: map['uPhone'] as String,
      uProfilePic: map['uProfilePic'] as String,
      isActive: map['isActive'] as bool,
      isOnline: map['isOnline'] as bool,
      gender: map['gender'] != null ? map['gender'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterModel.fromJson(String source) =>
      RegisterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RegisterModel(uName: $uName, uEmail: $uEmail,uPassword: $uPassword,uPhone: $uPhone, uProfilePic: $uProfilePic, isActive: $isActive, isOnline: $isOnline, gender: $gender ,uid: $uid)';
  }
}
