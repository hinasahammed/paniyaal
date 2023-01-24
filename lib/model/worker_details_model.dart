class WorkerDetailsModel {
  String? email;
  String? fullName;
  String? phoneNumber;

  WorkerDetailsModel({this.email, this.fullName,this.phoneNumber});

  // receiving data from server
  factory WorkerDetailsModel.fromMap(map) {
    return WorkerDetailsModel(
      email: map['email'],
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
    };
  }
}