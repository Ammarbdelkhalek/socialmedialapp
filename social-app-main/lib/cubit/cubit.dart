import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapplication/cubit/states/socialstates.dart';
import 'package:socialapplication/models/usersmodel.dart';
import 'package:socialapplication/modules/chats.dart';
import 'package:socialapplication/modules/home.dart';
import 'package:socialapplication/modules/new_post.dart';
import 'package:socialapplication/modules/setting.dart';
import 'package:socialapplication/modules/user.dart';
import 'package:socialapplication/share/constant.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class appcubit extends Cubit<appstates> {
  appcubit() : super(initialappstates());
  static appcubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
    BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'chat'),
    BottomNavigationBarItem(
        icon: Icon(Icons.file_upload_outlined), label: 'posts'),
    BottomNavigationBarItem(icon: Icon(Icons.location_pin), label: 'location'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'setting'),
  ];

  List<String>? title = ['Home', 'chats', 'new post', 'user', 'setting'];

  List screens = [
    home(),
    chats(),
    posts(),
    users(),
    settings(),
  ];
  int pageindex = 0;
  void changeindex(int index) {
    pageindex = index;
    if (index == 2) {
      emit(newpoststate());
    } else {
      pageindex = index;
      emit(changenavstate());
    }
  }

  usersmodel? userModel;
  void getUserData() {
    emit(getuserloadingstate());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      userModel = usersmodel.fromJson(value.data()!);
      print(value.data());
      emit(getusersucessstate());
    }).catchError((error) {
      print(error.toString());
      emit(getusererrorstate(error.toString()));
    });
  }

  /* usersmodel? usermodel;
  void getuserdata() {
    emit(getuserloadingstate());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      print(value.data());
      usermodel = usersmodel.fromJson(value.data()!);
      emit(getusersucessstate());
    }).catchError((error) {
      print(error.toString());
      emit(getusererrorstate(error));
    });
  }*/

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialProfileImagePickederrorState(Error));
    }
  }

  File? coverImage;

  Future<void> getcoverImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialcoverImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialcoverImagePickederrorState(Error));
    }
  }

  String? profileimageurl;

  void Uploadprofileimage({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(upploaduserdatasuccessState());
        print(value);
        profileimageurl = value;
        usersmodel model = usersmodel(
          phone: phone,
          name: name,
          email: userModel!.email,
          uid: userModel!.uid,
          isemailverifre: false,
          image: value,
          cover: userModel!.image,
          bio: bio,
        );
      }).catchError((Error) {
        emit(uploaduserdataerrorState(Error));
      });
    }).catchError((Error) {
      emit(uploaduserdataerrorState(Error));
    });
  }

  String? coverimageurl;

  void Uploadcoverimage({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        value = coverimageurl!;
        usersmodel model = usersmodel(
          phone: phone,
          name: name,
          email: userModel!.email,
          uid: userModel!.uid,
          isemailverifre: false,
          image: userModel!.image,
          cover: value,
          bio: bio,
        );

        emit(upploaduserdatasuccessState());
      }).catchError((Error) {
        emit(uploaduserdataerrorState(Error));
      });
    }).catchError((Error) {
      emit(uploaduserdataerrorState(Error));
    });
  }

  void updateuserdata({
    required String name,
    required String phone,
    required String bio,
    final String? email,
    String? image,
    String? cover,
  }) {
    usersmodel model = usersmodel(
      phone: phone,
      name: name,
      email: email ?? userModel!.email,
      uid: userModel!.uid,
      isemailverifre: false,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      bio: bio,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update(model.toMap())
        .then((value) {
      getUserData();
      emit(updateuserdatasuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(updateuserdataerrorState(Error));
    });
  }
}
