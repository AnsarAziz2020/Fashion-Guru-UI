import 'package:fashion_guru/controllers/users.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final loggedInUser;
  const HomeScreen({super.key,required this.loggedInUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 50,
            color: Colors.orange,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(loggedInUser['name']),
                ElevatedButton(onPressed: () async {

                }, child: Icon(Icons.logout),)
              ],
            ),
          )
        ],
      ),
    );
  }
}

