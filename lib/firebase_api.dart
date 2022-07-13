import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noter/note_model.dart';

String id = '';
DateTime createdTime = DateTime.now();

class FirebaseApi {
  static Future<String> createUser(Note user) async {
    final docUser = FirebaseFirestore.instance.collection('notter').doc();
    user.id = docUser.id;
    await docUser.set(user.toJson());

    return docUser.id;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> readUsers() =>
      FirebaseFirestore.instance.collection('notter').snapshots();

      static Future updateUser(Note user) async {
        final docUser = FirebaseFirestore.instance.collection('notter').doc(user.id);

        await docUser.update(user.toJson());
      }

      static Future deleteUser(Note user) async {
        final docUser = FirebaseFirestore.instance.collection('notter').doc(user.id);
        // FirebaseFirestore.instance
        //                             .collection('notes')
        //                             .doc(note['id'])
        //                              .delete();

        await docUser.delete();
      }
} 