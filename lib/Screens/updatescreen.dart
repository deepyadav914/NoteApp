import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:  Text("Update Notes",
        style: TextStyle(
          letterSpacing: 2,
          fontWeight: FontWeight.w600,
          fontSize: 24
        ),
        ),
      ),
      body: ListView(
        children: [

        ],
      ),

    );
  }
}
