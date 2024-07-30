import 'package:flutter/material.dart';
import 'package:noteapp/Screens/insertscreen.dart';
import 'package:noteapp/Sqflite/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initstate() {
    getdata();
    super.initState();
  }

  List<Map<String, dynamic>> newlist = [];

  Future<Database> getdata() async {
    Database db = await DatabaseHelper.dbHelper();
    newlist = await db.rawQuery("SELECT * FROM notes");

    return db;
  }

  Future<void> deletedata(String title) async {
    Database db = await DatabaseHelper.dbHelper();
    db.delete("notes", where: "title=?", whereArgs: [title]);
    newlist = await db.rawQuery("SELECT * FROM notes");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Notes",
          style: TextStyle(
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: getdata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error:${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: newlist.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(

                    shadowColor: Colors.blue,
                    elevation: 8,
                    color: Colors.white,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            newlist[index]["title"],
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 22,
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            newlist[index]["description"],
                            style:  TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Divider(color: Colors.grey),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("28/09/2023",style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                                
                            ),),
                            IconButton(onPressed: () {


                            }, icon: Icon(Icons.edit_outlined,color: Colors.black.withOpacity(0.7),)),

                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Delete Notes",style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500
                              ),),
                              content: const Text("Are you sure?",style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                              ),),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel")),
                                TextButton(
                                    onPressed: () {
                                      deletedata(newlist[index]["title"])
                                          .then(
                                            (value) {
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                    child: const Text("Ok")),
                              ],
                            );
                          },
                        );
                      },
                      icon:  Icon(Icons.delete,color: Colors.black.withOpacity(0.7),)),

                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Container(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const Insertscreen(),
            ),
            (route) => false,
          );
        },
        label: const Text(
          "Add",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.black,
          size: 25,
        ),
      ),
    );
  }
}
