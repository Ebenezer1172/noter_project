// // ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:noter/login_page.dart';
// import 'package:noter/utils.dart';

// class Registration extends StatefulWidget {
//   const Registration({Key? key}) : super(key: key);

//   @override
//   State<Registration> createState() => _RegistrationState();
// }

// class _RegistrationState extends State<Registration> {
//   final TextEditingController _email = TextEditingController();
//   final TextEditingController _password = TextEditingController();
//   final TextEditingController _phoneNumber = TextEditingController();
//   final TextEditingController _firstname = TextEditingController();
//   // final TextEditingController  _age = TextEditingController();
//   final TextEditingController _lastname = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(
//         key: _formKey,
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.green,
//           ),
//           child: Center(
//             child: Column(
//               children: [
//                 Padding(padding: EdgeInsets.all(16)),
//                 TextFormField(
//                   controller: _firstname,
//                   decoration: InputDecoration(
//                       contentPadding: EdgeInsets.all(10),
//                       hintText: 'First Name',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       )),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),

//                 TextFormField(
//                   controller: _lastname,
//                   decoration: InputDecoration(
//                       contentPadding: EdgeInsets.all(10),
//                       hintText: 'Last Name',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       )),
//                 ),

//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: _email,
//                   decoration: InputDecoration(
//                       contentPadding: EdgeInsets.all(10),
//                       hintText: 'Email-address',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       )),
//                 ),

//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: _phoneNumber,
//                   decoration: InputDecoration(
//                       contentPadding: EdgeInsets.all(10),
//                       hintText: 'Password',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       )),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),

//                 TextFormField(
//                   controller: _password,
//                   decoration: InputDecoration(
//                       contentPadding: EdgeInsets.all(10),
//                       hintText: 'Password',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       )),
//                 ),

//                 // TextFormField(
//                 //   controller: _age,
//                 //   decoration:InputDecoration(
//                 //     contentPadding:EdgeInsets.all(10),
//                 //     hintText: 'Age',
//                 //      border: OutlineInputBorder(
//                 //       borderRadius: BorderRadius.circular(30),
//                 //      )
//                 //   ),
//                 // ),
//                 // SizedBox(height: 10,),
//                 ElevatedButton(
//                   onPressed: () {
//                     _register();
//                     dispose();
//                   },
//                   child: Text('Create your Account'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _password.dispose();
//     _email.dispose();
//     super.dispose();
//   }

//   Future _register() async {
//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (context) => const Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//     try {
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: _email.text.trim(),
//         password: _password.text.trim(),
//       );
//       addUser(
//         _firstname.text.trim(),
//         _lastname.text.trim(),
//         _email.text.trim(),
//         int.parse(
//           _phoneNumber.text.trim(),
//         ),
//       );
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => const LogInPage(),
//         ),
//       );
//     } on FirebaseAuthException catch (e) {
//       print(e);
//       Utils.showSnackBar(e.message);
//     }
//     //  navigatorkey.currentState!.popUntil((route) => route.isFirst);
//   }

//   Future addUser(
//       String firstname, String lastname, String email, int phonenumber) async {
//     await FirebaseFirestore.instance.collection('users').add({
//       'firstname': firstname,
//       'lastname': lastname,
//       'email': email,
//       'phonenumber': phonenumber,
//     });
//   }
// }

// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noter/login_page.dart';
import 'package:noter/utils.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _firstname = TextEditingController();
  // final TextEditingController  _age = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String firstname = '';
    String lastname = '';
    String email = '';
    int phonenumber = 07067150788;
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Create an account',
                          style: TextStyle(
                            color: Colors.pink,
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          onChanged: (val) {
                            firstname = val;
                            setState(() {
                              firstname = val;
                            });
                          },
                          controller: _firstname,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Enter your First Name here',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty
                                // .toString().isEmpty
                                ) {
                              return 'Field cannot be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          onChanged: (val) {
                            lastname = val;
                            setState(() {
                              lastname = val;
                            });
                          },
                          controller: _lastname,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Enter your Last Name here',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty
                                // .toString().isEmpty
                                ) {
                              return 'Field cannot be empty';
                            }
                            return null;
                          },
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onChanged: (val) {
                            email = val;
                            setState(() {
                              email = val;
                            });
                          },
                          controller: _email,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Email-address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty
                                // .toString().isEmpty
                                ) {
                              return 'Field cannot be empty';
                            }
                            return null;
                          },
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onChanged: (val) {
                            phonenumber = val as int;
                            setState(() {
                              phonenumber = val as int;
                            });
                          },
                          controller: _phoneNumber,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Enter your Phone Number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty
                                // .toString().isEmpty
                                ) {
                              return 'Field cannot be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _password,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty
                                // .toString().isEmpty
                                ) {
                              return 'Field cannot be empty';
                            }
                            return null;
                          },
                        ),

                        // TextFormField(
                        //   controller: _age,
                        //   decoration:InputDecoration(
                        //     contentPadding:EdgeInsets.all(10),
                        //     hintText: 'Age',
                        //      border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(30),
                        //      )
                        //   ),
                        // ),
                        SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                addUser(
                                    firstname, lastname, email, phonenumber);
                                _register();
                              } else {
                                return error();
                              }
                            },
                            child: Text(
                              'Create your Account',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account?'),
                            TextButton(
                              onPressed: () {},
                              child: Text('Log In'),
                            ),
                          ],
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

  @override
  void dispose() {
    _password.dispose();
    _email.dispose();
    super.dispose();
  }

  Future addUser(
      String firstname, String lastname, String email, int phonenumber) async {
    await FirebaseFirestore.instance.collection('users').add({
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phonenumber': phonenumber,
    });
  }

  Future _register() async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );
      addUser(
        _firstname.text.trim(),
        _lastname.text.trim(),
        _email.text.trim(),
        int.parse(
          _phoneNumber.text.trim(),
        ),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LogInPage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    //  navigatorkey.currentState!.popUntil((route) => route.isFirst);
  }

  void error() {
    Utils.showSnackBar('Error try again later');
  }
}
