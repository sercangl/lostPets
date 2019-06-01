import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pets/model/pet.dart';
import 'package:pets/repository/db.dart';
import 'package:random_string/random_string.dart' as random;

class FoundPet extends StatefulWidget {
  FoundPet({Key key}) : super(key: key);

  _FoundPetState createState() => _FoundPetState();
}

class _FoundPetState extends State<FoundPet> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String id;
  final _formKey = GlobalKey<FormState>();
  String name;
  String type;
  String color;
  String location;
  String notes;
  DateTime date;
  String contactNumber;
  String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () async {
                          await _onImageButtonPressed(ImageSource.camera);
                        }),
                    IconButton(
                      icon: Icon(Icons.photo),
                      onPressed: () async {
                        await _onImageButtonPressed(ImageSource.gallery);
                      },
                    ),
                  ],
                ),
                RaisedButton(
                  child: Text("SAVE",
                      style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 20.0)),
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
      if (imgUrl == null) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Wait for uploading'),
          duration: Duration(seconds: 3),
        ));
      } else {
        Pet newPet = Pet(
          name: name,
          type: type,
          color: color,
          location: location,
          notes: notes,
          date: date,
          contactNumber: contactNumber,
          imgUrl: imgUrl,
        );
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

  Future<void> _onImageButtonPressed(ImageSource source) async {
    File _imageFile;
    try {
      _imageFile = await ImagePicker.pickImage(source: source);
      final StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('pets/');
      final StorageUploadTask uploadTask =
          firebaseStorageRef.child(random.randomAlpha(20)).putFile(_imageFile);
      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

      setState(() {
        imgUrl = imageUrl.toString();
      });
    } catch (e) {
      // _pickImageError = e;
    }
  }
}
