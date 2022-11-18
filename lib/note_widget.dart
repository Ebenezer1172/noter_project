// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noter/editing_page.dart';
// import 'package:note_project/favourite_note.dart';
// import 'package:note_project/favourite_note.dart';
import 'package:noter/utils.dart';
import 'package:noter/view_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Color _iconColor = Colors.white;
  bool edit = false;
  bool isDone = false;
  bool isFavourite = false;
  DateTime createdTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    // var provider = Provider.of<UserNotifier>(context);
    // final noteList = provider.userList;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        hoverElevation: 150,
        elevation: 100,
        foregroundColor: Colors.white,
        backgroundColor: Colors.pink,
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/viewscreen');
          // Navigator.pushNamed(context, '/viewscreen');
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.grey[200],
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        ),
        backgroundColor: Colors.pink,
        child: ListView(
          children: [
            DrawerHeader(
                margin: const EdgeInsets.fromLTRB(5, 5, 0, 10),
                padding: const EdgeInsets.symmetric(vertical: 5),
                duration: const Duration(milliseconds: 250),
                child: ListView(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Center(
                        child: ListTile(
                          title: Center(
                            child: Text(
                              'Signed in as',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          dense: true,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Text(
                          user.email!,
                          style: const TextStyle(fontSize: 20),
                        ),
                        dense: false,
                      )
                    ],
                  ),
                ])),

            ListTile(
              // contentPadding: const EdgeInsets.symmetric(
              //   horizontal: 45),
              leading: const Icon(
                Icons.add,
                size: 40,
              ),

              title: const Text("Create New Note"),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ViewScreen())),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Icon(
                Icons.favorite_outline,
                size: 40,
              ),
              title: const Text("Favorites"),
              onTap: () => Navigator.pushNamed(context, '/favorite'),
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const Favourites())),
            ),
            const SizedBox(
              height: 20,
            ),
            // ListTile(
            //   leading: const Icon(
            //     Icons.settings,
            //     size: 30,
            //   ),
            //   title: MyText(input: "Settings", fontSize: 20),
            //   onTap: () {
            //     Navigator.pushNamed(context, '/Settings');
            //   },
            // ),
            ListTile(
              leading: const Icon(
                Icons.logout_outlined,
                size: 40,
              ),
              title: const Text(
                "Log-out",
              ),
              onTap: () {
                Utils.showSnackBar('Logged out');
                Navigator.pushReplacementNamed(context, '/logInPage');
                //  FirebaseAuth.instance.signOut();
                // Navigator.pop(context);
                // Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Icon(
                Icons.logout_outlined,
                size: 40,
              ),
              title: Text(
                'Profile',
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/profile');
                //  FirebaseAuth.instance.signOut();
                // Navigator.pop(context);
                // Navigator.pushReplacementNamed(context, '/home');
              },
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Registration'),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Profile');
                },
                child: Text('Profile')),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          // IconButton(onPressed: (){}, icon: Icon(Icons.push_pin)),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/favorite');
            },
            icon: const Icon(Icons.favorite_outline),
          ),
        ],
        title: const Text('Notes'),
      ),
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
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isNotEmpty) {
                return ListView.builder(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, index) {
                      final note = snapshot.data!.docs[index].data();

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          splashColor: Colors.green,
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditingPage(
                                        note: note,
                                      ))),
                          child:
                              // ClipRRect(
                              //   borderRadius: BorderRadius.circular(20),
                              //   child:
                              Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.primaries[
                                  Random().nextInt(Colors.primaries.length)],
                            ),
                            child:
                                // Expanded(
                                //     child:
                                Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                // color: _iconColor,
                                                onPressed: () {
                                                  // setState(() {
                                                  //   // _iconColor = Colors.red;
                                                  // });
                                                  // Navigator.pushNamed(context, 'favourite');
                                                  //                 Navigator.of(context).pushReplacement(
                                                  //  MaterialPageRoute(
                                                  //    builder: (context) => const Favourites()));
                                                  FirebaseFirestore.instance
                                                      .collection('notter')
                                                      .doc(note['id'])
                                                      .update({
                                                    'isFavourite': true,
                                                  });
                                                  Utils.showSnackBar(
                                                      'Added to Favourites');
                                                  // const snackBar = SnackBar(
                                                  //   content: Text(
                                                  //       'Added to Favourites'),
                                                  // );
                                                  // ScaffoldMessenger.of(context)
                                                  //     .showSnackBar(snackBar);
                                                },
                                                icon: 
                                                // Badge(badgeContent:Text('7'),
                                                //   child:
                                                   const Icon(
                                                      Icons.favorite_border),
                                                // ),
                                              ),
                                              // Text('note')
                                              // Text(DateTime.parse(["createdTime"].D)),
                                              Text(
                                                DateTime.parse(
                                                        note['createdTime']
                                                            .toDate()
                                                            .toString())
                                                    .toString(),
                                              ),
                                              //  Text('eben'),
                                              const SizedBox(
                                                width: 1,
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              Colors.green,
                                                          title: const Center(
                                                              child: Text(
                                                            'Delete Note',
                                                          ),),
                                                          content: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: const Text(
                                                                    'Cancel'),
                                                              ),
                                                              const SizedBox(
                                                                width: 20,
                                                              ),
                                                              ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'notter')
                                                                        .doc(note[
                                                                            'id'])
                                                                        .delete();
                                                                    Utils.showSnackBar(
                                                                        'Note Deleted');
                                                                  },
                                                                  child: const Text(
                                                                      'Confirm')),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                  // provider.deleteUser(User('title', 'description', 'id', createdTime, isDone, isFavourite));

                                                  //   const snackBar = SnackBar(
                                                  //     content: Text('Note Deleted'),
                                                  //   );
                                                  //   ScaffoldMessenger.of(context)
                                                  //       .showSnackBar(snackBar);
                                                },
                                                icon: const Icon(
                                                    Icons.delete_forever),
                                              ),
                                            ]),
                                        Text(
                                          note['title'] ??= '',
                                          softWrap: true,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          note['description'] ??= '',
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // ),
                          ),
                          //),
                        ),
                      );
                    });
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
