import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/funcitons.dart';
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
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Container(
                      decoration:
                          const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Name: ${stationRequests[index].name}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Location: ${stationRequests[index].address}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Owner: ${stationRequests[index].ownerName}',
                              style: const TextStyle(color: Colors.white),),
                            Text(
                              'Phone: ${stationRequests[index].ownerPhone}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Number of Charging Points: ${stationRequests[index].plugs}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              IconButton(onPressed: (){
                                String long=stationRequests[index].longitude.toString();
                                String lat=stationRequests[index].latitude.toString();
                                String url="https://www.google.com/maps/@${lat},${long},15z";
                                appinfo.openExternalApplication(url);
                              }, icon: Icon(Icons.mail_outline_outlined, color: Colors.white),),
                            ],
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon:
                                  const Icon(Icons.check, color: Colors.white),
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
                              icon:
                                  const Icon(Icons.close, color: Colors.white),
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
                                  // Handle error
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
