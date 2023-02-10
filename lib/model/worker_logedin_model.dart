class WorkerLogedinModel {
  String? uid;
  String? email;
  String? fullName;
  String? password;
  String? phoneNumber;
  String? imageUrl;
  String? jobType;
  String? jobTypeOther;
  String? location;

  WorkerLogedinModel({
    this.uid,
    this.email,
    this.fullName,
    this.password,
    this.phoneNumber,
    this.imageUrl,
    this.jobType,
    this.jobTypeOther,
    this.location,
  });

  // receiving data from server
  factory WorkerLogedinModel.fromMap(map) {
    return WorkerLogedinModel(
      uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      password: map['password'],
      phoneNumber: map['phoneNumber'],
      imageUrl: map['imageUrl'],
      jobType: map['jobType'],
      jobTypeOther: map['jobTypeOther'],
      location: map['location'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'password': password,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'jobType': jobType,
      'jobTypeOther': jobTypeOther,
      'location': location,
    };
  }
}
