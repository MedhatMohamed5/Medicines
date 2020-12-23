import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) submitForm;
  AuthForm(this.isLoading, this.submitForm);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      widget.submitForm(
        _userEmail,
        _userPassword,
        _userName,
        _isLogin,
        context,
      );

      /*print(_userName);
      print(_userEmail);
      print(_userPassword);*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    backgroundImage:
                        const AssetImage('assets/images/medicine_icon.png'),
                  ),
                  TextFormField(
                    key: ValueKey('email'),
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                    ),
                    onSaved: (value) {
                      _userEmail = value.trim();
                    },
                    validator: (value) {
                      if (value.trim().isEmpty || !value.trim().contains('@'))
                        return 'Please enter a vaild email address';
                      return null;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value.trim().isEmpty || value.trim().length < 4)
                          return 'Please enter a valid username';
                        return null;
                      },
                      autocorrect: true,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                      onSaved: (value) {
                        _userName = value.trim();
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value.trim().isEmpty || value.trim().length < 8)
                        return 'Please enter a strong password at least 8 characters without spaces';
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    onSaved: (value) {
                      _userPassword = value.trim();
                    },
                    onChanged: (value) {
                      _userPassword = value.trim();
                    },
                  ), //Password
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('passwordConfirm'),
                      validator: (value) {
                        if (value.trim().isEmpty)
                          return 'Please enter a confirmed password at least 8 characters without spaces';
                        if (value.trim() != _userPassword)
                          return 'Not matched!';
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                      ),
                    ), //Confirm Password

                  SizedBox(
                    height: 12,
                  ),
                  widget.isLoading
                      ? CircularProgressIndicator()
                      : RaisedButton(
                          onPressed: _trySubmit,
                          child: Text(_isLogin ? 'Login' : 'Sign up'),
                        ),
                  if (!widget.isLoading)
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'Create new account'
                          : 'Have account? Login'),
                      textColor: Theme.of(context).primaryColor,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
