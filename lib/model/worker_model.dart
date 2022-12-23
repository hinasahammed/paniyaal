class WorkerModel {
  String? uid;
  String? email;
  String? fullName;

  WorkerModel({this.uid, this.email, this.fullName,});

  // receiving data from server
  factory WorkerModel.fromMap(map) {
    return WorkerModel(
      uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
    };
  }
}