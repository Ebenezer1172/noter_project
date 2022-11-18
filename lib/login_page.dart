// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noter/account_creation_page.dart';
import 'package:noter/note_widget.dart';
import 'package:noter/utils.dart'; 


class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
void dispose() {
      _passwordController.dispose();
      _emailController.dispose();
      super.dispose();
    } 
  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 32, bottom: 24, left: 0),
                    child: Text('Sign-in',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink
                        )),
                  ),
                   
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                       const Padding(
                        padding:
                       EdgeInsets.only(left: 0,top: 19), ),
                         const SizedBox(
                          height:8,),
                          Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                          ],
                        ),
                         const SizedBox(
                          height: 0,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const SizedBox(height: 8),
                        const Padding(padding: EdgeInsets.only(right: 0)),
                         const Text('E-mail address'),
                        
                        const SizedBox(
                          height: 5,
                        ),
                        
                        TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: ('E-mail address'),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              contentPadding:
                                  const EdgeInsets.only(left: 8, right: 0),
                            ),
                            onSaved: (value) {},
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "Field cannot be empty";
                              } else {
                                return null;
                              }
                            } 
                            ),
                        const SizedBox(
                          height: 24,
                        ),
                       
                            const Text('Password'),
                         
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: ('Password'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7)),
                            contentPadding:
                                const EdgeInsets.only(left: 8, right: 0),
                          ),
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return "Enter password to create an account";
                            } else if (value.length < 6) {
                              return "Password must be more than 8 characters";
                            } else {
                              return null;
                            }
                          }),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const SizedBox(height: 20,),

                        Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                          width: double.infinity,
                          child: 
                          ElevatedButton(
                            child: const Text('Log in'),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                print("validate");
                                signIn(
                                  //context
                                );
                              }
                              {
                                 
                              }
                               
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height:38),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
const Text('Dont have an Account?'),
                            TextButton(
                              child: const Text('Create an Account '),
                              onPressed: () {
                                 FirebaseAuth.instance.signOut();
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const MyHomePage(),
                                  ),
                                );
                                // Navigator.pushNamed(context, '/myhomepage');
                              },
                            ),
                             const SizedBox(height:10),
                    ]
                  )
                      ],
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

 

  Future signIn(
    //BuildContext context
  ) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const Center(
          child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword( email: _emailController.text.trim(),
          password: _passwordController.text.trim()); 
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
 
  }
}