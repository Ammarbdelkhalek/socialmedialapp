import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapplication/cubit/cubit.dart';
import 'package:socialapplication/cubit/states/socialstates.dart';
import 'package:socialapplication/share/component.dart';

class verificationpage extends StatelessWidget {
  const verificationpage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appcubit, appstates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: appcubit.get(context).userModel != null,
          builder: (context) => Scaffold(
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 45.0, horizontal: 10.0),
              child: Container(
                color: Colors.yellowAccent,
                width: double.infinity,
                child: Row(
                  children: [
                    if (FirebaseAuth.instance.currentUser!.emailVerified)
                      const Icon(Icons.info_outline_rounded),
                    const SizedBox(
                      width: 7.0,
                    ),
                    const Text('please verify your email'),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.currentUser!
                              .sendEmailVerification()
                              .then((value) {
                            showToast(
                                text: 'check your mail ',
                                state: ToastStates.SUCCESS);
                          }).catchError((Error) {});
                        },
                        child: const Text('SEND')),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
