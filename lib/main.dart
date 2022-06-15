import 'package:agent_league/Services/auth_methods.dart';
import 'package:agent_league/firebase_options.dart';
import 'package:agent_league/route_generator.dart';
import 'package:agent_league/theme/config.dart';
import 'package:agent_league/theme/custom_theme.dart';
import 'package:agent_league/theme/colors.dart';
import 'package:agent_league/ui/Home/bottom_navigation.dart';
import 'package:agent_league/ui/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initialization();
  runApp(const MyApp());
}

Future initialization() async {
  await Future.delayed(
    const Duration(seconds: 3),
    () {
      FlutterNativeSplash.remove();
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State {
  @override
  void initState() {
    final style = SystemUiOverlayStyle(
      systemNavigationBarColor: CustomColors.dark,
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(style);

    currentTheme.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      title: 'Agent League',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: CustomTheme.lightTheme,
      //3
      darkTheme: CustomTheme.darkTheme,
      //4
      themeMode: currentTheme.currentTheme, //5
      builder: EasyLoading.init(),
      home: FutureBuilder<User?>(
        future: AuthMethods().getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BottomBar(isIndexGiven: false, index: 0,);
          } else {
            return const Onboarding();
          }
        },
      ),
    );
  }
}
