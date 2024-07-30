import 'package:flutter/material.dart';
import 'package:noteapp/Screens/homescreen.dart';
import 'package:noteapp/Sqflite/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class Insertscreen extends StatefulWidget {
  const Insertscreen({super.key});

  @override
  State<Insertscreen> createState() => _InsertscreenState();
}

class _InsertscreenState extends State<Insertscreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Add Notes",
          style: TextStyle(
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
           Padding(
            padding: EdgeInsets.only(top: 30,left: 15,right: 15),
            child: Text("Title",style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w700,
              fontSize: 20
            ),),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3, left: 15, right: 15),
            child: TextFormField(
              controller: titleController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                // labelText: "Title",
                // labelStyle: const TextStyle(
                //   color: Colors.black54,
                //   fontSize: 20,
                //   letterSpacing: 1,
                //   fontWeight: FontWeight.w400,
                // ),
                hintText: "Enter the valid title",
                hintStyle: const TextStyle(
                  color: Colors.black54,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20,left: 15,right: 15),
            child: Text("Description",style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.w700,
                fontSize: 20
            ),),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3, left: 15, right: 15),
            child: TextFormField(
              controller: descController,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                // labelText: "description",
                // labelStyle: const TextStyle(
                //     color: Colors.black54,
                //     fontSize: 20,
                //     letterSpacing: 1,
                // fontWeight: FontWeight.w400),
                hintText: "Enter the valid description",
                hintStyle: const TextStyle(
                  color: Colors.black54,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 130, left: 15, right: 15),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                insertData(
                        title: titleController.text.toString(),
                        description: descController.text.toString())
                    .then(
                  (value) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ));
                  },
                );
              },
              child: const Text(
                "Save",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> insertData(
      {required String title, required String description}) async {
    Database db = await DatabaseHelper.dbHelper();

    await db.rawInsert(
        "Insert into notes(title,description) values('$title','$description')");

  }
}
