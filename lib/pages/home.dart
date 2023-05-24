import 'package:chatapp/firebase_service/auth_service.dart';
import 'package:chatapp/pages/add_status.dart';
import 'package:chatapp/pages/status_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddStatusPage()));
          },
          child: const Icon(Icons.add),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const UserAccountsDrawerHeader(
                accountName: Text("Hello World"),
                accountEmail: Text("helloworld@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/beyaz.png"),
                ),
              ),
              ListTile(
                title: const Text('Anasayfa'),
                leading: const Icon(Icons.home),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Profilim'),
                onTap: () {
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.person),
              ),
              const Divider(),
              ListTile(
                title: const Text('Çıkış yap'),
                onTap: () {
                  _authService.signOut();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.remove_circle),
              ),
            ],
          ),
        ),
        body: const StatusListPage());
  }
}
