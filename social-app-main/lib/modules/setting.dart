import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapplication/cubit/cubit.dart';
import 'package:socialapplication/cubit/states/socialstates.dart';
import 'package:socialapplication/models/usersmodel.dart';
import 'package:socialapplication/modules/editprofile.dart';
import 'package:socialapplication/share/component.dart';

class settings extends StatelessWidget {
  const settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appcubit, appstates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<appcubit, appstates>(
            listener: (context, state) {},
            builder: (context, state) {
              //  var model = appcubit.get(context).usermodel;
              usersmodel? usermodel;
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 190,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                child: Image(
                                  image: NetworkImage('${usermodel?.cover}'),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                                alignment: AlignmentDirectional.topCenter,
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 56.0,
                              child: CircleAvatar(
                                radius: 55.0,
                                backgroundImage:
                                    NetworkImage('${usermodel?.cover}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        '${usermodel?.name}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text('${usermodel?.bio} '),
                      const SizedBox(
                        height: 17.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: const [
                                  Text('100'),
                                  Text('posts '),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: const [
                                  Text('100'),
                                  Text('following'),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: const [
                                  Text('100'),
                                  Text('followers '),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: const [
                                  Text('100'),
                                  Text('followers '),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 17.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: const Text('add photo'),
                            ),
                          ),
                          const SizedBox(width: 4.0),
                          OutlinedButton(
                            onPressed: () {
                              navigateTo(context, editprofile());
                            },
                            child: Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
