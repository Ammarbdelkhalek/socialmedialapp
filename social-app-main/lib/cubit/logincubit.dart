import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapplication/cubit/states/loginstates.dart';
import 'package:google_sign_in/google_sign_in.dart';

class logincubit extends Cubit<loginstates> {
  logincubit() : super(initialloginstates());
  static logincubit get(context) => BlocProvider.of(context);

  IconData icon = Icons.visibility_off;
  bool? ispass = true;
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  void changevisibilepassword() {
    ispass = !ispass!;
    ispass! ? icon = Icons.visibility_off : icon = Icons.visibility;
    emit(changepassvisibilitystate());
  }

  void userlogin({
    required String? email,
    required String? password,
  }) {
    emit(loginloadingstate());
    print('hello');
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(loginsuccessstate(value.user!.uid));
    }).catchError((error) {
      print(error.toString());
      emit(loginerrorstate(error: error));
    });
  }
}
