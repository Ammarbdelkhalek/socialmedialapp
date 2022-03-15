abstract class loginstates {}

class initialloginstates extends loginstates {}

class loginloadingstate extends loginstates {}

class loginsuccessstate extends loginstates {
  final String? uid;
  loginsuccessstate(this.uid);
}

class loginerrorstate extends loginstates {
  final String error;

  loginerrorstate({
    required this.error,
  });
}

class changepassvisibilitystate extends loginstates {}

class googleloginloadingstate extends loginstates {}

class googleloginsuccessstate extends loginstates {}

class googleloginerrorstate extends loginstates {
  final String error;

  googleloginerrorstate({
    required this.error,
  });
}
