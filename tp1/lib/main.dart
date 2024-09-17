import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:tp1/principal_page.dart';
import 'connexion.dart';
import 'inscription.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SignInScreen(),
      /*initialRoute: '/',
      routes: {
        '/': (context) => const Accueil(),
        '/creation': (context) => Creation(onTaskCreated: (task) {}),
        '/main': (context) => const MyApp(),
      },*/
    );
  }
}

/*class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dio = Dio();

  void getHttp() async {
    final response = await dio.get('http://10.0.2.2:8080/');
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: [
                ElevatedButton(
                  child : Text("Sign Up"),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Inscription(),
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  child : Text("Sign In"),
                  onPressed: (){
                    //getHttp();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Connexion(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}*/
