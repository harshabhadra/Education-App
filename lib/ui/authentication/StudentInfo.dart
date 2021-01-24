import 'package:education_app/Network/studentinfo.dart';
import 'package:education_app/ui/home/HomeScreen.dart';
import 'package:education_app/ui/welcome/welcomepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:education_app/Bloc/bloc_provider.dart';
import 'package:education_app/Bloc/student_info_bloc.dart';
import 'package:education_app/Model/LoginResponse.dart';
import 'package:education_app/Model/student_info_response.dart';
import 'package:education_app/ui/components/rounded_button.dart';
import 'package:education_app/ui/components/rounded_input_field.dart';
import 'package:education_app/ui/components/text_field_container.dart';
import 'package:education_app/utils/constants.dart';

String name;
String contactNumber;
String gender;
String address;
String country;
String dob;
String email;

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

class StudentInfoUi extends StatefulWidget {
  final String email, password;
  const StudentInfoUi({Key key, @required this.email, @required this.password})
      : super(key: key);

  @override
  _StudentInfoState createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfoUi> {
  //Initializing mask for Dob
  var dobFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
  );

  //Initializing mask for mobile number
  var numberFormatter = MaskTextInputFormatter(mask: '##########');
  bool showLoading;

  GlobalKey<FormState> _key = GlobalKey();
  List<ListItem> _dropdownItems = [
    ListItem(1, "Male"),
    ListItem(3, "Female"),
    //ListItem(4, "Fourth Item")
  ];

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

  void initState() {
    super.initState();
    showLoading = false;
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
    gender = _selectedItem.name;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = StudentInfoBloc();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Students Details',
          textScaleFactor: 1.6,
          textAlign: TextAlign.start,
          style: TextStyle(
              fontFamily: "Varela_Round",
              letterSpacing: 1.6,
              fontWeight: FontWeight.w600,
              fontSize: 17,
              color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: BlocProvider(
          bloc: bloc,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(60))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: RoundedInputField(
                            hintText: "Full Name",
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                name = value;
                              }
                            },
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextFieldContainer(
                              child: TextFormField(
                                inputFormatters: [numberFormatter],
                                keyboardType: TextInputType.datetime,
                                cursorColor: kPrimaryColor,
                                style: TextStyle(fontSize: 18.0),
                                decoration: InputDecoration(
                                    icon: Icon(Icons.calendar_today_outlined,
                                        color: kPrimaryColor),
                                    hintText: 'Mobile Number',
                                    helperText: 'Eg: 999-999-9999',
                                    border: InputBorder.none),
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    contactNumber = value;
                                  }
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'This Field Cannot be Empty';
                                  }
                                  return null;
                                },
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Container(
                            width: 320,
                            height: 60,
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 20.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                border: Border.all()),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  value: _selectedItem,
                                  items: _dropdownMenuItems,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedItem = value;
                                      gender = _selectedItem.name;
                                    });
                                  }),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 10),
                          child: RoundedInputField(
                            icon: Icons.location_city_outlined,
                            hintText: "Address",
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                address = value;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 10),
                          child: RoundedInputField(
                            icon: Icons.location_on_outlined,
                            hintText: "Country",
                            onChanged: (value) {
                              // _email = value;
                              if (value.isNotEmpty) {
                                country = value;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFieldContainer(
                            child: TextFormField(
                              inputFormatters: [dobFormatter],
                              keyboardType: TextInputType.datetime,
                              cursorColor: kPrimaryColor,
                              style: TextStyle(fontSize: 18.0),
                              decoration: InputDecoration(
                                  icon: Icon(Icons.calendar_today_outlined,
                                      color: kPrimaryColor),
                                  hintText: 'Date of Birth',
                                  border: InputBorder.none),
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  dob = value;
                                }
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'This Field Cannot be Empty';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(bottom: 10),
                        //   child: Container(
                        //     width: 320,
                        //     height: 60,
                        //     padding:
                        //         const EdgeInsets.only(left: 30.0, right: 20.0),
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(25.0),
                        //         border: Border.all()),
                        //     child: DropdownButtonHideUnderline(
                        //       child: DropdownButton(
                        //           hint: Text('Exam Type'),
                        //           value: _selectedItem1,
                        //           items: _dropdownMenuItems1,
                        //           onChanged: (value) {
                        //             setState(() {
                        //               _selectedItem1 = value;
                        //               profDetals = _selectedItem1.name;
                        //             });
                        //           }),
                        //     ),
                        //   ),
                        // ),
                        showLoading
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : RoundedButton(
                                text: 'Submit',
                                press: () {
                                  if (_key.currentState.validate()) {
                                    _key.currentState.save();
                                    StudentInfo studentInfo = StudentInfo(
                                      email: widget.email,
                                      name: name,
                                      contactNumber: int.parse(contactNumber),
                                      address: address,
                                      country: country,
                                      gender: gender,
                                      dob: dob,
                                    );

                                    bloc.setStudentInfo(studentInfo);
                                    submitStudentInfo(bloc);
                                    print("Gender : " + gender);
                                  }
                                },
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future submitStudentInfo(StudentInfoBloc bloc) async {
    setState(() {
      showLoading = true;
      bloc.studentInfoStream.listen((event) {
        StudentInfoResponse response = event;
        setState(() {
          showLoading = false;
          if (response.statusCode == 100) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return WelcomePage(email: widget.email, password: widget.password);
              }), (route) => false);
            });
          } else {
            print(response.message);
          }
        });
      });
    });
  }
}
