
import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
class ProfileResponse {
  Status _status;
  StudentInfo _studentInfo;

  ProfileResponse({Status status, StudentInfo studentInfo}) {
    this._status = status;
    this._studentInfo = studentInfo;
  }

  Status get status => _status;
  set status(Status status) => _status = status;
  StudentInfo get studentInfo => _studentInfo;
  set studentInfo(StudentInfo studentInfo) => _studentInfo = studentInfo;

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    _status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    _studentInfo = json['studentInfo'] != null
        ? new StudentInfo.fromJson(json['studentInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._status != null) {
      data['status'] = this._status.toJson();
    }
    if (this._studentInfo != null) {
      data['studentInfo'] = this._studentInfo.toJson();
    }
    return data;
  }
}

@JsonSerializable()
class Status {
  String _message;
  int _statusCode;

  Status({String message, int statusCode}) {
    this._message = message;
    this._statusCode = statusCode;
  }

  String get message => _message;
  set message(String message) => _message = message;
  int get statusCode => _statusCode;
  set statusCode(int statusCode) => _statusCode = statusCode;

  Status.fromJson(Map<String, dynamic> json) {
    _message = json['message'];
    _statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this._message;
    data['statusCode'] = this._statusCode;
    return data;
  }
}

@JsonSerializable()
class StudentInfo {
  String _address;
  int _contactNumber;
  String _country;
  String _dob;
  String _email;
  String _gender;
  String _name;
  String _profDetails;

  StudentInfo(
      {String address,
      int contactNumber,
      String country,
      String dob,
      String email,
      String gender,
      String name,
      String profDetails}) {
    this._address = address;
    this._contactNumber = contactNumber;
    this._country = country;
    this._dob = dob;
    this._email = email;
    this._gender = gender;
    this._name = name;
    this._profDetails = profDetails;
  }

  String get address => _address;
  set address(String address) => _address = address;
  int get contactNumber => _contactNumber;
  set contactNumber(int contactNumber) => _contactNumber = contactNumber;
  String get country => _country;
  set country(String country) => _country = country;
  String get dob => _dob;
  set dob(String dob) => _dob = dob;
  String get email => _email;
  set email(String email) => _email = email;
  String get gender => _gender;
  set gender(String gender) => _gender = gender;
  String get name => _name;
  set name(String name) => _name = name;
  String get profDetails => _profDetails;
  set profDetails(String profDetails) => _profDetails = profDetails;

  StudentInfo.fromJson(Map<String, dynamic> json) {
    _address = json['address'];
    _contactNumber = json['contactNumber'];
    _country = json['country'];
    _dob = json['dob'];
    _email = json['email'];
    _gender = json['gender'];
    _name = json['name'];
    _profDetails = json['profDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this._address;
    data['contactNumber'] = this._contactNumber;
    data['country'] = this._country;
    data['dob'] = this._dob;
    data['email'] = this._email;
    data['gender'] = this._gender;
    data['name'] = this._name;
    data['profDetails'] = this._profDetails;
    return data;
  }
}
