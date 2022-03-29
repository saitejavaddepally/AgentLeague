import 'package:agent_league/theme/config.dart';
import 'package:agent_league/theme/custom_theme.dart';
import 'package:agent_league/ui/Home/bottom_navigation.dart';
import 'package:agent_league/ui/Home/home.dart';
import 'package:agent_league/ui/amenties.dart';
import 'package:agent_league/ui/documents.dart';
import 'package:agent_league/ui/emi.dart';
import 'package:agent_league/ui/explore.dart';
import 'package:agent_league/ui/gallery.dart';
import 'package:agent_league/ui/help.dart';
import 'package:agent_league/ui/lead_box.dart';
import 'package:agent_league/ui/location.dart';
import 'package:agent_league/ui/onboarding.dart';
import 'package:agent_league/ui/otp.dart';
import 'package:agent_league/ui/post_your_property.dart';
import 'package:agent_league/ui/profile.dart';
import 'package:agent_league/ui/realtor_card.dart';
import 'package:agent_league/ui/property_info.dart';
import 'package:agent_league/ui/sell_screen.dart';
import 'package:agent_league/ui/sign_up.dart';
import 'package:agent_league/ui/signin_edit.dart';
import 'package:agent_league/ui/tour.dart';
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
        '/onboard': (context) => const Onboarding(),
        '/sign_in_edit': (context) => const SignInEdit(),
        '/sign_up': (context) => const SignUpForm(),
        '/help': (context) => const Help(),
        '/otp': (context) => const Otp(),
        '/leads_box': (context) => const LeadBox(),
        '/profile': (context) => const Profile(),
        '/explore': (context) => const Explore(),
        '/realtor_card': (context) => const RealtorCard(),
        '/home': (context) => const Home(),
        '/sell': (context) => const SellScreen(),
        '/amenties': (context) => const Amenties(),
        '/emi': (context) => const EMI(),
        '/documents': (context) => const Documents(),
        '/tour': (context) => const Tour(),
        '/post_page_one': (context) => const PostYourPropertyPageOne(),
        '/post_page_two': (context) => const PostYourPropertyPageTwo(),
        '/location': (context) => const LocationScreen(),
        '/gallery': (context) => const GalleryScreen(),
      },
      initialRoute: '/gallery',
      theme: CustomTheme.lightTheme,
      //3
      darkTheme: CustomTheme.darkTheme,
      //4
      themeMode: currentTheme.currentTheme, //5
    );
  }
}
