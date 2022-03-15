abstract class registerstates {}

class initialregisterstates extends registerstates {}

class registerloadingstate extends registerstates {}

class registersuccessstate extends registerstates {
 

}

class registererrorstate extends registerstates {
  final String Error;

  registererrorstate(
   this.Error,
  );
}

class createloadingstate extends registerstates {}

class createsuccessstate extends registerstates {
  final String ?uid;
  createsuccessstate(this.uid);

}

class createerrorstate extends registerstates {
  final String error;

  createerrorstate({
    required this.error,
  });
}
class changepassvisibilitystates extends registerstates {}


// for git user credintIAL 