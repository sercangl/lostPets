import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Stateful Widget!"),
            backgroundColor: Colors.deepOrange),
        body: new Container(
            child: new Center(
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
              new Padding(padding: new EdgeInsets.all(10.0)),
              new RaisedButton(
                child: new Text("I Lost My Pet",
                    style: new TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 20.0)),
                color: Colors.red,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => lostpet()),
                  );
                },
              ),
              RaisedButton(
                child: new Text("I Found a pet",
                    style: new TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 20.0)),
                color: Colors.green,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => foundpet()),
                  );
                },
              ),
            ]))));
  }
}

class Animal {}

class foundpet extends StatefulWidget {
  foundpet({Key key}) : super(key: key);

  _foundpetState createState() => _foundpetState();
}

class _foundpetState extends State<foundpet> {
  String id;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String name;
  String animalType;
  String animalColor;
  String location;
  String notes;
  DateTime date;
  String con_number;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Deneme2"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        child: Form(
          key: _formKey,
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
              TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Contact Number'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Contact number';
                  }
                },
                onSaved: (value) => con_number = value,
              ),
              RaisedButton(
                child: new Text("SAVE",
                    style: new TextStyle(
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
    );
  }

  void createData() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return Scaffold(
          body: Container(child: Center(child: CircularProgressIndicator(),),),
        );
      }));
      DocumentReference ref = await db.collection('news').add({
        'animalType': '$animalType',
        'animalColor': '$animalColor',
        'location': '$location',
        'notes': '$notes',
        'con_number': '$con_number',
      });
      setState(() => id = ref.documentID);
      print(ref.documentID);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  void updateData(DocumentSnapshot doc) async {
    await db
        .collection('CRUD')
        .document(doc.documentID)
        .updateData({'todo': 'please ğŸ¤«'});
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('CRUD').document(doc.documentID).delete();
    setState(() => id = null);
  }
}

class lostpet extends StatefulWidget {
  lostpet({Key key}) : super(key: key);

  _lostpetState createState() => _lostpetState();
}

class _lostpetState extends State<lostpet> {
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
                  return Container(
                    height: 50,
                    color: Colors.cyanAccent,
                    child: Center(
                        child: Text(
                            '^#${ds["animalType"]}# ( ${ds["animalColor"]} ) (${ds["location"]})(${ds["notes"]}) #(${ds["con_number"].toString()})# ')),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

/*return Scaffold(
      appBar: new AppBar(
        title: new Text("dd"),
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
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
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
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Deneme2"),
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
                child: new Text("SAVE",
                    style: new TextStyle(
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
