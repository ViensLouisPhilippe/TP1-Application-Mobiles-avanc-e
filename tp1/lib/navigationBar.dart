import 'package:flutter/material.dart';
import 'package:tp1/accueil.dart';
import 'package:tp1/connexion.dart';
import 'package:tp1/creation.dart';
import 'package:tp1/service.dart';
import 'generated/l10n.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  Future<String> _loadUsername() async {
    await MySingleton().loadUsername();
    return MySingleton().username ?? "Guest";
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          FutureBuilder<String>(
            future: _loadUsername(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const UserAccountsDrawerHeader(
                  accountName: Text("Loading..."),
                  accountEmail: Text(''),
                  currentAccountPicture: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                );
              } else if (snapshot.hasError) {
                return UserAccountsDrawerHeader(
                  accountName: Text("Error"),
                  accountEmail: const Text(''),
                  currentAccountPicture: const CircleAvatar(
                    child: Icon(Icons.error),
                  ),
                );
              } else {
                return UserAccountsDrawerHeader(
                  accountName: Text(snapshot.data ?? "Guest"),
                  accountEmail: const Text(''),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                        'https://tmssl.akamaized.net//images/foto/galerie/lionel-messi-argentinien-2022-1698689902-120754.jpg?lm=1698689910',
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpn1HdAxEkkXu52D7NKjnhnNIoUBWSXy1muw&s',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(S.of(context)!.home),  // Translated string
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Accueil(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text(S.of(context)!.createTask),  // Translated string
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Creation(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(S.of(context)!.logout),  // Translated string
            onTap: () async {
              print('Logging out');
              await postHttpSignout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Connection(),
                ),
                    (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
