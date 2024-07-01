import 'package:flutter/material.dart';
import 'package:flutter_day_47/controllers/auth_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () async {
              await context.read<AuthController>().signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}
