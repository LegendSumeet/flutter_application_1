import 'package:flutter/material.dart';
import 'package:flutter_application_1/HomeScreen/requests.dart';
import 'package:flutter_application_1/controller/httpres.dart';
import 'package:flutter_application_1/model/statioMOdel.dart';
import 'package:provider/provider.dart';


class ChargingStation {
  final String name;
  final String location;

  ChargingStation(this.name, this.location);
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChargingStation> chargingStations = [
    ChargingStation('Station A', 'Location A'),
    ChargingStation('Station B', 'Location B'),
    ChargingStation('Station C', 'Location C'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [Icon(Icons.logout)],
        title: const Text('Charging Stations'),
      ),
      body: FutureBuilder<List<GetStations>>(
        future: AuthHelper.getStation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Display an error message if fetching data fails
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Handle case where no data is available
            return Center(child: Text('No charging stations available.'));
          } else {
            // Display the list of charging stations
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(snapshot.data![index].name),
                    subtitle: Text(snapshot.data![index].address),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Implement deletion logic here
                        // For example: deleteStation(snapshot.data[index]);
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          // Navigate to the admin request page
          Future<List<GetStations>> getStations =  AuthHelper.getStation();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminRequestPage(getStations:getStations ,)),
          );
        },
        tooltip: 'Other Requests',
        child: const Icon(Icons.message),
      ),
    );
  }
}