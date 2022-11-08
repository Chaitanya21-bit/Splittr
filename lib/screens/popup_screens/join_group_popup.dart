import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../auth/firebase_manager.dart';
import '../../dataclass/group.dart';
import '../../dataclass/person.dart';
import '../group_screens/group_dashboard.dart';


  final FirebaseDatabase database = FirebaseManager.database;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController groupCodeController = TextEditingController();
  final FirebaseDatabase _database = FirebaseDatabase.instance;

List<dynamic> outputGroupsList = [];

 



Future<void> joinGroup(BuildContext context) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Center(
            child: Text('Join Group'),
          ),
          content: Form(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text('Group Name'),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: groupCodeController,
                decoration: const InputDecoration(
                  labelText: 'Add Code',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          )),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => {Navigator.of(context).pop()},
              style: ButtonStyle(
                // backgroundColor: MaterialStateProperty.all<Color>(Color(0xff42a5f5)),
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xff1870B5)),
                overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
              ),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () => joinInGroup(context),
              style: ButtonStyle(
                // backgroundColor: MaterialStateProperty.all<Color>(Color(0xff42a5f5)),
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xff1870B5)),
                overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
              ),
              child: const Text("Join"),
            ),
          ],
        );
      });
}

joinInGroup(BuildContext context) async {
  try {
    NavigatorState state = Navigator.of(context);
    Person P;
    Group G;
    print(_auth.currentUser?.uid);
    print("join group");
    final snapshot_group = await database.ref('Group').get();

    Map<String, dynamic> mapG = Map<String, dynamic>.from(
        snapshot_group.value as Map<dynamic, dynamic>);
    List<dynamic> listG = [];
    listG.clear();
    listG = mapG.values.toList();
    print(listG);
    print(groupCodeController.text);

    for (int i = 0; i < listG.length; i++) {
      if (groupCodeController.text == listG[i]['groupCode']) {
        var groupID = listG[i]['gid'];
        final user_snapshot =
            await database.ref().child('Users/${_auth.currentUser!.uid}').get();
        print(user_snapshot.value);
       
        
        var userID = _auth.currentUser!.uid;
        //Code se Gid nikalna hai
        print(groupCodeController.text);

        //Update Group
        final grpSnapshot =
            await database.ref().child('Group/${groupID}').get();
        print(grpSnapshot.value);
        Map<String, dynamic> maps = Map<String, dynamic>.from(
            grpSnapshot.value as Map<dynamic, dynamic>);
            print("check");
        G = Group.fromJson(maps);
        print(G.members);
        // Update G.members
        G.members.add(userID);
        print(G.members);
        //Push in DB

        




        await database.ref().child('Group/${groupID}').update(G.toJson());
        print("Group Updated");

        //Update User
        
        Map<String, dynamic> map = Map<String, dynamic>.from(
            user_snapshot.value as Map<dynamic, dynamic>);
        P = Person.fromJson(map);
        print(P.userGroups);

        P.userGroups.add(groupID);
        print(P.userGroups);
        //Push in DB
        await database.ref('Users/${_auth.currentUser?.uid}').update(P.toJson());
        print("User Updated");
      }
    }

    state.pushReplacement(
        MaterialPageRoute(builder: (context) => GroupDashboard()));
  } catch (e) {
    print(e);
  }
}
