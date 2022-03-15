import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapplication/modules/onboarding.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(
        text.toUpperCase(),
      ),
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget buildonboardingitems(
  onboardingmodel model,
) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: NetworkImage('${model.image}'),
        ),
        const SizedBox(
          height: 50.0,
        ),
        Text(
          '${model.title}',
          style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(
          '${model.body}',
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
Widget newline() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey,
    );
Widget defaultappbar({
  required BuildContext context,
  required String title,
}) =>
    AppBar(
      title: Text(
        title,
      ),
      actions: [
        const Icon(Icons.arrow_back_ios),
      ],
    );
