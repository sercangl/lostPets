import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pets/model/pet.dart';
import 'package:pets/repository/db.dart';

class FoundPet extends StatefulWidget {
  FoundPet({Key key}) : super(key: key);

  _FoundPetState createState() => _FoundPetState();
}

class _FoundPetState extends State<FoundPet> {
  String id;
  final _formKey = GlobalKey<FormState>();
  String name;
  String type;
  String color;
  String location;
  String notes;
  DateTime date;
  String contactNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fill Information"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Type",
                      hintText: 'e.g Dog'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                  onSaved: (value) => type = value,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Color',
                      hintText: 'e.g fawn'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                  onSaved: (value) => color = value,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Location",
                      hintText: 'e.g Izmir'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                  onSaved: (value) => location = value,
                ),
                TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Notes",
                    hintText: 'Provide any necessary information',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                  onSaved: (value) => notes = value,
                ),
                TextFormField(
                  maxLength: 11,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Phone Number",
                    hintText: '05XXXXXXXXX',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Contact number';
                    }
                  },
                  onSaved: (value) => contactNumber = value,
                ),
                RaisedButton(
                  child: Text("SAVE",
                      style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 20.0)),
                  color: Colors.yellow,
                  onPressed: createData,

                  /*    {
            Navigator.pop(context);
          },
          */
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createData() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Pet newPet = Pet(
          name: name,
          type: type,
          color: color,
          location: location,
          notes: notes,
          date: date,
          contactNumber: contactNumber);
      DbOperations.addPet(newPet);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Scaffold(
          body: Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      }));

      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }
}
