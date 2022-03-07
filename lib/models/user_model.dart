class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isEmailVerified;
  String? bio;
  String? profileImage;

  UserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.isEmailVerified = false,
    this.bio = "Hey there, I'm using Nchat",
    this.profileImage = "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png"
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
    bio = json['bio'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'uId' : uId,
      'isEmailVerified': isEmailVerified,
      'bio': bio,
      'profileImage': profileImage
    };
  }
}
