import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {

  final String title ;
  final String description ;
  final int id;

  UpdateScreen({
    super.key,
    required this.title,
    required this.description,
    required this.id
});



  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  void initState(){
    titlecontroller.text = widget.title;
    decsriptioncontroller.text = widget.description;
    upadateid = widget.id;

    DateTime now = DateTime.now();
    String currentDate = '${now.day}/${now.month}/${now.year}';
    datecontoller.text = currentDate;
    super.initState();

  }

  late int upadateid;


  final titlecontroller = TextEditingController();
  final decsriptioncontroller = TextEditingController();
  final datecontoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Update Notes",
          style: TextStyle(
              letterSpacing: 2, fontWeight: FontWeight.w600, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                        fontSize: 25,
                      ),
                      hintText: "Title",
                      border: null),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                        fontSize: 25,
                      ),
                      hintText: "Notes",
                      border: null),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(onTap: () async {
                  DataTime? datepick = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2050),
                    initialDate: DateTime.now(),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
