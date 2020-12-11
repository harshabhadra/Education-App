import 'package:json_annotation/json_annotation.dart';
part 'studentinfo.g.dart';

@JsonSerializable()
class StudentInfo {
  String email;
  String name;
  int contactNumber;
  String address;
  String country;
  String gender;
  String dob;
  String profDetails;

  StudentInfo(
      {this.email,
      this.name,
      this.contactNumber,
      this.address,
      this.country,
      this.gender,
      this.dob,
      this.profDetails});

  StudentInfo.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    contactNumber = json['contactNumber'];
    address = json['address'];
    country = json['country'];
    gender = json['gender'];
    dob = json['dob'];
    profDetails = json['profDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['contactNumber'] = this.contactNumber;
    data['address'] = this.address;
    data['country'] = this.country;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['profDetails'] = this.profDetails;
    return data;
  }
}
