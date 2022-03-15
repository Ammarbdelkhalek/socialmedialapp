import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:socialapplication/cubit/logincubit.dart';
import 'package:socialapplication/cubit/states/loginstates.dart';

import 'package:socialapplication/modules/login.dart';

import '../share/component.dart';
import '../share/sharedpreference.dart';

class onboardingmodel {
  String? image;
  String? title;
  String? body;

  onboardingmodel({
    this.image,
    this.body,
    this.title,
  });
}

class onboardingscreen extends StatefulWidget {
  const onboardingscreen({Key? key}) : super(key: key);

  @override
  State<onboardingscreen> createState() => _onboardingscreenState();
}

class _onboardingscreenState extends State<onboardingscreen> {
  List<onboardingmodel> model = [
    onboardingmodel(
      image:
          'https://cdn.pixabay.com/photo/2020/05/18/16/17/social-media-5187243__340.png',
      title: 'onboarding',
      body: 'contact with other and have your opportunityu ',
    ),
    onboardingmodel(
      image:
          'https://akm-img-a-in.tosshub.com/businesstoday/images/story/201907/bt_24_25_660_072319045145.jpg',
      title: 'onboarding',
      body: 'make a relationship with other ',
    ),
    onboardingmodel(
      image:
          'https://www.pngitem.com/pimgs/m/500-5004833_side-img-people-chatting-on-social-media-hd.png',
      title: 'title of onbiae=rding here for still text',
      body: 'anew journy for new deiggn  to learn about ',
    )
  ];
  void submit() {
    CacheHelper.saveData(
      key: 'onBoard',
      value: true,
    ).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          loginpagee(),
        );
      }
    });
  }

  var boardController = PageController();

  int? pageindex = 0;
  bool isthird = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: const Text(
              'skip',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.deepOrange,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
            child: PageView.builder(
              itemBuilder: (context, index) =>
                  buildonboardingitems(model[index]),
              controller: boardController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (int index) {
                if (index == model.length - 1) {
                  setState(() {
                    isthird = false;
                  });
                }
                setState(() {
                  isthird = true;
                });
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 35.0,
          ),
          Row(
            children: [
              SmoothPageIndicator(
                effect: const ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Colors.deepOrange,
                  dotWidth: 10.0,
                  dotHeight: 10.0,
                  spacing: 5.0,
                  expansionFactor: 4.0,
                ),
                controller: boardController,
                count: model.length,
              ),
              Spacer(),
              FloatingActionButton(
                  backgroundColor: Colors.deepOrange,
                  onPressed: () {
                    if (isthird == true) {
                      submit();
                    } else {
                      boardController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios_outlined)),
            ],
          )
        ]),
      ),
    );
  }
}
