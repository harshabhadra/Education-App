import 'package:json_annotation/json_annotation.dart';
part 'update_profile_request.g.dart';
@JsonSerializable()
class UpdateProfileRequest {
  String _email;
  String _name;
  int _contactNumber;
  String _address;
  String _country;
  String _gender;
  String _dob;
  bool _premiumUser;
  String _subscriptionId;

  UpdateProfileRequest(
      {String email,
      String name,
      int contactNumber,
      String address,
      String country,
      String gender,
      String dob,
      bool premiumUser,
      String subscriptionId}) {
    this._email = email;
    this._name = name;
    this._contactNumber = contactNumber;
    this._address = address;
    this._country = country;
    this._gender = gender;
    this._dob = dob;
    this._premiumUser = premiumUser;
    this._subscriptionId = subscriptionId;
  }

  String get email => _email;
  set email(String email) => _email = email;
  String get name => _name;
  set name(String name) => _name = name;
  int get contactNumber => _contactNumber;
  set contactNumber(int contactNumber) => _contactNumber = contactNumber;
  String get address => _address;
  set address(String address) => _address = address;
  String get country => _country;
  set country(String country) => _country = country;
  String get gender => _gender;
  set gender(String gender) => _gender = gender;
  String get dob => _dob;
  set dob(String dob) => _dob = dob;
  bool get premiumUser => _premiumUser;
  set premiumUser(bool premiumUser) => _premiumUser = premiumUser;
  String get subscriptionId => _subscriptionId;
  set subscriptionId(String subscriptionId) => _subscriptionId = subscriptionId;

  UpdateProfileRequest.fromJson(Map<String, dynamic> json) {
    _email = json['email'];
    _name = json['name'];
    _contactNumber = json['contactNumber'];
    _address = json['address'];
    _country = json['country'];
    _gender = json['gender'];
    _dob = json['dob'];
    _premiumUser = json['”premiumUser”'];
    _subscriptionId = json['subscriptionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this._email;
    data['name'] = this._name;
    data['contactNumber'] = this._contactNumber;
    data['address'] = this._address;
    data['country'] = this._country;
    data['gender'] = this._gender;
    data['dob'] = this._dob;
    data['”premiumUser”'] = this._premiumUser;
    data['subscriptionId'] = this._subscriptionId;
    return data;
  }
}
