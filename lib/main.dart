// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noter/account_creation_page.dart';
import 'package:noter/favourite_note.dart';
import 'package:noter/firebase_options.dart';
import 'package:noter/login_page.dart';
import 'package:noter/note_widget.dart';
import 'package:noter/profile.dart';
import 'package:noter/registration.dart';
import 'package:noter/utils.dart';
import 'package:noter/view_screen.dart';
import 'package:provider/provider.dart';
import 'package:noter/note_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ChangeNotifierProvider(
      create: (context) => UserNotifier(),
      builder: (context, child) => const MyApp()));
}

final navigatorkey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorkey,
      debugShowCheckedModeBanner: false,
      title: 'Noter',
      routes: {
        '/home': (BuildContext context) => const Home(),
        '/viewscreen': (BuildContext context) => const ViewScreen(),
        '/myhomepage': (BuildContext context) => const MyHomePage(),
        '/logInPage': (BuildContext context) => const LogInPage(),
        '/favorite': (BuildContext context) => const Favourites(),
        '/register': (BuildContext context) => const Registration(),
        // '/Profile': (BuildContext context) => const Profile(),
        '/profile': (BuildContext context) => const Home1(),
      },
      theme: ThemeData(
        primarySwatch: Colors.pink,
        brightness: Brightness.light,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                  "Something went wrong, check your connection and try again"),
            );
          } else if (snapshot.hasData) {
            return const Home();
          } else {
            return const FirstPage();
          }
        },
      ),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
//   void _showdatepicker() {
//     showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2000),
//         lastDate: DateTime(2022));
//   }

//   void _showtimepicker() {
//     showTimePicker(context: context, initialTime: TimeOfDay.now());
//   }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.grey[200],
        body: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(30),
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.note_alt,
                  size: 200,
                  color: Colors.pink,
                ),
                const SizedBox(height: 30),
                const Text(
                  '''Manage your notes 
              easily''',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Center(
                  child: Text(
                    '''
    Create free notes for later use and 
            easy access.A complete 
                easy way to manage 
           and customize your notes
              organize your thoughts 
                         application.
        ''',
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 17,
                      // fontWeight:
                      // FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: const ButtonStyle(),
                    onPressed: () {
                      Navigator.pushNamed(context, '/logInPage');
                    },
                    child: const Text(
                      'Proceed to login page',
                      style: TextStyle(
                          // color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
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
