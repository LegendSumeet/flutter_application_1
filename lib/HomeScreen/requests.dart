import 'package:flutter/material.dart';
import '../model/statioMOdel.dart';
import 'package:http/http.dart' as http;

class AdminRequestPage extends StatefulWidget {
  final Future<List<GetStations>> getStations;

  const AdminRequestPage({Key? key, required this.getStations}) : super(key: key);

  @override
  _AdminRequestPageState createState() => _AdminRequestPageState();
}

class _AdminRequestPageState extends State<AdminRequestPage> {
  List<GetStations> stationRequests = [];

  @override
  void initState() {
    super.initState();
    // Initialize stationRequests using getStations future
    widget.getStations.then((stations) {
      setState(() {
        stationRequests = stations;
      });
    }).catchError((error) {
      // Handle error if fetching stations fails
      print('Error fetching stations: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Station Requests'),
      ),
      body: stationRequests.isEmpty
          ? Center(
        child: Text('There are no requests pending.'),
      )
          : ListView.builder(
        itemCount: stationRequests.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Location: ${stationRequests[index].address}'),
            subtitle: Text(
                'Number of Charging Points: ${stationRequests[index].plugs}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () async {

                    var url = Uri.http(
                        "16.171.199.244:5001", "/createstation/station/approve/${stationRequests[index].id}");
print(url);
                    var response = await http.patch(url);
                    if (response.statusCode == 200) {
                      // Handle accepting the station request
                      // This could involve notifying the user and removing the request from the list
                      setState(() {
                        stationRequests.removeAt(index);
                      });
                    } else {
                      // Handle error if creating station fails
                      print('Error creating station');
                    }





                  },
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () async{

                    var url = Uri.http(
                        "16.171.199.244:5001", "/createstation/station/reject/${stationRequests[index].id}");
print(url);
                    var response = await http.patch(url);
                    if (response.statusCode == 200) {
                      // Handle accepting the station request
                      // This could involve notifying the user and removing the request from the list
                      setState(() {
                        stationRequests.removeAt(index);
                      });
                    } else {
                      // Handle error if creating station fails
                      print('Error creating station');
                    }

                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
