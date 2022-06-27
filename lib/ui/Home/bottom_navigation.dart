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

class BottomBar extends StatefulWidget {
  bool isIndexGiven;
  int index;
  BottomBar({Key? key, required this.isIndexGiven, required this.index})
      : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;
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
      print("get initial message");
      if (message != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      }
    });

    //work when the app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // print("OnMessage");
      // if (message.notification != null) {
      //   print(message.notification!.body);
      //   print(message.notification!.title);
      // }
      await LocalNotificationService.display(message);
    });

    //when the app is in the background but not terminated and user taps on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("OnMessageOpenedApp");
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
        print(message.data);
      }
    });
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
    return FutureBuilder(
        future: AuthMethods().getUserId(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            SharedPreferencesHelper().saveUserId(snapshot.data.toString());
          }

          return Scaffold(
              bottomNavigationBar: SizedBox(
                height: 72,
                child: BottomNavigationBar(
                    currentIndex:
                        (widget.isIndexGiven) ? widget.index : _currentIndex,
                    onTap: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    type: BottomNavigationBarType.fixed,
                    selectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      letterSpacing: -0.15,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      letterSpacing: -0.15,
                    ),
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.white.withOpacity(0.3),
                    backgroundColor: const Color(0xFF082640),
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
                          icon: Image.asset("assets/social.png",
                              height: 24, width: 24),
                          activeIcon: Image.asset("assets/social_active.png",
                              height: 24, width: 24),
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
              ),
              body: PageTransitionSwitcher(
                transitionBuilder:
                    (child, primaryAnimation, secondaryAnimation) =>
                        FadeThroughTransition(
                            animation: primaryAnimation,
                            secondaryAnimation: secondaryAnimation,
                            child: child),
                child: screens[_currentIndex],
              ));
        });
  }
}
