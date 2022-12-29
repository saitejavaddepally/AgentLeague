import 'dart:developer';

import 'package:agent_league/Services/auth_methods.dart';
import 'package:agent_league/Services/local_notification_service.dart';
import 'package:agent_league/helper/shared_preferences.dart';
import 'package:agent_league/ui/Home/home.dart';
import 'package:agent_league/ui/Home/Chat/people.dart';
import 'package:agent_league/ui/Home/project.dart';
import 'package:agent_league/ui/Home/sell_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../provider/firestore_data_provider.dart';

class BottomBar extends StatefulWidget {
  int index;
  BottomBar({Key? key, required this.index}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List screens = <Widget>[
    const Home(),
    const SellScreen(),
    const People(),
    const Project(),
    Container(color: Colors.cyan)
  ];

  @override
  initState() {
    super.initState();

    setupToken();

    //gives u the message on which user taps and it opened the app from terminated state
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      log("get initial message");
      if (message != null) {
        log(message.notification!.body.toString());
        log(message.notification!.title.toString());
      }
    });

    //work when the app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      //await LocalNotificationService.display(message);
    });

    //when the app is in the background but not terminated and user taps on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  }

  Future<void> saveTokenToDatabase(String token) async {
    // Assume user is logged in for this example
    String userId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'tokens': FieldValue.arrayUnion([token]),
    });
  }

  Future<void> setupToken() async {
    // Get the token each time the application loads
    String? token = await FirebaseMessaging.instance.getToken();

    // Save the initial token to the database
    await saveTokenToDatabase(token!);

    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: FutureBuilder<num>(
            future: FirestoreDataProvider().getAllChatCounter(),
            initialData: 0,
            builder: (context, snap) {
              return SizedBox(
                height: 72,
                child: BottomNavigationBar(
                    currentIndex: widget.index,
                    onTap: (index) {
                      setState(() {
                        widget.index = index;
                      });
                    },
                    items: [
                      BottomNavigationBarItem(
                          icon: Image.asset("assets/home.png",
                              height: 24, width: 24),
                          activeIcon: Image.asset("assets/home_active.png",
                              height: 24, width: 24),
                          label: "HOME"),
                      BottomNavigationBarItem(
                        icon: Image.asset("assets/leads.png",
                            height: 24, width: 24),
                        activeIcon: Image.asset("assets/leads_active.png",
                            height: 24, width: 24),
                        label: "SELL",
                      ),
                      BottomNavigationBarItem(
                          icon: Stack(children: [
                            Image.asset("assets/social.png",
                                height: 24, width: 24),
                            if (snap.data != 0)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    child: Text(
                                      snap.data.toString(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    )),
                              ),
                          ]),
                          activeIcon: Stack(children: [
                            Image.asset("assets/social_active.png",
                                height: 24, width: 24),
                            if (snap.data != 0)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    child: Text(
                                      snap.data.toString(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    )),
                              ),
                          ]),
                          label: "CHATS"),
                      BottomNavigationBarItem(
                          icon: Image.asset("assets/teams.png",
                              height: 24, width: 24),
                          activeIcon: Image.asset("assets/teams_active.png",
                              height: 24, width: 24),
                          label: "PROJECTS"),
                      BottomNavigationBarItem(
                          icon: Image.asset("assets/sell.png",
                              height: 24, width: 24),
                          activeIcon: Image.asset("assets/sell_active.png",
                              height: 24, width: 24),
                          label: "PBTV"),
                    ]),
              );
            }),
        body: PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
              FadeThroughTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  child: child),
          child: screens[widget.index],
        ));
  }
}
