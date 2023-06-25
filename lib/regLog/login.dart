// // import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:todo/dash.dart';
// import 'package:todo/pocketbase.dart';
// // import 'package:todo/regLog/provider.dart';
// import 'package:pocketbase/pocketbase.dart';
// // import 'provid
// // ';
// import 'package:provider/provider.dart';
// import 'package:todo/shaqale.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final pb = PocketBase('http://10.0.2.2:8090');
// // final pb = PocketBase('http://127.0.0.1:8090');
//   final formkey = GlobalKey<FormState>();
//   // pbase pb = pbase();

//   bool isSponsers = true;
//   bool isUni = true;

//   var username;
//   var pass;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Form(
//             key: formkey,
//             child: Container(
//               padding: EdgeInsets.only(
//                 top: 80,
//                 left: 27,
//                 right: 27,
//               ),
//               child: ListView(
//                 children: [
//                   SizedBox(
//                     height: 60,
//                   ),
//                   Text(
//                     "Login",
//                     style: TextStyle(
//                       fontSize: 20,
//                     ),
//                     // style: KFontStyle.copyWith(fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 30),
//                   Visibility(
//                     visible: isSponsers,
//                     child: Container(
//                       child: TextFormField(
//                         onChanged: (value) {
//                           username = value!;
//                         },
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide(
//                                   color: Colors.transparent, width: 0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                                 borderSide: BorderSide(
//                                     color: Colors.transparent, width: 0)),
//                             contentPadding: EdgeInsets.symmetric(
//                                 vertical: 20, horizontal: 25),
//                             filled: true,
//                             fillColor: Color(0xffEBEBEB),
//                             hintText: 'Enter username',
//                             hintStyle: TextStyle(
//                                 fontSize: 17, fontWeight: FontWeight.w600)),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Container(
//                     child: TextFormField(
//                       onChanged: (value) {
//                         pass = value!;
//                       },
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide:
//                                 BorderSide(color: Colors.transparent, width: 0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide(
//                                   color: Colors.transparent, width: 0)),
//                           contentPadding: EdgeInsets.symmetric(
//                               vertical: 20, horizontal: 25),
//                           filled: true,
//                           fillColor: Color(0xffEBEBEB),
//                           // fillColor: Color(0xffD9D9D9),
//                           hintText: isSponsers
//                               ? 'Enter Password'
//                               : 'Fadlan Gali Telephone',
//                           hintStyle: TextStyle(
//                               // color: Color(0xff3F3C3C),
//                               fontSize: 17,
//                               fontWeight: FontWeight.w600)),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Container(
//                     child: SizedBox(
//                       width: double.infinity,
//                       height: 60,
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xff1D1CE5),
//                             shape: RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.circular(30), // <-- Radius
//                             ),
//                           ),
//                           onPressed: () async {
//                             final login1 = await pb
//                                 .collection('users')
//                                 .authWithPassword(username, pass);
//                             // print(pb.authStore.isValid);
//                             if (pb.authStore.isValid) {
//                               // loggedIn = true;
//                               final record =
//                                   await pb.collection('users').getList();
//                               // print(record.);
//                               for (var i in record.items) {
//                                 var email1 = i.getStringValue('email');
//                                 var is_admin = i.getBoolValue('isAdmin');
//                                 if (is_admin == true) {
//                                   if (username == email1) {
//                                     Navigator.push(context, MaterialPageRoute(
//                                       builder: (context) {
//                                         return dash(CurrentUserID: i.id);
//                                       },
//                                     ));
//                                     // print(i.id);
//                                     // currentLogedID = i.id;
//                                   }
//                                 } else {
//                                   if (username == email1) {
//                                     Navigator.push(context, MaterialPageRoute(
//                                       builder: (context) {
//                                         return shaqale(CurrentUserID: i.id);
//                                       },
//                                     ));
//                                     // print(i.id);
//                                     // currentLogedID = i.id;
//                                   }
//                                 }
//                               }
//                             }

//                             // Login();
//                             // final authData = await pb.login(username, pass);

//                             // final loggedIn = pb.loggedIn;
//                             // if (loggedIn) {
//                             //   //  var geti= _p.collection('users').getList();
//                             //   //  var email=geti.

//                             //   // value.currentUserId=
//                             //   // Navigator.pushNamed(context, )
//                             //   Navigator.push(context, MaterialPageRoute(
//                             //     builder: (context) {
//                             //       return dash();
//                             //     },
//                             //   ));
//                             // } else {
//                             //   print('user is no valid');
//                             // }
//                             // fi(pb.loggedIn) {
//                             //   // print('successes');
//                             // }
//                             // final auth = await pb.login(username, pass);
//                             // });

