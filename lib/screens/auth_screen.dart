import 'package:Medicines/providers/auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;

  void _submitForm(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) async {
    //UserCredential userCredential;
    try {
      setState(() {
        _isLoading = true;
      });

      if (isLogin) {
        await Provider.of<Auth>(context, listen: false).login(
          email,
          password,
        );
      } else {
        await Provider.of<Auth>(context, listen: false)
            .signUp(email, password, username);
      }
    } on FirebaseAuthException catch (e) {
      var message = 'An error occurd!';
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        message += ' The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        message += ' The account already exists for that email.';
      } else if (e.code == 'user-not-found') {
        print('The user is not regisered yet!');
        message +=
            ' The account is not found. Check your email or rigester first.';
      } else if (e.code == 'wrong-password') {
        print('wrong password');
        message += ' Wrong password!';
      }
      _showSnackBar(ctx, message);
      setState(() {
        _isLoading = false;
      });
    } on PlatformException catch (err) {
      var message = 'An error occurd!';
      if (err.message != null) {
        message += ' ${err.message}';
      }
      _showSnackBar(ctx, message);
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnackBar(BuildContext ctx, String message) {
    Scaffold.of(ctx).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(230, 230, 230, 1).withOpacity(0.5),
                  Color.fromRGBO(19, 19, 19, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthForm(
                      _isLoading,
                      _submitForm,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
