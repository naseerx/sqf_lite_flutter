import 'package:flutter/material.dart';
import 'package:sqf_lite_flutter/db.dart';
import 'package:sqf_lite_flutter/model.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  DBHelper? dbHelper;
  var title = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 89,
        title: const Text('Add Data'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: title,
          ),
          ElevatedButton(
              onPressed: () {
                dbHelper
                    ?.insert(NotesModel(
                        title: title.text,
                        age: 12,
                        email: 'okjan2gmail.com',
                        description: 'This is house'))
                    .then((value) {
                  print('DAta Added');
                }).onError((error, stackTrace) {
                  print(error);
                });
                title.clear();
              },
              child: Text('Add'))
        ],
      ),
    );
  }
}
