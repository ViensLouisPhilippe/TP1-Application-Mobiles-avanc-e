import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: const Text('exemple'),
              accountEmail: const Text('exemple@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network('https://tmssl.akamaized.net//images/foto/galerie/lionel-messi-argentinien-2022-1698689902-120754.jpg?lm=1698689910',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            decoration: const BoxDecoration(
              image: DecorationImage
                (image: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpn1HdAxEkkXu52D7NKjnhnNIoUBWSXy1muw&s'
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushNamed('');
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Create Task'),
            onTap: () => print('Creation'),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log out'),
            onTap: () => print('deconnection'),
          ),
        ],
      ),
    );
  }
}