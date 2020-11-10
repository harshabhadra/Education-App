import 'package:education_app/ui/components/rounded_button.dart';
import 'package:education_app/ui/components/rounded_input_field.dart';
import 'package:education_app/utils/constants.dart';
import 'package:flutter/material.dart';

String name;
String contactNumber;
String gender;
String address;
String country;
String profDetals;
String dob;

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

class StudentInfo extends StatefulWidget {
  StudentInfo({Key key}) : super(key: key);
  @override
  _StudentInfoState createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {
  GlobalKey<FormState> _key = GlobalKey();
  List<ListItem> _dropdownItems = [
    ListItem(1, "GENDER"),
    ListItem(2, "Male"),
    ListItem(3, "Female"),
    //ListItem(4, "Fourth Item")
  ];

  List<ListItem> _dropdownItems1 = [
    ListItem(1, "Professional"),
    ListItem(2, "Medical"),
    ListItem(3, "Medcal student"),
    //ListItem(4, "Fourth Item")
  ];

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems1;
  ListItem _selectedItem1;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;

    _dropdownMenuItems1 = buildDropDownMenuItems(_dropdownItems1);
    _selectedItem1 = _dropdownMenuItems1[0].value;
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
      body: Container(
        width: MediaQuery.of(context).size.width,
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
                          // _email = value;
                          print(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: RoundedInputField(
                        icon: Icons.phone_android_outlined,
                        hintText: "Phone Number",
                        onChanged: (value) {
                          // _email = value;
                          print(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Container(
                        width: 320,
                        height: 60,
                        padding: const EdgeInsets.only(left: 30.0, right: 20.0),
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
                                });
                              }),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 10),
                      child: RoundedInputField(
                        icon: Icons.location_city_outlined,
                        hintText: "City Name",
                        onChanged: (value) {
                          // _email = value;
                          print(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: RoundedInputField(
                        icon: Icons.location_on_outlined,
                        hintText: "Country",
                        onChanged: (value) {
                          // _email = value;
                          print(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Container(
                        width: 320,
                        height: 60,
                        padding: const EdgeInsets.only(left: 30.0, right: 20.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all()),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              value: _selectedItem1,
                              items: _dropdownMenuItems1,
                              onChanged: (value) {
                                setState(() {
                                  _selectedItem1 = value;
                                });
                              }),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 10),
                      child: RoundedInputField(
                        icon: Icons.date_range,
                        hintText: "Date of Birth",
                        onChanged: (value) {
                          // _email = value;
                          print(value);
                        },
                      ),
                    ),
                    RoundedButton(
                      text: 'Submit',
                      press: () {
                        if (_key.currentState.validate()) {
                          _key.currentState.save();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
