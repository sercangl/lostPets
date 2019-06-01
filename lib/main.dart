import 'package:flutter/material.dart';

import 'package:pets/app.dart';

void main() => runApp(App());

/*return Scaffold(
      appBar:  AppBar(
        title:  Text("dd"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: id != null ? readData : null,
                child: Text('Read', style: TextStyle(color: Colors.white)),
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    ); */

////////////////////////////////////////
/*
class AnimalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('news').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return  Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return  Text('Loading...');
          default:
            return  ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return  ListTile(
                  title: ,
                )
              }).toList(),
            );
        }
      },
    );
  }
}
/*@override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title:  Text("Deneme2"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Please enter a pets type'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                },
                onSaved: (value) => animalType = value,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Please enter a pets color'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                },
                onSaved: (value) => animalColor = value,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Please enter Location'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                },
                onSaved: (value) => location = value,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Notes'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                },
                onSaved: (value) => notes = value,
              ),
              
              RaisedButton(
                child:  Text("SAVE",
                    style:  TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 20.0)),
                color: Colors.yellow,
                onPressed: createData,
                //{
                //    Navigator.pop(
                //    context,
                //    //   MaterialPageRoute(builder: (context) => foundpet()),
                //  );
                //   },
              ),
            ],
          ),
        ),
      ),
    );
  } */


*/
