import 'package:agent_league/route_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../theme/colors.dart';

class People extends StatefulWidget {
  const People({Key? key}) : super(key: key);

  @override
  State<People> createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: CustomColors.dark,
          elevation: 0,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                unselectedLabelColor: HexColor("#b48484"),
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: const TextStyle(fontSize: 27),
                indicator: MaterialIndicator(
                  height: 4,
                  bottomLeftRadius: 5,
                  bottomRightRadius: 5,
                  horizontalPadding: 5,
                  color: HexColor('FE7F0E'),
                ),
                tabs: const [
                  Tab(
                    child: Text(
                      "Customers",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "AgentFly",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Customers(),
            Container(),
          ],
        ),
      ),
    );
  }
}

class Customers extends StatefulWidget {
  const Customers({Key? key}) : super(key: key);

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  void callChatScreen(BuildContext context, String name, String uid) {
    Navigator.pushNamed(context, RouteName.chatDetail, arguments: [name, uid]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('uid', isNotEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, index) {
                final currentItem = snapshot.data?.docs[index].data();
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white.withOpacity(0.7)),
                  child: ListTile(
                    onTap: () => callChatScreen(
                        context, currentItem?['name'], currentItem?['uid']),
                    leading:
                        CircleAvatar(child: Image.asset("assets/profile.png")),
                    title: Text(
                        "${currentItem?['name']} (${currentItem?['phone']})"),
                  ),
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text('Something Went Wrong'));
          }
        });
  }
}
