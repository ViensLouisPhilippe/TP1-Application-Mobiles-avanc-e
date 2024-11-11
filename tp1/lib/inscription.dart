import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp1/connexion.dart';
import 'package:tp1/accueil.dart';
import 'package:tp1/service.dart';
import 'package:tp1/transfer.dart';
import 'generated/l10n.dart';

class Inscription extends StatefulWidget {
  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String _errorMessage = "";
  bool _isLoading = false;

  Future<void> inscription(SignupRequest req) async {
    setState(() {
      _isLoading = true;
    });

    try {
      var response = await postHttpSignUp(req);
      print(response);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Accueil()),
      );
    } on DioException catch (e) {
      String message = e.response!.data.toString();
      print("Error response: $message");

      setState(() {
        if (message.contains("UsernameAlreadyTaken")) {
          _errorMessage = S.of(context)!.usernameAlreadyTaken;
        } else if (message.contains("UsernameTooShort")) {
          _errorMessage = S.of(context)!.usernameTooShort;
        } else if (message.contains("PasswordTooShort")) {
          _errorMessage = S.of(context)!.passwordTooShort;
        } else {
          _errorMessage = S.of(context)!.unknownError;
        }
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context)!.signUp),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          // Scrollable content inside a SingleChildScrollView
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(labelText: S.of(context)!.username),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context)!.pleaseEnterUsername;
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: S.of(context)!.password),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context)!.pleaseEnterPassword;
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(labelText: S.of(context)!.confirmPassword),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context)!.pleaseConfirmPassword;
                        }
                        if (value != _passwordController.text) {
                          return S.of(context)!.passwordsDoNotMatch;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(S.of(context)!.processingData)),
                          );
                          SignupRequest req = SignupRequest();
                          req.username = _usernameController.text;
                          req.password = _passwordController.text;
                          await inscription(req);
                        }
                      },
                      child: Text(S.of(context)!.signUp),
                    ),
                    ElevatedButton(
                      child: Text(S.of(context)!.alreadyHaveAnAccount),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Connection()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Show the loading indicator if the form is being processed
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
