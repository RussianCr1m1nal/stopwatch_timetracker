import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stopwatch_timetracking/application/theme/app_colors.dart';
import 'package:flutter_stopwatch_timetracking/application/theme/app_theme.dart';
import 'package:flutter_stopwatch_timetracking/data/database/object_box.dart';
import 'package:flutter_stopwatch_timetracking/di/di.dart';
import 'package:flutter_stopwatch_timetracking/presentation/screen/home_screen.dart';
import 'package:flutter_stopwatch_timetracking/presentation/screen/log_screen.dart';
import 'package:injectable/injectable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
    statusBarColor: AppColors.appBarBackgroundColor,
  ));

  await initStoreForDataBase();

  await configureDependencies(Environment.dev);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stopwatch',
      theme: AppTheme.defaults(),
      routes: {
        HomeScreen.routeName: (BuildContext context) => const HomeScreen(),
        LogScreen.routeName: (BuildContext context) => const LogScreen(),
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}
