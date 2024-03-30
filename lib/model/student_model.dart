// ignore_for_file: public_member_api_docs, sort_constructors_first
class StudentModel {
  String? email;
  String? uid;
  String? school;
  String? username;
  String? phone;
  String? age;
  String? password;
  String? image;
  String? location;
  StudentModel({
    this.email,
    this.uid,
    this.school,
    this.username,
    this.phone,
    this.age,
    this.password,
    this.image,
    this.location,
  });
  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      email: map['email'],
      uid: map['uid'],
      school: map['school'],
      username: map['username'],
      phone: map['phone'],
      age: map['age'],
      password: map['password'],
      image: map['image'],
      location: map['location'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'uid': uid,
      'school': school,
      'username': username,
      'phone': phone,
      'age': age,
      'password': password,
      'image': image,
      'location': location,
    };
  }
}
