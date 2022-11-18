// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'package:flutter/material.dart';

// class Profile extends StatefulWidget {
//   const Profile({Key? key}) : super(key: key);

//   @override
//   State<Profile> createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:AppBar(
//         title:Text('Profile'),
//       ),
//       body:Container(
//         decoration: BoxDecoration(
//           color: Colors.black12,
//         ),
//         height: 50,
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:noter/utils.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noter/editing_page.dart';
// import 'package:note_project/favourite_note.dart';
// import 'package:note_project/favourite_note.dart';
import 'package:noter/view_screen.dart';

class Home1 extends StatefulWidget {
  const Home1({Key? key}) : super(key: key);

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  int selectedindex = 0;
  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('notter')
              .where('email',
                  isEqualTo: FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (
            context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            // final note = snapshot.data!.docs[].data();
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isNotEmpty) {
                var index = 12;
                final note = snapshot.data!.docs[index].data();
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    note['title'] ??= '',
                                    softWrap: true,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // Text(
                                  //   'Hi EBENEZER!',
                                  //   style: TextStyle(
                                  //     color: Colors.white,
                                  //     fontSize: 24,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '23 Jan 2022',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: Center(
                                    child: IconButton(
                                      icon: Icon(Icons.notifications,
                                          // size: 30,
                                          color: Colors.blue),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/Registration');
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // Container(
                          //   padding: EdgeInsets.all(2),
                          //   decoration: BoxDecoration(
                          //     color: Colors.blue[600],
                          //     borderRadius: BorderRadius.circular(12),
                          //   ),
                          // child:
                          Padding(
                            padding: const EdgeInsets.only(left: 1.0),
                            child: TextFormField(
                              controller: search,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 100,
                                ),
                                prefixIconColor: Colors.white,
                                fillColor: Colors.white,
                                hoverColor: Colors.white,
                                focusColor: Colors.white,
                                isCollapsed: false,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                iconColor: Colors.white,
                                hintText: ('Search'),
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                prefixIcon: Icon(
                                  Icons.search_sharp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          // Row(
                          //   children: [
                          //     IconButton(
                          //       icon: Icon(
                          //         Icons.search),
                          //       onPressed: (){},
                          //     ),
                          //     SizedBox(
                          //       width: 5,
                          //     ),
                          //     Text(
                          //       'HOW DO YOU FEEL',
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'How do you feel?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.more_horiz,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Emoji(
                                    emoji: '😃',
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Good',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Emoji(
                                    emoji: '😞',
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Bad',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Emoji(
                                    emoji: '👿',
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Devilish',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Emoji(
                                    emoji: '😠',
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Angry',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Exercises',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.more_horiz_outlined,
                                  ),
                                ),
                                //      Container(
                                //  color: Colors.blue,
                                //  child:
                                //   ListView(
                                //    children: [
                                //     Icon(Icons.add),
                                //     Icon(Icons.password),
                                //     Text('qwerty'),
                                //    ],
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            }
            return const Center(
              child: Text(
                'No New Notes',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.green),
              ),
            );
          }),
    );
  }
}
