import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/home/home_screen.dart';
import 'package:todo/my_theme_data.dart';
import 'package:todo/providers/app_config_provider.dart';
import 'package:todo/providers/listprovider.dart';

import 'home/authentication/login/login.dart';
import 'home/authentication/regestration/signUp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Now you can use FirebaseFirestore
  await FirebaseFirestore.instance.disableNetwork();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AppConfigProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ListProvider(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        Signup.routeName: (context) => Signup(),
        Login.routeName: (context) => Login(),
      },
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: provider.appTheme,
      locale: Locale(provider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
