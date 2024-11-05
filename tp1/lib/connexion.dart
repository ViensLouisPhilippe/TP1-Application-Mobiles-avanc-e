import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp1/inscription.dart';
import 'package:tp1/accueil.dart';
import 'package:tp1/main.dart';
import 'package:tp1/service.dart';
import 'package:tp1/transfer.dart';

class Connection extends StatefulWidget {
  @override
  _ConnectionState createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isSigningIn = false; // Flag to track the signing in process

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      // Show the loading overlay when the sign-in starts
                      setState(() {
                        _isSigningIn = true;
                      });

                      if (_formKey.currentState?.validate() ?? false) {
                        try {
                          // Show snack bar to indicate that the process has started
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Signing In...')),
                          );

                          // Prepare the sign-in request object
                          SignupRequest req = SignupRequest();
                          req.username = _usernameController.text;
                          req.password = _passwordController.text;

                          // Perform the sign-in request
                          var response = await postHttpSignIn(req);
                          print(response);

                          // After successful sign-in, navigate to the Accueil page
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Accueil()),
                          );
                        } on DioException catch (e) {
                          // Handle any errors that occur during the sign-in process
                          String message = e.response?.data ?? 'Unknown error';
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('utilisateur inexistant veuillez réessayez')),
                          );
                          print('Error during sign-in: $message');
                        } finally {
                          // Hide the loading overlay after the sign-in process ends
                          setState(() {
                            _isSigningIn = false;
                          });
                        }
                      }
                    },
                    child: Text('Sign In'),
                  ),
                  ElevatedButton(
                    child: Text("Don't have an account? Sign up here"),
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
          // If _isSigningIn is true, show the loading overlay
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
