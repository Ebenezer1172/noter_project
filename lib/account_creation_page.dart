// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noter/main.dart';
import 'package:noter/utils.dart'; 

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // ignore: unused_field
  late bool _success;
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();
  bool isCheck=true;
  bool isEmpty = true;
   
 
  clear() {
    _emailController.clear();
    _passwordController.clear();
  } 
  //void
  Future 
  _register() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    } 
     navigatorkey.currentState!.popUntil((route) => route.isFirst);
  }
 
   @override
    void dispose(){
        _passwordController.dispose();
        _emailController.dispose();
        super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 32, bottom: 24, left: 0),
                  child: Text('Create your account',
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),),
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 0, top: 19),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
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
                        const Text("E-mail address"),

                        const SizedBox(
                          height: 5,
                        ),

                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: ('E-mail address'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7)),
                            contentPadding:
                                const EdgeInsets.only(left: 8, right: 0),
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty
                                // .toString().isEmpty
                                ) {
                              return 'email cannot be empty' ;
                            }
                            return  null ;
                          },
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text('Password'),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: ('Password'),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              contentPadding:
                                  const EdgeInsets.only(left: 8, right: 0),
                            ),
                            
                            ),
                        const SizedBox(
                          height: 50,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                     
                        Center(
                          child: SizedBox(
                            width: 1000,
                            height: 56,
                            child: 
                            ElevatedButton(
                                child: const Text(
                                  'Create your account',
                                  style: TextStyle(fontSize: 16),
                                ),
                                onPressed: ()
                                      // async
                                     {
                                if (_formKey.currentState!.validate()) {
                              _register();  } 
                                  { 
                               }}
                                ),
                          ),
                        ),
                        const SizedBox(
                          height: 38,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an Account?'),
                            TextButton(
                                onPressed: () {
                                  // Navigator.of(context).pushReplacement(
                                  //   MaterialPageRoute(
                                  //     builder: (context) => const LogInPage(),
                                  //   ),
                                  // );
                                   Navigator.pushNamed(context, '/logInPage');
                                },
                                child: const Text('SignIn')),
                                const SizedBox(height:10),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}  