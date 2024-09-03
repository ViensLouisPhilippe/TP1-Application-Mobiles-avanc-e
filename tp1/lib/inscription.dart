import 'package:flutter/material.dart';


class inscription extends StatefulWidget {
  const inscription ({super.key});

  @override
  State<inscription> createState() => _State();
}

class _State extends State<inscription> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "nom d'utilisateur",
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Mot de passe",
              ),
            ),
          ],
        ),

      ),
    );
  }
}
