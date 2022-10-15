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
      title: 'My SqfLite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
        title: const Text('My SQF Lite DataBase'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder(
        future: noteList,
        builder: (context, AsyncSnapshot<List<NotesModel>> snspshot) {
          if(snspshot.hasData){
            return ListView.builder(
              itemCount: snspshot.data!.length,
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
                  key: ValueKey<int>(snspshot.data![index].id!),
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
                    key: ValueKey<int>(snspshot.data![index].id!),
                    onDismissed: (DismissDirection direction) {
                      setState(() {
                        dbHelper?.deleteProduct(snspshot.data![index].id!);
                        noteList = dbHelper!.getCartListWithUserId();
                        snspshot.data?.remove(snspshot.data![index]);
                      });
                    },
                    child: Card(
                      margin: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      shadowColor: Colors.teal,
                      elevation: 9,
                      semanticContainer: true,
                      child: SizedBox(
                          height: 90,
                          child: Center(
                              child: ListTile(
                                title: Text(
                                  snspshot.data![index].title,
                                ),
                                subtitle: Text(
                                  snspshot.data![index].description,
                                ),
                                trailing: Text(
                                  snspshot.data![index].age.toString(),
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
        child: const Icon(Icons.arrow_forward_sharp),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
