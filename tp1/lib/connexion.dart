import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp1/inscription.dart';
import 'package:tp1/accueil.dart';
import 'package:tp1/service.dart';
import 'package:tp1/transfer.dart';
import 'generated/l10n.dart';

class Connection extends StatefulWidget {
  @override
  _ConnectionState createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isSigningIn = false;

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    try {
      await SingletonDio.getDio();
      bool hasSession = await SingletonDio.hasActiveSession();

      if (hasSession) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Accueil()),
        );
      }
    } catch (e) {
      print("Error checking session: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context)!.signIn),  // Use translated text here
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          // Wrap the entire form content in a SingleChildScrollView to allow scrolling
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(labelText: S.of(context)!.username),  // Translated label
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context)!.pleaseEnterUsername;  // Translated error message
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: S.of(context)!.password),  // Translated label
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context)!.pleaseEnterPassword;  // Translated error message
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                          setState(() {
                            _isSigningIn = true;
                          });

                          if (_formKey.currentState?.validate() ?? false) {
                            try {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(S.of(context)!.processingData)),  // Translated message
                              );

                              SignupRequest req = SignupRequest();
                              req.username = _usernameController.text;
                              req.password = _passwordController.text;

                              var response = await postHttpSignIn(req);
                              print(response);

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Accueil()),
                              );
                            } on DioException catch (e) {
                              String message = e.response?.data ?? 'Unknown error';
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(S.of(context)!.usernameNotFound)),  // Translated error message
                              );
                              print('Error during sign-in: $message');
                            } finally {
                              setState(() {
                                _isSigningIn = false;
                              });
                            }
                          }
                        }
                      },
                      child: Text(S.of(context)!.signIn),  // Translated button text
                    ),
                    ElevatedButton(
                      child: Text(S.of(context)!.dontHaveAccount),  // Translated button text
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Inscription()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Show the loading indicator if the form is being processed
          if (_isSigningIn)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.3),
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
