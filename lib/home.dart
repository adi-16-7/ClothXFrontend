import 'package:clothx/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


import 'package:clothx/providers/appConfig.dart';
import 'package:clothx/providers/auth.dart';


class ClothXHomePage extends StatelessWidget {
  final AppConfig appConfig;

  ClothXHomePage({required this.appConfig});

  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  final ThemeData lightTheme = ThemeData(
      primaryColor: Color(0xFFFCF5F2),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),
      scaffoldBackgroundColor: Colors.white,
      cardColor: Colors.white,
      cardTheme: CardTheme(color: Colors.white, elevation: 8),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0XFFFFAB41),
        selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0XFFFFAB41)),
        unselectedLabelStyle: TextStyle(
            fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black),
      ),
      tabBarTheme: const TabBarTheme(
          labelColor: Colors.black,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w700,
          ),
          labelPadding: EdgeInsets.only(right: 20),
          unselectedLabelColor: Color(0xFF666666),
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: UnderlineTabIndicator(
              insets: EdgeInsets.fromLTRB(0, 0, 20, 3),
              borderSide: BorderSide(color: Color(0XFFFFAB41), width: 2))),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF79009),
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)))),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.fromLTRB(10, 2, 0, 2),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
        displaySmall: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        labelLarge: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
        titleMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xff2E3138)),
        titleSmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic),
      ));
  final ThemeData darkTheme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => Auth(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        //darkTheme: darkTheme,
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}