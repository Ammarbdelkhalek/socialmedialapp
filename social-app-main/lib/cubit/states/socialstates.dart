abstract class appstates {}

class initialappstates extends appstates {}

class getuserloadingstate extends appstates {}

class getusersucessstate extends appstates {}

class getusererrorstate extends appstates {
  final error;
  getusererrorstate(this.error);
}

class changenavstate extends appstates {}

class newpoststate extends appstates {}

class SocialProfileImagePickedloadingState extends appstates {}

class SocialProfileImagePickedSuccessState extends appstates {}

class SocialProfileImagePickederrorState extends appstates {
  final error;
  SocialProfileImagePickederrorState(this.error);
}

class SocialcoverImagePickedloadingState extends appstates {}

class SocialcoverImagePickedSuccessState extends appstates {}

class SocialcoverImagePickederrorState extends appstates {
  final error;
  SocialcoverImagePickederrorState(this.error);
}

class upploaduserdatasuccessState extends appstates {}

class uploaduserdataerrorState extends appstates {
  final error;
  uploaduserdataerrorState(this.error);
}

class updateuserdataloadingState extends appstates {}

class updateuserdatasuccessState extends appstates {}

class updateuserdataerrorState extends appstates {
  final error;
  updateuserdataerrorState(this.error);
}
