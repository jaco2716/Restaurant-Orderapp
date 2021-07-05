class User {
  String uid;
  String fullName;
  String phoneNr;
  String email;

  User({required this.uid, required this.fullName, required this.phoneNr, required this.email});

  User.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        fullName = json['fullName'],
        phoneNr = json['phoneNr'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'fullName': fullName,
        'phoneNr': phoneNr,
        'email': email,
      };
}
