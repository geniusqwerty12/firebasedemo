import 'package:firebase_core/firebase_core.dart';
import 'package:firebasedemo/models/aquaplant.dart';
import 'package:flutter/material.dart';

import '../shared/firestore.dart';

class PlantsScreen extends StatefulWidget {
  const PlantsScreen({super.key});

  @override
  State<PlantsScreen> createState() => _PlantsScreenState();
}

class _PlantsScreenState extends State<PlantsScreen> {

  FirestoreData? fireData;

  // If you want your list to stay,
  // don't reload everytime the state is rebuilt
  // you can add a list here
  List<AquaticPlant>? aquaPlants;
  String error = "";

  @override
  void initState() {
    super.initState();
    fireData = FirestoreData();
    // aquaPlants = List.empty(growable: true);
    // fireData!.getPlants().then((res) {
    //   if(res != null) {
    //     error = "";
    //     aquaPlants!.addAll(res);
    //     setState(() { });
    //   } else {
    //     error = "Cannot fetch data due to error";
    //     setState(() { });
    //   }

    // });    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aquatic Plants"),
      ),

      // You can use FutureBuilder here
      body: FutureBuilder(
        future: fireData!.getPlants(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
             print(snapshot.data);
            //  return Container();
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => _buildPlantTile(snapshot.data![index]),
            );
          } else if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              child: Text("Cannot fetch data due to error"),
            );
          }
         
        },
      ),

      // Or render directly without FutureBuilder
      // assuming the you've fetched the data on initState
      // body: ListView.builder(
      //   itemCount: aquaPlants?.length,
      //   itemBuilder: (context, index) => _buildPlantTile(aquaPlants![index]),
      // ),
    );
  }

  Widget _buildPlantTile(AquaticPlant plant) {
    return ListTile(
      leading: Image.network(plant.imageUrl!),
      title: Text(plant.name!),
      subtitle: Text(plant.description!),
    );
  }
}