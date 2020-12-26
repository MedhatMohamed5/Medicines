import 'package:flutter/material.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './providers/medicines_provider.dart';

import './screens/edit_medicine_screen.dart';
import './screens/auth_screen.dart';
import './screens/home_screen.dart';
import './screens/splash_screen.dart';
import './screens/error_screen.dart';

void main() {
  runApp(Medicines());
}

const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF191919),
    100: Color(0xFF191919),
    200: Color(0xFF191919),
    300: Color(0xFF191919),
    400: Color(0xFF191919),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF191919),
    700: Color(0xFF191919),
    800: Color(0xFF191919),
    900: Color(0xFF191919),
  },
);
const int _blackPrimaryValue = 0xFF191919;

class Medicines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      future: _initialization,
      builder: (context, appSnapshot) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (ctx) => Auth(),
            ),
            ChangeNotifierProvider(
              create: (ctx) => MedicinesProvider(),
            ),
          ],
          child: Consumer<Auth>(
            builder: (ctx, auth, _) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Medicines',
              theme: ThemeData(
                primarySwatch: primaryBlack,
                backgroundColor: Colors.black54,
                accentColor: Colors.amberAccent,
                accentColorBrightness: Brightness.dark,
                buttonTheme: ButtonTheme.of(context).copyWith(
                  buttonColor: Colors.black54,
                  textTheme: ButtonTextTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: appSnapshot.connectionState != ConnectionState.done
                  ? SplashScreen()
                  : appSnapshot.hasError
                      ? ErrorScreen()
                      : StreamBuilder(
                          stream: auth.userState(),
                          builder: (ctx, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) return SplashScreen();
                            if (snapshot.hasData) {
                              return HomeScreen(auth.userId, auth.userName);
                            }
                            if (snapshot.hasError) return ErrorScreen();
                            return AuthScreen();
                          },
                        ),
              routes: {
                EditMedicineScreen.routeName: (ctx) => EditMedicineScreen(),
              },
            ),
          ),
        );
      },
    );
  }
}
