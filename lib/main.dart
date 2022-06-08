import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:realtimedatabase/views/read_examples.dart';
// import 'package:realtimedatabase/views/write_examples.dart';
import 'firebase_options.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
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
      home: Scaffold(
        appBar: AppBar(
          title: Text("Deneme"),
        ),
        body: readPage(),
      ),
    );
  }
}


class readPage extends StatefulWidget {
  @override
  State<readPage> createState() => _readPageState();
}

class _readPageState extends State<readPage> {
  String _weight = '0.0';
  DatabaseReference dref = FirebaseDatabase.instance.ref();

  late DatabaseReference databaseReference;
  final _database = FirebaseDatabase.instance.ref();

  final userNameRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    _activateListenerse();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  Future<void> _activateListenerse() async {
    _database.child('Data/Weight').onValue.listen((event) {
      final Object? name = event.snapshot.value;
      setState(() {
        _weight = '$name';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(double.tryParse(_weight));
    return Scaffold(
        body: Center(
          child: Column(
            children: [
              Text(_weight),
            ],
          ),
        ));
  }
}
