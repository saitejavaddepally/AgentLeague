import 'package:agent_league/route_generator.dart';
import 'package:agent_league/theme/config.dart';
import 'package:agent_league/theme/custom_theme.dart';
import 'package:agent_league/theme/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      initialRoute: '/',
      theme: CustomTheme.lightTheme,
      //3
      darkTheme: CustomTheme.darkTheme,
      //4
      themeMode: currentTheme.currentTheme, //5
    );
  }
}
