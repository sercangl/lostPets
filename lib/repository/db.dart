import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pets/model/pet.dart';

abstract class DbOperations {
  static final db = Firestore.instance;
  static Future<void> addPet(Pet pet) async {
    await db.collection('news').add({
      'animalType': pet.name,
      'animalColor': pet.color,
      'location': pet.location,
      'animalType': pet.type,
      'notes': pet.notes,
      'con_number': pet.contactNumber,
      'imgUrl': pet.imgUrl,
    });
  }
}
