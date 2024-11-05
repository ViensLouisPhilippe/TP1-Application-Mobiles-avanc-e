import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp1/connexion.dart';
import 'package:tp1/accueil.dart';
import 'package:tp1/service.dart';
import 'package:tp1/transfer.dart';

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
  bool _isLoading = false;  // Track the loading state

  // Method for handling the sign up process
  Future<void> inscription(SignupRequest req) async {
    setState(() {
      _isLoading = true;  // Show loading indicator
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
          _errorMessage = "Le nom d'utilisateur est déjà pris. Veuillez en choisir un autre.";
        } else if (message.contains("UsernameTooShort")) {
          _errorMessage = "Le nom d'utilisateur est trop court. Il doit comporter au moins 3 caractères.";
        } else if (message.contains("PasswordTooShort")) {
          _errorMessage = "Le mot de passe est trop court. Il doit comporter au moins 4 caractères.";
        } else {
          _errorMessage = "Une erreur inconnue s'est produite. Veuillez réessayer.";
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
        title: Text('Sign Up'),
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
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data...')),
                        );
                        SignupRequest req = SignupRequest();
                        req.username = _usernameController.text;
                        req.password = _passwordController.text;
                        await inscription(req);
                      }
                    },
                    child: Text('Sign Up'),
                  ),
                  ElevatedButton(
                    child: Text("Already have an account?"),
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
          // Loading overlay
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),  // Semi-transparent overlay
                child: Center(
                  child: CircularProgressIndicator(),  // Loading spinner
                ),
              ),
            ),
        ],
      ),
    );
  }
}
