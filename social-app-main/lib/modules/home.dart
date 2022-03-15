import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapplication/cubit/cubit.dart';
import 'package:socialapplication/cubit/states/socialstates.dart';
import 'package:socialapplication/models/usersmodel.dart';
import 'package:socialapplication/share/component.dart';

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appcubit, appstates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: const EdgeInsets.all(2.0),
                    elevation: 8.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150.0,
                          child: const Image(
                            image: NetworkImage(
                                'https://i1.wp.com/thinkmarketingmagazine.com/wp-content/uploads/2019/07/Egypt-forward-Mohamed-Salah-has-won-the-CAF-African-Footballer-of-the-Year-for-the-second-time-in-a-row.jpg?resize=708%2C425&ssl=1'),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        const Text(
                          'communicat with your friends ',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => builditems(context),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10.0,
                        ),
                    itemCount: 4),
                const SizedBox(
                  height: 100.0,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget builditems(
    context,
  ) =>
      Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 6.0,
        child: Column(children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 22.0,
                backgroundImage: NetworkImage(
                    'https://i1.wp.com/thinkmarketingmagazine.com/wp-content/uploads/2019/07/Egypt-forward-Mohamed-Salah-has-won-the-CAF-African-Footballer-of-the-Year-for-the-second-time-in-a-row.jpg?resize=708%2C425&ssl=1'),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(children: const [
                    Text(
                      'ammar abdelkhalek',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.check_circle,
                      color: Colors.blue,
                      size: 12.0,
                    ),
                  ]),
                  const SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    'january 21- 2022 at 12.00pm',
                    style: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  const Icon(
                    Icons.public,
                    size: 12.0,
                  )
                ],
              ),
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
            ],
          ),
          const SizedBox(
            height: 5.0,
          ),
          Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
          const SizedBox(
            height: 5.0,
          ),
          const Text(
            'Now, I can say that Mohamed Salah is my favorite footballer. There are many reasons why I love him. His performance on the pitch is a major factor, but there are other factors too.',
            maxLines: 4,
            overflow: TextOverflow.clip,
          ),
          const SizedBox(
            height: 7.0,
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: Container(
              width: double.infinity,
              child: Wrap(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: 1.0),
                    child: Container(
                      height: 25.0,
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: 0.5,
                        padding: EdgeInsets.zero,
                        child: const Text(
                          '#software_engineer',
                          style: TextStyle(
                            color: Color.fromARGB(255, 32, 145, 238),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: 1.0,
                    ),
                    child: Container(
                      height: 25.0,
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: 0.5,
                        padding: EdgeInsets.zero,
                        child: const Text(
                          '#software_engineer',
                          style: TextStyle(
                            color: Color.fromARGB(255, 32, 145, 238),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      end: 1.0,
                    ),
                    child: Container(
                      height: 25.0,
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: 0.5,
                        padding: EdgeInsets.zero,
                        child: const Text(
                          '#software_engineer',
                          style: TextStyle(
                            color: Color.fromARGB(255, 32, 145, 238),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 7.0,
          ),
          Container(
            height: 150,
            width: double.infinity,
            child: const Image(
              image: NetworkImage(
                  'https://i1.wp.com/thinkmarketingmagazine.com/wp-content/uploads/2019/07/Egypt-forward-Mohamed-Salah-has-won-the-CAF-African-Footballer-of-the-Year-for-the-second-time-in-a-row.jpg?resize=708%2C425&ssl=1'),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 6.0,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.heart_broken_sharp,
                          size: 15.0,
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          '111',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(
                          Icons.chat,
                          size: 15.0,
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          '111 comment ',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
          Row(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const CircleAvatar(
                  radius: 15.0,
                  backgroundImage: NetworkImage(
                      'https://i1.wp.com/thinkmarketingmagazine.com/wp-content/uploads/2019/07/Egypt-forward-Mohamed-Salah-has-won-the-CAF-African-Footballer-of-the-Year-for-the-second-time-in-a-row.jpg?resize=708%2C425&ssl=1'),
                ),
                const SizedBox(
                  width: 7.0,
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'write your comment ..',
                    style: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: () {},
                      minWidth: 1.0,
                      child: Icon(Icons.heart_broken_outlined),
                    ),
                    const SizedBox(
                      width: 7.0,
                    ),
                    MaterialButton(
                        onPressed: () {},
                        minWidth: 1.0,
                        child: const Icon(Icons.chat)),
                  ],
                )
              ]),
            ],
          ),
          Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ]),
      );
}
