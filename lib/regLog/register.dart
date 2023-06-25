import 'dart:convert';

import 'package:flutter/material.dart';
import '../pocketbase.dart';

class sRegister extends StatefulWidget {
  const sRegister({super.key});

  @override
  State<sRegister> createState() => _sRegister();
}

class _sRegister extends State<sRegister> {
  final formkey = GlobalKey<FormState>();
  var username;
  var email;
  var pass;
  var cf;

  pbase pb = pbase();

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
                    "Register to use the app ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 30),

                  Container(
                    child: TextFormField(
                      onChanged: (value) {
                        username = value!;
                        // username = value!;
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
                          hintText: 'Enter fullName',
                          hintStyle: TextStyle(
                              // color: Color(0xff3F3C3C),
                              fontSize: 17,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: TextFormField(
                      onChanged: (value) {
                        email = value!;
                        // username = value!;
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
                          hintText: 'Enter Email',
                          hintStyle: TextStyle(
                              // color: Color(0xff3F3C3C),
                              fontSize: 17,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: TextFormField(
                      onChanged: (value) {
                        pass = value!;
                        // pass = value!;
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
                          hintText: 'password',
                          hintStyle: TextStyle(
                              // color: Color(0xff3F3C3C),
                              fontSize: 17,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: TextFormField(
                      onChanged: (value) {
                        cf = value!;
                        // username = value!;
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
                          hintText: 'confirm password',
                          hintStyle: TextStyle(
                              // color: Color(0xff3F3C3C),
                              fontSize: 17,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  Container(
                    // padding: EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: double.infinity,
                      // width: 10,
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
                            if (username.toString().isNotEmpty &&
                                pass.toString().isNotEmpty) {
                              final createuser =
                                  await pb.Register(username, email, pass, cf);
                              createuser;
                             
                              Navigator.pushNamed(context, '/login');
                              
                            }
                            ;
                          },
                          child: Text(
                            'Register',
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
                            "Horay Isku Diwan Galiyay? ",
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xff757171),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 17,
                                color: Color(0xff1D1CE5),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )

                  // Buttons(name: 'name', color: Colors.blue)
                ],
              ),
            )),
      ),
    );
  }
}
