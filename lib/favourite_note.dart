import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:note_project/firebase_api.dart';
// import 'package:note_project/note_model.dart';
import 'package:noter/utils.dart';
// import 'package:provider/provider.dart';
// import 'package:note_project/note_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'package:noter/note_model.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
   // ignore: unused_local_variable
   bool isFavourite=true;
//  bool  isDone=false;
//  String email='';
//      final provider = Provider.of<UserNotifier>(context);
//    // noteList is the list of notes
//     final noteList = provider.userListFavourites;
  return Scaffold(
    backgroundColor:(
      Colors.grey[200]),
    appBar: AppBar(
      title: const Text('Favourite Notes'),),
    body: StreamBuilder<QuerySnapshot<Map<String,
    dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('notter')
              .where('email',isEqualTo: FirebaseAuth.instance.currentUser!.email)
              .where('isFavourite',isEqualTo: true)
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
          if(snapshot.hasData){
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.separated(
                  separatorBuilder: ((context, index) => Container(
                        color: Colors.green,
                        height: 1,
                      )),
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
                                 onTap: (){ 
                                 },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),color: Colors
                              .primaries[Random().nextInt(Colors.primaries.length)],
                            ),
                          child: 
                          // Expanded(
                          //   child: 
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(color: Colors.red,
                                                 onPressed: () { 
                                                  FirebaseFirestore.instance
                                              .collection('notter')
                                              .doc(note['id'])
                                              .update( {'isFavourite':  false,}  ); 
                                              Utils.showSnackBar('Removed from Favourites');
                                               }, 
                                                icon: const Icon(
                                                    Icons.favorite),
                                              ), 
                                              const SizedBox(
                                                width: 1,
                                              ),
                                              // IconButton(
                                              //   onPressed: () {
                                              //     provider.deleteUser(Note('title', 'description', id, createdTime, isDone , isFavourite,email));
                                              //    Utils.showSnackBar('Note Deleted'); 
                                              //   },
                                              //   icon: const Icon(
                                              //       Icons.delete_forever),
                                              // ),
                                            ]),
                                        Text(
                                          note['title'] ??='' ,
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
                                          note['description'] ??=''  ,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          //),
                        ),
                      ),
                    );
                  });
            }
                  //
            }
            return const Center(
              child: Text(
                'No Favorite Notes',
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