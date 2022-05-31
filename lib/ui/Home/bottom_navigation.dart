import 'package:agent_league/Services/auth_methods.dart';
import 'package:agent_league/helper/shared_preferences.dart';
import 'package:agent_league/ui/Home/chat.dart';
import 'package:agent_league/ui/Home/home.dart';
import 'package:agent_league/ui/Home/project.dart';
import 'package:agent_league/ui/Home/sell_screen.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;
  List screens = <Widget>[
    const Home(),
    const SellScreen(),
    const Chat(),
    const Project(),
    Container(color: Colors.cyan)
  ];

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthMethods().getUserId(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            print(snapshot.data);
            SharedPreferencesHelper().saveUserId(snapshot.data.toString());
          }

          return Scaffold(
              bottomNavigationBar: SizedBox(
                height: 72,
                child: BottomNavigationBar(
                    currentIndex: _currentIndex,
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
