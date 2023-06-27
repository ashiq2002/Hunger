import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hunger/services/firebase_services/auth/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.brown[200],

      child: DrawerHeader(
        padding: EdgeInsets.zero,
          child: Column(
        children: [
          UserAccountsDrawerHeader(
            margin: EdgeInsets.zero,
              accountName: const Text('John Doe'),
              accountEmail: Text(MyAuthService().getCurrentUser!.email.toString()),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(MyAuthService().getCurrentUser!.photoURL.toString()),
            ),
          ),
          const SizedBox(height: 20,),
          //home
          ListTile(
            onTap: (){},
            leading: const Icon(CupertinoIcons.home),
            title: const Text('Home'),
          ),

          //dashboard
          ListTile(
            onTap: (){},
            leading: const Icon(Icons.dashboard_outlined),
            title: const Text('Dashboard'),
          ),

          //contact
          ListTile(
            onTap: (){},
            leading: const Icon(CupertinoIcons.phone),
            title: const Text('Contact'),
          ),

          //about use
          ListTile(
            onTap: (){},
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
          ),

          const Divider(),

          //signout
          ListTile(
            onTap: (){
              MyAuthService().signOut();
            },
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Signout'),
          ),
        ],
      )),
    );
  }
}
