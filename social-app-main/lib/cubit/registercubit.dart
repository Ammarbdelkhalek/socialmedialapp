import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapplication/cubit/states/registerstates.dart';
import 'package:socialapplication/models/usersmodel.dart';
import 'package:socialapplication/share/constant.dart';

class registercubit extends Cubit<registerstates> {
  registercubit() : super(initialregisterstates());
  static registercubit get(context) => BlocProvider.of(context);
  IconData icon = Icons.visibility_off;
  bool ispass = false;

  void registerdata({
    required String? name,
    required String? phone,
    required String? email,
    required String? password,
  }) {
    emit(registerloadingstate());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      createuser(
        name: name,
        phone: phone,
        email: email,
        uid: value.user!.uid,
      );
    }).catchError((error) {
      print(error.toString());
      emit(registererrorstate(error));
    });
  }

  void createuser({
    required String? name,
    required String? phone,
    required String? email,
    required String? uid,
  }) {
    usersmodel? model = usersmodel(
      email: email,
      phone: phone,
      uid: uid,
      name: name,
      isemailverifre: false,
      image:
          'https://scontent.fcai19-4.fna.fbcdn.net/v/t1.6435-9/50627124_803928993285293_558543252551106560_n.jpg?_nc_cat=104&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=nJrEyd-oTl4AX9OGRO3&_nc_ht=scontent.fcai19-4.fna&oh=00_AT_TYL8vHKiRx6pePcPiRux00vEgkmdS_95DFTnmqII10w&oe=6247E556',
      cover:
          'https://scontent.fcai19-4.fna.fbcdn.net/v/t1.6435-9/50627124_803928993285293_558543252551106560_n.jpg?_nc_cat=104&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=nJrEyd-oTl4AX9OGRO3&_nc_ht=scontent.fcai19-4.fna&oh=00_AT_TYL8vHKiRx6pePcPiRux00vEgkmdS_95DFTnmqII10w&oe=6247E556',
      bio: 'this is our vision ',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(createsuccessstate(model.uid));
    }).catchError((Error) {
      print(Error.toString());
      emit(createerrorstate(error: Error));
    });
  }

  void changevisibilepass() {
    ispass = !ispass;
    ispass ? icon = Icons.visibility_off : icon = Icons.visibility;
    emit(changepassvisibilitystates());
  }
}
