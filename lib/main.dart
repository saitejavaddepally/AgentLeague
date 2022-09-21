import 'package:agent_league/Services/auth_methods.dart';
import 'package:agent_league/Services/local_notification_service.dart';

import 'package:agent_league/route_generator.dart';
import 'package:agent_league/theme/config.dart';
import 'package:agent_league/theme/custom_theme.dart';
import 'package:agent_league/theme/colors.dart';
import 'package:agent_league/ui/Home/bottom_navigation.dart';
import 'package:agent_league/ui/onboarding.dart';
import 'package:agent_league/ui/auth_screens/sign_up.dart';
import 'package:agent_league/ui/sell_screens/uploading_progress_page.dart';
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
  print("OnBackgroundMessage");
  if (message.notification != null) {
    print(message.notification!.body);
    print(message.notification!.title);
    print(message.data);
  }
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.initialize();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
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
      supportedLocales: const [
        Locale("af"),
        Locale("am"),
        Locale("ar"),
        Locale("az"),
        Locale("be"),
        Locale("bg"),
        Locale("bn"),
        Locale("bs"),
        Locale("ca"),
        Locale("cs"),
        Locale("da"),
        Locale("de"),
        Locale("el"),
        Locale("en"),
        Locale("es"),
        Locale("et"),
        Locale("fa"),
        Locale("fi"),
        Locale("fr"),
        Locale("gl"),
        Locale("ha"),
        Locale("he"),
        Locale("hi"),
        Locale("hr"),
        Locale("hu"),
        Locale("hy"),
        Locale("id"),
        Locale("is"),
        Locale("it"),
        Locale("ja"),
        Locale("ka"),
        Locale("kk"),
        Locale("km"),
        Locale("ko"),
        Locale("ku"),
        Locale("ky"),
        Locale("lt"),
        Locale("lv"),
        Locale("mk"),
        Locale("ml"),
        Locale("mn"),
        Locale("ms"),
        Locale("nb"),
        Locale("nl"),
        Locale("nn"),
        Locale("no"),
        Locale("pl"),
        Locale("ps"),
        Locale("pt"),
        Locale("ro"),
        Locale("ru"),
        Locale("sd"),
        Locale("sk"),
        Locale("sl"),
        Locale("so"),
        Locale("sq"),
        Locale("sr"),
        Locale("sv"),
        Locale("ta"),
        Locale("tg"),
        Locale("th"),
        Locale("tk"),
        Locale("tr"),
        Locale("tt"),
        Locale("uk"),
        Locale("ug"),
        Locale("ur"),
        Locale("uz"),
        Locale("vi"),
        Locale("zh")
      ],
      localizationsDelegates: const [
        CountryLocalizations.delegate,
      ],
      title: 'Agent League',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: CustomTheme.lightTheme,
      //3
      darkTheme: CustomTheme.darkTheme,
      //4
      themeMode: currentTheme.currentTheme,
      //5
      builder: EasyLoading.init(),
      home: FutureBuilder<User?>(
        future: AuthMethods().getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BottomBar(index: 0);
          } else {
            return const Onboarding();
          }
        },
      ),
    );
  }
}
