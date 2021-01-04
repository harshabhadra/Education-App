import 'package:education_app/ui/components/rounded_button.dart';
import 'package:education_app/utils/constants.dart';
import 'package:flutter/material.dart';

String name;
String contactNumber;
String gender;
String address;
String country;
String profDetals;
String dob;

class UserDetails extends StatefulWidget {
  //String email;
  UserDetails();
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  // String email;
  // _Users_Details_infoState(this.email);
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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15, left: 20),
              child: Text(
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
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              //color: Colors.white,

              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 65, right: 40, left: 40),
                    child: TextField(
                      onChanged: (val) {
                        name = val;
                      },
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: kPrimaryColor)),

                          //hintText: 'Tell us about yourself',
                          //helperText: 'Keep it short, this is just a demo.',
                          fillColor: kPrimaryLightColor,
                          filled: true,
                          labelText: 'Name',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          prefixText: ' ',
                          suffixStyle: const TextStyle(color: kPrimaryColor)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25, right: 40, left: 40),
                    child: TextField(
                      onChanged: (val) {
                        contactNumber = val;
                      },
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: kPrimaryColor)),
                          fillColor: kPrimaryLightColor,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          labelText: 'Phone Number',
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: kPrimaryColor,
                          ),
                          prefixText: ' ',
                          // suffixText: 'USD',
                          suffixStyle: const TextStyle(color: kPrimaryColor)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25, left: 40, right: 40),
                    child: Container(
                      width: 350,
                      height: 60,
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: kPrimaryLightColor,
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
                    padding: EdgeInsets.only(top: 25, right: 40, left: 40),
                    child: TextField(
                      onChanged: (val) {
                        address = val;
                      },
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide:
                                  new BorderSide(color: Color(0xFFF50057))),
                          fillColor: kPrimaryLightColor,
                          labelText: 'City',
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          prefixText: ' ',
                          suffixStyle: const TextStyle(color: kPrimaryColor)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25, right: 40, left: 40),
                    child: TextField(
                      onChanged: (val) {
                        country = val;
                      },
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide:
                                  new BorderSide(color: Color(0xFFF50057))),
                          fillColor: kPrimaryLightColor,
                          labelText: 'COUNTRY',
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          prefixText: ' ',
                          suffixStyle: const TextStyle(color: kPrimaryColor)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25, left: 40, right: 40),
                    child: Container(
                      width: 350,
                      height: 60,
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: kPrimaryLightColor,
                          border: Border.all()),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            value: _selectedItem1,
                            items: _dropdownMenuItems1,
                            onChanged: (value) {
                              setState(() {
                                _selectedItem1 = value;
                                print(_selectedItem1);
                              });
                            }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25, right: 40, left: 40),
                    child: TextField(
                      onChanged: (val) {
                        dob = val;
                      },
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide:
                                  new BorderSide(color: Color(0xFFF50057))),
                          fillColor: kPrimaryLightColor,
                          labelText: 'Date of Birth',
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          prefixText: ' ',
                          suffixStyle: const TextStyle(color: kPrimaryColor)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 25,
                    ),
                    child: RoundedButton(
                      text: "PROCEED",
                      press: () {},
                    ),
                  )
                ],
              ),

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(55.0),
                  ),
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
