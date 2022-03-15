import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialapplication/cubit/logincubit.dart';
import 'package:socialapplication/cubit/states/loginstates.dart';
import 'package:socialapplication/main.dart';
import 'package:socialapplication/modules/layout.dart';
import 'package:socialapplication/modules/register.dart';
import 'package:socialapplication/share/component.dart';
import 'package:socialapplication/share/sharedpreference.dart';
import '../share/constant.dart';

class loginpagee extends StatelessWidget {
  loginpagee({Key? key}) : super(key: key);
  var formkey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<logincubit>(
      create: (context) => logincubit(),
      child: BlocConsumer<logincubit, loginstates>(listener: (context, state) {
        if (state is loginerrorstate) {
          showToast(text: state.error, state: ToastStates.ERROR);
        } else if (state is loginsuccessstate) {
          showToast(text: 'successfully', state: ToastStates.ERROR);
          CacheHelper.saveData(key: 'uid', value: state.uid).then((value) {
            navigateAndFinish(context, socialpplayout());
          });
        }
      }, builder: (context, state) {
        var cubit = logincubit.get(context);

        return Scaffold(
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(2500),
            )),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(150),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 2, 70),
                  child: Row(children: const [
                    Text(
                      'welcome ',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(5, 10, 0, 5),
                        child: Icon(
                          Icons.supervised_user_circle_sharp,
                          color: Colors.blue,
                        )),
                    // Padding(
                    //   padding: EdgeInsets.fromLTRB(33, 8, 0, 0),
                    //   child: IconButton(
                    //     onPressed: () {
                    //
                    //     },
                    //     icon: Icon(Icons.menu, color:mycolor1 ,)),
                    // )
                  ])),
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'login',
                        style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.headline4),
                      ),
                      Text(
                        'welcome to our system login !',
                        style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailcontroller,
                        onFieldSubmitted: (value) {},
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                          label: Text('email'),
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Email Address must be filled ';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 9.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordcontroller,
                        onFieldSubmitted: (value) {},
                        obscureText: cubit.ispass!,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          label: const Text('password'),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: MaterialButton(
                            onPressed: () {
                              cubit.changevisibilepassword();
                            },
                            child: Icon(cubit.icon),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "the password must be fill";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                          condition: state is! loginloadingstate,
                          builder: (context) => Container(
                                width: double.infinity,
                                height: 40.0,
                                child: MaterialButton(
                                  onPressed: () {
                                    if (formkey.currentState!.validate()) {
                                      cubit.userlogin(
                                          email: emailcontroller.text,
                                          password: passwordcontroller.text);
                                    }
                                  },
                                  child: const Text(
                                    "login",
                                  ),
                                  color: Colors.blue,
                                ),
                              ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator())),
                      const SizedBox(height: 20.0),
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        child: MaterialButton(
                          onPressed: () async {
                            UserCredential user = await signInWithGoogle();
                          },
                          child: const Text(
                            "google acount ",
                          ),
                          color: Colors.blue,
                        ),
                      ),
                      Row(
                        children: [
                          const Text("Don\'t have an account?"),
                          const SizedBox(
                            width: 5.0,
                          ),
                          TextButton(
                            onPressed: () {
                              navigateAndFinish(context, registerpage());
                            },
                            child: const Text('register'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
