import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapplication/cubit/cubit.dart';
import 'package:socialapplication/cubit/states/socialstates.dart';
import 'package:socialapplication/models/usersmodel.dart';
import 'package:socialapplication/share/component.dart';

class editprofile extends StatelessWidget {
  editprofile({Key? key}) : super(key: key);
  var namecotroller = TextEditingController();
  var biocontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  var phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appcubit, appstates>(
      listener: (BuildContext context, state) {
        if (state is updateuserdataerrorState) {
          showToast(text: '${Error}', state: ToastStates.ERROR);
        } else if (state is updateuserdatasuccessState) {
          showToast(
              text: 'your profile updated successfully ',
              state: ToastStates.SUCCESS);
        }
      },
      builder: (BuildContext context, state) {
        var model = appcubit.get(context).userModel;

        var profileimage = appcubit.get(context).profileImage;
        var coverimage = appcubit.get(context).coverImage;

        print(model!.name);
        print(model.bio);
        print(model.phone);

        namecotroller.text = model.name!;
        biocontroller.text = model.bio!;
        phonecontroller.text = model.phone!;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'edit profile',
            ),
            leading: const Icon(Icons.arrow_back_ios),
            actions: [
              IconButton(
                  onPressed: () {
                    appcubit.get(context).updateuserdata(
                          name: namecotroller.text,
                          bio: biocontroller.text,
                          phone: phonecontroller.text,
                          email: emailcontroller.text,
                        );
                  },
                  icon: const Text(
                    'edit',
                    style: TextStyle(color: Colors.blue, fontSize: 17.0),
                  )),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is updateuserdataloadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 150,
                                width: double.infinity,
                                child: Image(
                                  image: (coverimage == null
                                      ? NetworkImage('${model.image}')
                                      : FileImage(coverimage)) as ImageProvider,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                                alignment: AlignmentDirectional.topEnd,
                              ),
                              IconButton(
                                onPressed: () {
                                  appcubit.get(context).getcoverImage();
                                },
                                icon: const CircleAvatar(
                                    radius: 10.0,
                                    child: Icon(
                                      Icons.camera_alt_rounded,
                                      size: 16.0,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 56.0,
                              child: CircleAvatar(
                                  radius: 55.0,
                                  backgroundImage: (profileimage == null
                                          ? NetworkImage('${model.name}')
                                          : FileImage(profileimage))
                                      as ImageProvider),
                            ),
                            IconButton(
                              onPressed: () {
                                appcubit.get(context).getProfileImage();
                              },
                              icon: const CircleAvatar(
                                  radius: 10.0,
                                  child: Icon(
                                    Icons.camera_alt_rounded,
                                    size: 16.0,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const Text(
                    'edit your profile',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: namecotroller,
                    onFieldSubmitted: (value) {},
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      label: Text('name'),
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return '3 name must be filled ';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: biocontroller,
                    decoration: const InputDecoration(
                      label: Text('bio'),
                      prefixIcon: Icon(
                        Icons.description_sharp,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'bio  must be filled ';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: phonecontroller,
                    decoration: const InputDecoration(
                        label: Text('phone'),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone)),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'phone  must be filled ';
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
