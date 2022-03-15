import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialapplication/cubit/registercubit.dart';
import 'package:socialapplication/cubit/states/registerstates.dart';
import 'package:socialapplication/modules/layout.dart';
import 'package:socialapplication/share/component.dart';
import 'package:socialapplication/share/constant.dart';
import 'package:socialapplication/share/sharedpreference.dart';

import '../share/constant.dart';

class registerpage extends StatelessWidget {
  registerpage({Key? key}) : super(key: key);

  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => registercubit(),
      child: BlocConsumer<registercubit, registerstates>(
          listener: (context, state) {
        if (state is createsuccessstate) {
          showToast(text: 'sucssefuly ', state: ToastStates.SUCCESS);
          navigateAndFinish(context, socialpplayout());
        }else if(state is registererrorstate){
           showToast(text: Error.safeToString(Error) , state: ToastStates.ERROR);
        }

      }, builder: (context, state) {
        var cubit = registercubit.get(context);
        return Scaffold(
          appBar: AppBar(),
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
                        'register',
                        style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.headline4),
                      ),
                      Text(
                        'welcome to our system register !',
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
                        keyboardType: TextInputType.name,
                        controller: namecontroller,
                        onFieldSubmitted: (value) {},
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                          label: Text('name'),
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'name must be filled ';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailcontroller,
                        onFieldSubmitted: (value) {},
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                          label: Text('email'),
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "the email must be fill";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phonecontroller,
                        onFieldSubmitted: (value) {},
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                          label: Text('phone'),
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "the phone must be fill";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordcontroller,
                        onFieldSubmitted: (value) {},
                        onChanged: (value) {},
                        obscureText: cubit.ispass,
                        decoration: InputDecoration(
                          label: const Text('password'),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: MaterialButton(
                            onPressed: () {
                              cubit.changevisibilepass();
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
                          condition: state is! registerloadingstate,
                          builder: (context) => Container(
                                width: double.infinity,
                                height: 40.0,
                                child: MaterialButton(
                                  onPressed: () {
                                    if (formkey.currentState!.validate()) {
                                      cubit.registerdata(
                                          name: namecontroller.text,
                                          email: emailcontroller.text,
                                          phone: phonecontroller.text,
                                          password: passwordcontroller.text);
                                    }
                                  },
                                  child: const Text(
                                    "register",
                                  ),
                                  color: Colors.blue,
                                ),
                              ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator())),
                      const SizedBox(height: 20.0),
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
