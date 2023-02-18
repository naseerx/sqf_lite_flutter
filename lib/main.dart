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
      title: 'My SqfLite App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
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
        title: const Text('My SQF Lite DataBase'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder(
        future: noteList,
        builder: (context, AsyncSnapshot<List<NotesModel>> snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.red,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(Icons.delete,color: Colors.white,size: 50,),
                      ],
                    ),
                  ),
                  key: ValueKey<int>(snapshot.data![index].id!),
                  child: Dismissible(
                    direction: DismissDirection.endToStart,
                    background: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.red,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(Icons.delete,color: Colors.white,size: 50,),
                        ],
                      ),
                    ),
                    key: ValueKey<int>(snapshot.data![index].id!),
                    onDismissed: (DismissDirection direction) {
                      setState(() {
                        dbHelper?.deleteProduct(snapshot.data![index].id!);
                        noteList = dbHelper!.getCartListWithUserId();
                        snapshot.data?.remove(snapshot.data![index]);
                      });
                    },
                    child: Card(
                      margin: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      shadowColor: Colors.amber,
                      elevation: 4,
                      semanticContainer: true,
                      child: SizedBox(
                          height: 90,
                          child: Center(
                              child: ListTile(
                                title: Text(
                                  snapshot.data![index].title + '        (' + snapshot.data![index].email.toString() + ')',
                                ),
                                subtitle: Text(
                                  snapshot.data![index].description,
                                ),
                                trailing: Text(
                                  snapshot.data![index].age.toString(),
                                ),
                              ))),
                    ),
                  ),
                );
              },
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigator,
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