//                             // auth;
//                             // print('This is the useLogged in $auth');
//                           },
//                           child: Text(
//                             'Login',
//                             style: TextStyle(fontSize: 23, letterSpacing: 2),
//                           )),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Center(
//                     child: Container(
//                       // padding: EdgeInsets.only(bottom: 100),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Account Ma Lihi? ",
//                             style: TextStyle(
//                               fontSize: 17,
//                               color: Color(0xff757171),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.pushNamed(context, '/');
//                             },
//                             child: Text(
//                               "Register Now",
//                               style: TextStyle(
//                                 fontSize: 17,
//                                 color: Color(0xff1D1CE5),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             )),
//       ),
//     );
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:todo/dash.dart';
import 'package:todo/pocketbase.dart';
import 'package:todo/shaqale.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final pb = PocketBase('http://10.0.2.2:8090');
  pbase pb1 = pbase();
  final formkey = GlobalKey<FormState>();

  bool isSponsers = true;
  bool isUni = true;
  // Initial Selected Value
  String dropdownvalue = 'Fadlan Dooro Type';

  var username;
  var pass;

  // List of items in our dropdown menu
  var items = [
    'Fadlan Dooro Type',
    'user',
    'Admin',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
            key: formkey,
            child: Container(
              padding: EdgeInsets.only(
                top: 80,
                left: 27,
                right: 27,
              ),
              child: ListView(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    // style: KFontStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  Container(
                    child: TextFormField(
                      onChanged: (value) {
                        username = value!;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Colors.transparent, width: 0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 0)),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 25),
                          filled: true,
                          fillColor: Color(0xffEBEBEB),
                          hintText: 'Enter E-mail',
                          hintStyle: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: TextFormField(
                      onChanged: (value) {
                        pass = value!;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Colors.transparent, width: 0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 0)),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 25),
                          filled: true,
                          fillColor: Color(0xffEBEBEB),
                          // fillColor: Color(0xffD9D9D9),
                          hintText: 'Enter Password',
                          hintStyle: TextStyle(
                              // color: Color(0xff3F3C3C),
                              fontSize: 17,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.only(left: 120),
                      child: DropdownButton(
                        value: dropdownvalue,
                        underline: Container(
                          height: 2,
                          color: Color(0xff1D1CE5),
                        ),
                        icon: const Icon(Icons.arrow_downward),
                        items: items.map((String items) {
                          // Color:color
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                            if (dropdownvalue == 'Sponser') {
                              isSponsers = false;
                            } else {
                              isSponsers = true;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff1D1CE5),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(30), // <-- Radius
                            ),
                          ),
                          onPressed: () async {
                            if (dropdownvalue == 'Admin') {
                              final login1 = await pb
                                  .collection('users')
                                  .authWithPassword(username, pass);
                              // print(pb.authStore.isValid);
                              if (pb.authStore.isValid) {
                                // loggedIn = true;
                                final record =
                                    await pb.collection('users').getList();
                                // print(record.);
                                for (var i in record.items) {
                                  var email1 = i.getStringValue('email');
                                  var is_admin = i.getBoolValue('isAdmin');
                                  if (is_admin == true) {
                                    if (username == email1) {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return dash(CurrentUserID: i.id);
                                        },
                                      ));
                                      // print(i.id);
                                      // currentLogedID = i.id;
                                    }
                                  }
                                }
                              }
                            } else if (dropdownvalue == 'user') {
                              final login1 = await pb
                                  .collection('sub_user')
                                  .authWithPassword(username, pass);
                              // print(pb.authStore.isValid);
                              if (pb.authStore.isValid) {
                                // loggedIn = true;
                                final record =
                                    await pb.collection('sub_user').getList();
                                // print(record.);
                                for (var i in record.items) {
                                  var email1 = i.getStringValue('email');
                                  // var is_Locked = i.getBoolValue('locked');

                                  if (username == email1) {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return shaqale(CurrentUserID: i.id);
                                      },
                                    ));
                                    // print(i.id);
                                    // currentLogedID = i.id;
                                  }
                                }
                              }
                            }
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 23, letterSpacing: 2),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      // padding: EdgeInsets.only(bottom: 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Account Ma Lihi? ",
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xff757171),
                            ),
                            // style: GoogleFonts.inconsolata(
                            //   textStyle: KFontStyle.copyWith(
                            //       fontSize: 17,
                            //       color: Color(0xff757171),
                            //       fontWeight: FontWeight.w900),
                            // ),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/');
                              },
                              child: Text(
                                "Register Now",
                                style: TextStyle(
                                    fontSize: 17, color: Color(0xff1D1CE5)),

                                //   style: KFontStyle.copyWith(
                                //       fontSize: 17,
                                //       color: Color(0xff1D1CE5),
                                //       fontWeight: FontWeight.w900),
                                // ),
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
