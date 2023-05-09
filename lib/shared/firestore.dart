// Class for Firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedemo/models/aquaplant.dart';
import 'dart:async';

class FirestoreData {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // Create functions to fetch data
  Future<List<AquaticPlant>?> getPlants() async {

    try {
      CollectionReference plantCollection = db.collection("plants");
      List<AquaticPlant> myPlants = List.empty(growable: true);

      // fetch data
      QuerySnapshot snapshot = await plantCollection.get();
      List<QueryDocumentSnapshot> plantList = snapshot.docs;

      for( DocumentSnapshot snap in plantList ) {
        // transform the data
        AquaticPlant temp = AquaticPlant(
          snap.id,
          snap.get("name"),
          snap.get("description"),
          snap.get("imageUrl")
        );
        myPlants.add(temp);
      }
      // print(plantList);

      return myPlants;
    } catch (error) {
      // print(error);
      return null;
    }
  }
}