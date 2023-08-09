import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_gt/provider/property_provider.dart';
import 'package:project_gt/provider/user_provider.dart';
import 'package:project_gt/routes/app_route.dart';
import 'package:project_gt/routes/navigation.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PropertyProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Navigation.navigatorKey,
      title: 'Profile',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 144, 104, 214)),
      ),
      initialRoute: AppRoutes.loading,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
