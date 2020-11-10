import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_appfoodx/Address.dart';
// import 'package:flutter_appfoodx/Categories.dart';
// import 'package:flutter_appfoodx/screen/Home.dart';
// import 'package:flutter_appfoodx/Login/LoginPage.dart';
// import 'package:flutter_appfoodx/Address_location/note_list.dart';
// import 'package:flutter_appfoodx/Categories.dart';
class ProfilePage extends StatefulWidget {
  @override
  State createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  //String Name1='Pranab Ray';



  Widget buildCustomAppBar() {

    return FittedBox(fit:BoxFit.fitWidth,
      child:Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height*1,
        width: MediaQuery.of(context).size.width*1,

        child: Scaffold(

          body:Container(
            
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                new Column(
                  
                  children: <Widget>[
                    SizedBox(height: 20,),
                    
                    CircleAvatar( maxRadius: 45,
                      child: Icon(Icons.account_circle,size: 90,color: Colors.white,),),
                    SizedBox(height: 20,),
                    Center(child: Text("Name1",style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Varela_Round',
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400
                          
                      ),
                      ),)
                    ,
                    new ListTile(
                      //contentPadding: EdgeInsets.only( top: 260.0,right: 150) ,
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MaterialApp(
                            debugShowCheckedModeBanner: false,
                            //home:NoteList()
                        )
                        )
                        );
                      },

                      leading: Image.asset('assets/images/location.png',colorBlendMode: BlendMode.color,scale: 12),
                      title: Text("Address",style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Varela_Round',
                          fontSize: 17.0,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w600
                      ),
                      ),

                    ),
                    SizedBox(height: 5,),
                    new ListTile(
                      //contentPadding: EdgeInsets.only( top: 260.0,right: 150) ,
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MaterialApp(
                            debugShowCheckedModeBanner: false,
                            //home:Cart()
                        )
                        )
                        );
                      },

                      leading: Image.asset('assets/images/cart.png',colorBlendMode: BlendMode.color,scale: 17),
                      title: Text("Cart",style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Varela_Round',
                          fontSize: 17.0,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w600
                      ),
                      ),

                    ),

                    new ListTile(
                        onTap: (){

                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MaterialApp(
                              debugShowCheckedModeBanner: false,
                              //home:Address()
                          )
                          )
                          );
                        },
                        leading:Icon(Icons.gps_fixed,size: 30,color: Colors.red,),
                        title: Text("GPS Location",style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'Varela_Round',
                            fontSize: 17.0,
                            letterSpacing: 1.0,
                          fontWeight: FontWeight.w600
                        ),
                        )


                    ),

                    new ListTile( 
                        leading:Icon(Icons.phone,size: 30,color: Colors.red,),
                        title: Text("Phone1",style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'Varela_Round',
                            fontSize: 17.0,
                            letterSpacing: 1.0,
                          fontWeight: FontWeight.w600
                        ),
                        )


                    )
                  ],



                ),
              ],
            )
        ),

      ),

    ),
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        
        children: <Widget>[
          buildCustomAppBar(),

        ],
      ),
    );
  }
}