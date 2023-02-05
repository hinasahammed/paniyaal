class UserLogedinModel {
  String? uid;
  String? fullName;
  String? phoneNumber;
  String? imageUrl;

  UserLogedinModel({
    this.uid,
    this.fullName,
    this.phoneNumber,
    this.imageUrl,
  });

  // receiving data from server
  factory UserLogedinModel.fromMap(map) {
    return UserLogedinModel(
      uid: map['uid'],
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
      imageUrl: map['imageUrl'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
    };
  }
}
