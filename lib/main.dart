import 'package:flutter/material.dart';
import 'package:sqf_lite_flutter/add_data.dart';
import 'package:sqf_lite_flutter/model.dart';

import 'db.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<NotesModel>> noteList;
  DBHelper? dbHelper;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  navigator() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const AddData()));
  }

  loadData() {
    noteList = dbHelper!.getCartListWithUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ok'),
      ),
      body: FutureBuilder(
        future: noteList,
        builder: (context ,AsyncSnapshot<List<NotesModel>> snspshot){
          return ListView.builder(
            itemCount: snspshot.data!.length,
           itemBuilder: ( context,  index) {
              return Card(
                child: Text(snspshot.data![index].title),
              );
           },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigator,
        child: const Icon(Icons.arrow_forward_sharp),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
