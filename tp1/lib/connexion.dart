import 'package:flutter/material.dart';
import 'package:tp1/inscription.dart';
import 'package:tp1/accueil.dart';
import 'package:tp1/main.dart';

/*class Connexion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign In Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInScreen(),
    );
  }
}*/

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
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Form is valid; perform the sign-in action
                    final username = _usernameController.text;
                    final password = _passwordController.text;
                    // TODO prochaine page a loader une fois successfull
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Accueil(),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Signing In...')),
                    );
                  }
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
