import 'package:agent_league/theme/config.dart';
import 'package:agent_league/theme/custom_theme.dart';
import 'package:agent_league/ui/Home/bottom_navigation.dart';
import 'package:agent_league/ui/help.dart';
import 'package:agent_league/ui/lead_box.dart';
import 'package:agent_league/ui/otp.dart';
import 'package:agent_league/ui/profile.dart';
import 'package:agent_league/ui/sign_up.dart';
import 'package:agent_league/ui/signin_edit.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      title: 'Agent League',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const BottomBar(),
        '/sign_in_edit': (context) => const SignInEdit(),
        '/signup': (context) => const SignUpForm(),
        '/help': (context) => const Help(),
        '/otp': (context) => const Otp(),
         '/leadsBox': (context) => const LeadBox(), 
        '/profile': (context) => const Profile(),
      },
      initialRoute: '/leadsBox',
      theme: CustomTheme.lightTheme, //3
      darkTheme: CustomTheme.darkTheme, //4
      themeMode: currentTheme.currentTheme, //5
    );
  }
}
