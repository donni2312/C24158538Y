import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class MyApp extends StatelessWidget {
   const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 final FirebaseFirestore _firestore =FirebaseFirestore.instance;
 final TextEditingController _nameController = TextEditingController();
 final TextEditingController _ageController =TextEditingController();


 Future<void> _create()async{
  await _firestore.collection('users').doc().set({
    "name": _nameController.text,
    'age': _ageController.text  });
 }
 Future<void> _read()async{
  final QuerySnapshot querySnapshot = await _firestore.collection('users').get();
  for(var doc in querySnapshot.docs)
  {
  print(doc.data());
  }
 }

 Future<void>_update()async{
  await _firestore.collection('users').doc('2YxJE7XKGPLnWvJmJ5Dk').update({
    'name': _nameController.text,
    'age':int.parse(_ageController.text),
  });
 }

 Future<void> _delete()async{
  await _firestore.collection('users').doc('2YxJE7XKGPLnWvJmJ5Dk').delete();
 }


 @override
Widget build(BuildContext context) {
  return Scaffold(backgroundColor: const Color.fromARGB(255, 41, 245, 218),
  appBar: AppBar(
    
    title: Text('Firebase Crud Operations'),
    centerTitle: true,
  ),
  body: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: "Your Name",
          ),
        ),  
          TextField(
          controller: _ageController,
          decoration: InputDecoration(
            labelText: "Age",
          ),
        
        ),
        SizedBox(height: 20.0,),
        
       Row(children: [ 
        SizedBox(height: 20),
        ElevatedButton(onPressed: _create, child:Text('Create')),
         SizedBox(height: 10),
        ElevatedButton(onPressed: _read, child:Text('Read')),
         SizedBox(height: 10),
        ElevatedButton(onPressed: _update, child:Text('Update')),
         SizedBox(height: 10),
        ElevatedButton(onPressed: _delete, child:Text('Delete')),],)
         ],
      ),
    ),
  );
}
}
