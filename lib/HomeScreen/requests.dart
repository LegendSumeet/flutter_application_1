import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant.dart';
import '../model/statioMOdel.dart';
import 'package:http/http.dart' as http;

class AdminRequestPage extends StatefulWidget {
  final Future<List<GetStations>> getStations;

  const AdminRequestPage({Key? key, required this.getStations})
      : super(key: key);

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
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Station Requests'),
        ),
        body: stationRequests.isEmpty
            ? const Center(
                child: Text('There are no requests pending.'),
              )
            : ListView.builder(
                itemCount: stationRequests.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Name: ${stationRequests[index].name}'),
                        Text('Location: ${stationRequests[index].address}'),
                      ],
                    ),
                    subtitle: Column(
                      children: [

                        Text(
                            'Number of Charging Points: ${stationRequests[index].plugs}'),

                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: () async {
                            var url = Uri.https(Server.url,
                                "/createstation/station/approve/${stationRequests[index].id}");
                            print(url);
                            var response = await http.patch(url);
                            if (response.statusCode == 200) {
                              setState(() {
                                stationRequests.removeAt(index);
                              });
                            } else {
                              print('Error creating station');
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () async {
                            var url = Uri.https(Server.url,
                                "/createstation/station/reject/${stationRequests[index].id}");
                            print(url);
                            var response = await http.patch(url);
                            if (response.statusCode == 200) {

                              setState(() {
                                stationRequests.removeAt(index);
                              });
                            } else {

                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
