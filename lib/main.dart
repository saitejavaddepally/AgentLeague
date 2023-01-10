import 'package:agent_league/Services/local_notification_service.dart';
import 'package:agent_league/helper/constants.dart';
import 'package:agent_league/helper/shared_preferences.dart';

import 'package:agent_league/route_generator.dart';
import 'package:agent_league/theme/config.dart';
import 'package:agent_league/theme/custom_theme.dart';
import 'package:agent_league/theme/colors.dart';
import 'package:agent_league/ui/Home/bottom_navigation.dart';
import 'package:agent_league/ui/auth_screens/login.dart';
import 'package:agent_league/ui/onboarding.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

// works when the app is in background open or close doesn't matter
Future<void> backgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {}
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().init();

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State {
  @override
  void initState() {
    if (CustomTheme.isDarkTheme) {
      final style = SystemUiOverlayStyle(
        systemNavigationBarColor: CustomColors.dark,
        systemNavigationBarIconBrightness: Brightness.light,
      );
      SystemChrome.setSystemUIOverlayStyle(style);
    }

    // currentTheme.addListener(() {
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: locale,

      localizationsDelegates: const [
        CountryLocalizations.delegate,
      ],
      title: 'Agent League',

      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: CustomTheme.lightTheme(context),
      //3
      darkTheme: CustomTheme.darkTheme(context),
      //4
      themeMode: currentTheme.currentTheme,
      //5
      builder: EasyLoading.init(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        initialData: FirebaseAuth.instance.currentUser,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return FutureBuilder<bool?>(
              future: SharedPreferencesHelper.isOnboardingSeen(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data == true) {
                  FlutterNativeSplash.remove();
                  return const Login();
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const SizedBox();
                } else {
                  FlutterNativeSplash.remove();
                  return const Onboarding();
                }
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          } else {
            FlutterNativeSplash.remove();
            return BottomBar(index: 0);
          }
        },
      ),
    );
  }
}
