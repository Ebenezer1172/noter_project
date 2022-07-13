import 'package:flutter/cupertino.dart';
import 'package:noter/firebase_api.dart';
import 'package:noter/note_model.dart'; 


class UserNotifier extends ChangeNotifier {
  final TextEditingController _note = TextEditingController();
  final TextEditingController _titlee = TextEditingController();
  final TextEditingController _name = TextEditingController();

  DateTime dateTime = DateTime.now();
  DateTime get createdTime => dateTime;
  // static Object createdTime;
  TextEditingController get titlee => _titlee;
  TextEditingController get note => _note;
  TextEditingController get name => _name;
  bool isDone = false;
  List<Note> _userlist = [];
  List<Note> get userList => _userlist;

  List<Note> get users =>
      _userlist.where((userList) => userList.isDone == false).toList();

  List<Note> get userListFavourites =>
      _userlist.where((userList) => userList.isDone == true).toList();
 
  final String _names = '';
  String get names => _names;

  

  bool toggleUserStatus(Note user) {
    user.isFavourite = !user.isFavourite;
 FirebaseApi.updateUser(user);
    //  notifyListeners();

    return user.isFavourite;
  }

  addUser(Note user) => FirebaseApi.createUser(user);
  //  addUser(User user) {
  //   _userlist.add(user);
  //   notifyListeners();
  // }

  clear() {
    _note.clear();
    _titlee.clear();
  }

// addUser(User user)=> FirebaseApi.createNote(user);

// void deleteUser(User user) {
//   _userlist.remove(user);
// }

  deleteUser(index) {
    _userlist.removeWhere((user) => 
        user.title ==
        userList[index].title); 
        // change it from _user.note to _user.title
    // notifyListeners();
    FirebaseApi.deleteUser(index);
  }


  

// deleteUser(User user)  => FirebaseApi.deleteUser(user);


  // deleteUser(index) =>FirebaseApi.deleteUser(index);

  void setNotes(List<Note> user) => _userlist = userList;

  void setNotess(List<Note> userList) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _userlist = userList;
// @override
        notifyListeners();
      });

  favouriteNote(Note user) {
    _userlist.add(user);
    notifyListeners();
  }

  void updateUser(Note user, String title, String description) {
    user.title = title;
    user.description = description;

    FirebaseApi.updateUser(user);
    notifyListeners();
  }
}