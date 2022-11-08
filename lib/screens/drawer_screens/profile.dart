import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../auth/firebase_manager.dart';
import '../../dataclass/person.dart';
import '../auth_screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseDatabase database = FirebaseManager.database;

  FirebaseAuth auth = FirebaseManager.auth;

 late Person person;


  @override
  void initState() {
    setPerson();
    super.initState();

  }
  Future<void> setPerson() async {
    final snapshot =
    await database.ref().child('Users/${auth.currentUser!.uid}').get();
    if (snapshot.exists) {
      Map<String, dynamic> map =
      Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);

      person = Person.fromJson(map);
      print(map);
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
          actions: [
          IconButton(
                onPressed: () {
                    FirebaseManager.auth.signOut();
                    Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                icon: const Icon(Icons.logout))
          ],
        ),
      body: Column(
        children: [
            Container(
                child: Text(
                    person.name
                ),
            ),
        ],
      )


    );
  }
}
