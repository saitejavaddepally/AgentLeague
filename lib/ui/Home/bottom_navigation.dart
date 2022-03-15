import 'package:agent_league/ui/Home/home.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;
  List screens = <Widget>[
    const Home(),
    Container(color: Colors.green),
    Container(color: Colors.blue),
    Container(color: Colors.yellow),
    Container(color: Colors.cyan)
  ];

  @override
  Widget build(BuildContext context) {
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
                  icon: Image.asset("assets/home.png", height: 24, width: 24),
                  activeIcon: Image.asset("assets/home_active.png",
                      height: 24, width: 24),
                  label: "HOME"),
              BottomNavigationBarItem(
                icon: Image.asset("assets/leads.png", height: 24, width: 24),
                activeIcon: Image.asset("assets/leads_active.png",
                    height: 24, width: 24),
                label: "LEADS",
              ),
              BottomNavigationBarItem(
                  icon: Image.asset("assets/sell.png", height: 24, width: 24),
                  activeIcon: Image.asset("assets/sell_active.png",
                      height: 24, width: 24),
                  label: "SELL"),
              BottomNavigationBarItem(
                  icon: Image.asset("assets/teams.png", height: 24, width: 24),
                  activeIcon: Image.asset("assets/teams_active.png",
                      height: 24, width: 24),
                  label: "TEAMS"),
              BottomNavigationBarItem(
                  icon: Image.asset("assets/social.png", height: 24, width: 24),
                  activeIcon: Image.asset("assets/social_active.png",
                      height: 24, width: 24),
                  label: "SOCIAL"),
            ]),
      ),
      body: screens[_currentIndex],
    );
  }
}
