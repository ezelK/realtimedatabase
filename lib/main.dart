import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:realtimedatabase/views/read_examples.dart';
// import 'package:realtimedatabase/views/write_examples.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


// void main() async{
//   // WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Text('Check examples!'),
//             SizedBox(
//               height: 6,
//               width: MediaQuery.of(context).size.width,
//             ),
//             ElevatedButton(
//             onPressed: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context) => ReadExamples(),));
//             },
//             child: Text('Read Examples'),
//             ),
//             ElevatedButton(
//               onPressed: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => WriteExamples(),));
//
//               },
//               child: Text('Write Examples'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
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
        body: Examples(),
      ),
    );
  }
}
class Examples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Data').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(document['trying'].toString()),
                  subtitle: new Text(document['weight'].toString()),
                );
              }).toList(),
            );
        }
      },
    );
  }
}
// class WriteExamples extends StatefulWidget{
//   @override
//   _WriteExamplesState createState() => _WriteExamplesState();
//
// }
//
// class _WriteExamplesState extends State<WriteExamples> {
//   final database = FirebaseDatabase.instance.reference();
//   late DatabaseReference databaseReference;
//  @override
//   void initState() {
//     super.initState();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     final data2 = database.child('/data');
//     return Scaffold(
//       appBar: AppBar(title: Text('Write Examples'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 15.0),
//           child: Column(
//             children: [
//               ElevatedButton(
//                   onPressed: () async{
//                     Text('Hello');
//                     try{
//                       Text('Hello2');
//                       await data2.set({'weight' : 25});
//                       print('Special of the day has been written');
//                     }catch(e){
//                       print('You got an error! $e');
//                     }
//                     // data2.set({
//                     //   'weight' : 25,})
//                     //     .then((_) => print("Special of the day has been written"))
//                     //     .catchError((error) => print('You got an error! $error'));
//                   },
//                   child: Text('Simple set'))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }