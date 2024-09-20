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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
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
                onPressed: () async{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Signing In...')),
                  );
                  try {
                    SignupRequest req = SignupRequest();
                    req.username = _usernameController.text;
                    req.password = _passwordController.text;
                    var reponse = await postHttpSignIn(req);
                    print(reponse);
                  } on DioException catch (e) {
                    print(e);
                    String message = e.response!.data;
                    if (message == "BadCredentialsException") {
                      print('login deja utilise');
                      rethrow;
                    } else {
                      print('autre erreurs');
                      rethrow;
                    }
                  }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Accueil(),
                      ),
                    );
                },
                child: Text('Sign In'),
              ),
              ElevatedButton(
                child : Text("Don't have a account sign here"),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Inscription(),
                    ),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
