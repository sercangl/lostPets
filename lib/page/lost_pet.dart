import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LostPet extends StatefulWidget {
  LostPet({Key key}) : super(key: key);

  _LostPetState createState() => _LostPetState();
}

class _LostPetState extends State<LostPet> {
  String id;
  final db = Firestore.instance;

  void readData() async {
    DocumentSnapshot snapshot = await db.collection('news').document(id).get();
    print(snapshot.data['animalType']);
    print(snapshot.data['animalColor']);
    print(snapshot.data['location']);
    print(snapshot.data['notes']);
    print(snapshot.data['con_number']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lost Animals'),
        centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder(
          stream: Firestore.instance.collection('news').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text(
                'No Data...',
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  return PetInfoCard(doc: ds);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class PetInfoCard extends StatelessWidget {
  PetInfoCard({this.doc});
  final DocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Column(
        children: <Widget>[
          Text(doc['animalType']),
          Text(doc['location']),
          Text(doc['con_number']),
          Text(doc['notes'])
        ],
      ),
    );
  }
}
