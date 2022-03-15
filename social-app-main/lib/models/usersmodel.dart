class usersmodel {
  String? name;
  String? email;
  String? phone;
  String? uid;
  String? image;
  String? cover;
  String? bio;
  bool? isemailverifre;

  usersmodel({
    this.email,
    this.name,
    this.phone,
    this.uid,
    this.image,
    this.cover,
    this.isemailverifre,
    this.bio,
  });

  usersmodel.fromJson(Map<String, dynamic> json) {
    name = json['email'];
    email = json['email'];
    phone = json['phone'];
    uid = json['uid'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];

    isemailverifre = json['isemailverifre'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name ': name,
      'email ': email,
      'phone ': phone,
      'uid': uid,
      'isemailverifre': isemailverifre,
    };
  }
}
