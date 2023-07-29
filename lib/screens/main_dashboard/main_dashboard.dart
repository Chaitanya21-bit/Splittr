import 'package:flutter/material.dart';
import 'package:splitter/colors.dart';
import 'package:splitter/providers/providers.dart';
import 'package:splitter/screens/main_dashboard/components/buttons/add_transaction_button.dart';
import 'package:splitter/screens/main_dashboard/components/buttons/create_group_button.dart';
import 'package:splitter/screens/main_dashboard/components/buttons/join_group_button.dart';
import 'package:splitter/screens/main_dashboard/components/widgets/groups_widget.dart';
import 'package:splitter/screens/main_dashboard/components/widgets/personal_transactions_widget.dart';

import '../../components/background.dart';
import '../../components/navigation_drawer.dart';
import '../../size_config.dart';
import '../../utils/get_provider.dart';
import '../drawer_screens/profile.dart';

class MainDashboard extends StatelessWidget {
  const MainDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = getProvider<UserProvider>(context).user;
    final authProvider = getProvider<FirebaseAuthProvider>(context);
    SizeConfig().init(context);
    final dynamic appBar = AppBar(
      backgroundColor: AppColors().creamBG,
      foregroundColor: Colors.black,
      title: Align(
        alignment: Alignment.center,
        child: Text('Dashboard',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300
          ),),
      ),
      actions: [
        // IconButton(
        //   onPressed: () => {authProvider.signOut()},
        //   icon: const Icon(Icons.logout),
        // ),
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
            icon: const Icon(Icons.account_circle_sharp)),
      ],
      elevation: 0,
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: AppColors().creamBG,
      resizeToAvoidBottomInset: false,
      floatingActionButton: const AddPersonalTransactionButton(),
      drawer: const NavigationDrawerWidget(),
      body: BackgroundStack(
        builder: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.only(
            //         top: SizeConfig.screenHeight * 0.0,
            //         // bottom: SizeConfig.screenHeight * 0.05,
            //       ),
            //       child: Image.asset(
            //         "assets/SplittrLogo.png",
            //         width: SizeConfig.screenHeight * 0.2,
            //       ),
            //     ),
            //     // ElevatedButton(onPressed: () {ProfileScreen();}, child: Text("P"))
            //   ],
            // ),
            //Name
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    top: SizeConfig.screenHeight * 0.015,
                    left: SizeConfig.screenWidth * 0.06,
                ),
                child: Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),

            buildGroupButtons(),
            buildGroups(),
            buildTransactions(),
          ],
        ),
      ),
    );
  }

  Widget buildGroupButtons() {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.screenHeight * 0.01,
        bottom: SizeConfig.screenHeight * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CreateGroupButton(),
          JoinGroupButton(),
        ],
      ),
    );
  }

  Widget buildGroups() {
    return const Expanded(
      flex: 2,
      child: GroupsWidget(),
    );
    // return GroupsWidget();
  }

  Widget buildTransactions() {
    return const Expanded(
      flex: 4,
      child: PersonalTransactionsWidget(),
    );
  }
}
