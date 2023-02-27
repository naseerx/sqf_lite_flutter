import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqf_lite_flutter/db.dart';
import 'package:sqf_lite_flutter/main.dart';
import 'package:sqf_lite_flutter/model.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  DBHelper? dbHelper;
  var title = TextEditingController();
  var age = TextEditingController();
  var description = TextEditingController();
  var email = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        toolbarHeight: 89,
        title: const Text('Add Data'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: InputDecoration(
                hintText: 'Title',
                fillColor: const Color(0xffe9e9e9),
                filled: true,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.green),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.green),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: email,
              decoration: InputDecoration(
                hintText: 'Email Address',
                fillColor: const Color(0xffe9e9e9),
                filled: true,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.green),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.green),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: age,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Your Age',
                fillColor: const Color(0xffe9e9e9),
                filled: true,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.green),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.green),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: description,
              maxLines: 4,
              minLines: 2,
              decoration: InputDecoration(
                hintText: 'Description',
                fillColor: const Color(0xffe9e9e9),
                filled: true,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.green),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.green),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                minimumSize: const Size(250, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Add Data',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                dbHelper
                    ?.insert(NotesModel(
                  title: title.text,
                  age: int.parse(age.text.toString()),
                  email: email.text,
                  description: description.text,
                ))
                    .then((value) {
                  if (kDebugMode) {
                    print('Data Added');
                  }
                }).onError((error, stackTrace) {
                  if (kDebugMode) {
                    print(error);
                  }
                });
                title.clear();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
