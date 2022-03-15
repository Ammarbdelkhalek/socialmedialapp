import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapplication/cubit/cubit.dart';
import 'package:socialapplication/cubit/states/socialstates.dart';

class socialpplayout extends StatelessWidget {
  const socialpplayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appcubit, appstates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = appcubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.title![cubit.pageindex]),
              actions: const [
                Icon(Icons.notifications),
                Icon(
                  Icons.search_sharp,
                ),
              ],
            ),
            body: cubit.screens[cubit.pageindex],
            bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Colors.black87,
                unselectedItemColor: Colors.grey,
                elevation: 8.0,
                currentIndex: cubit.pageindex,
                items: cubit.items,
                onTap: (index) {
                  cubit.changeindex(index);
                }),
          );
        });
  }
}
