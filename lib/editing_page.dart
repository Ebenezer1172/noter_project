import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noter/note_model.dart';
import 'package:noter/utils.dart';

class EditingPage extends StatefulWidget {
  final Map note;
  const EditingPage({Key? key, required this.note}) : super(key: key);

  @override
  State<EditingPage> createState() => _EditingPageState();
}

class _EditingPageState extends State<EditingPage> {
  String title = '';
  String description = '';
  bool isFavourite = false;
  bool isDone = false;
  String email = '';
  DateTime createdTime = DateTime.now();
  final String id = FirebaseFirestore.instance
      .collection('notter')
      .doc() //update
      .id;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    title = widget.note['title'];
    description = widget.note['description'];
    final id = widget.note['id'];
    final email = widget.note['email']; //update
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Your Note'),
          centerTitle: true,
          elevation: 2,
          toolbarHeight: 50,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          actions: [
            IconButton(
                onPressed: () {
                  Utils.showSnackBar('Note Edited');
                  // const snackBar =  SnackBar(content:  Text('Note Edited'),);
                  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    updateUser(
                        update: Note(title, description, id, createdTime,
                            isDone, isFavourite, email));
                    Navigator.pop(context);
                  } else {
                    return;
                  }
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                )),
            const SizedBox(
              width: 21,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  initialValue: title,
                  onChanged: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                  onSaved: (value) {
                    setState(() {
                      title = value!;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "can't be empty";
                    } else {
                      return null;
                    }
                  },
                  style: const TextStyle(
                    fontSize: 27,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Title",
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      fontSize: 27,
                    ),
                  ),
                ),
                TextFormField(
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  maxLines: null,
                  initialValue: description,
                  onChanged: (value) {
                    setState(() {
                      description = value;
                    });
                  },
                  onSaved: (value) {
                    setState(() {
                      description = value!;
                    });
                  },
                  expands: false,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(
                      fontSize: 20,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future updateUser({
    required Note update,
  }) async {
    final docUser =
        FirebaseFirestore.instance.collection('notter').doc(widget.note['id']);
    await docUser.update(update.toJson());
  }
}
