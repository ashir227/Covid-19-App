// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'COVID-19 Tracker',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: CovidTracker(),
//     );
//   }
// }

// class CovidTracker extends StatefulWidget {
//   @override
//   _CovidTrackerState createState() => _CovidTrackerState();
// }

// class _CovidTrackerState extends State<CovidTracker> {
//   TextEditingController _controller = TextEditingController();
//   String _country = '';
//   int _totalCases = 0;
//   int _totalDeaths = 0;
//   int _totalRecovered = 0; // New variable for total recovered cases

//   Future<void> _getCountryData(String country) async {
//     HttpClient httpClient = HttpClient();
//     try {
//       var uri = Uri.parse('https://disease.sh/v3/covid-19/countries/$country');
//       var request = await httpClient.getUrl(uri);
//       var response = await request.close();
//       if (response.statusCode == HttpStatus.ok) {
//         var responseBody = await response.transform(utf8.decoder).join();
//         var data = jsonDecode(responseBody);
//         setState(() {
//           _totalCases = data['cases'];
//           _totalDeaths = data['deaths'];
//           _totalRecovered = data['recovered']; // Assigning recovered data
//         });
//       } else {
//         print('Error: HTTP status ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     } finally {
//       httpClient.close();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('COVID-19 Tracker'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _controller,
//               onChanged: (value) {
//                 _country = value;
//               },
//               decoration: InputDecoration(
//                 labelText: 'Enter Country',
//               ),
//             ),
//             SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: () {
//                 _getCountryData(_country);
//               },
//               child: Text('Search'),
//             ),
//             SizedBox(height: 20.0),
//             Text(
//               'Total Cases: $_totalCases',
//               style: TextStyle(fontSize: 20.0),
//             ),
//             SizedBox(height: 10.0),
//             Text(
//               'Total Deaths: $_totalDeaths',
//               style: TextStyle(fontSize: 20.0),
//             ),
//             SizedBox(height: 10.0),
//             Text(
//               'Total Recovered: $_totalRecovered', // Displaying total recovered cases
//               style: TextStyle(fontSize: 20.0),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID-19 Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: CovidTracker(),
    );
  }
}

class CovidTracker extends StatefulWidget {
  @override
  _CovidTrackerState createState() => _CovidTrackerState();
}

class _CovidTrackerState extends State<CovidTracker> {
  TextEditingController _controller = TextEditingController();
  String _country = '';
  int _totalCases = 0;
  int _totalDeaths = 0;
  int _totalRecovered = 0;

  Future<void> _getCountryData(String country) async {
    HttpClient httpClient = HttpClient();
    try {
      var uri = Uri.parse('https://disease.sh/v3/covid-19/countries/$country');
      var request = await httpClient.getUrl(uri);
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var responseBody = await response.transform(utf8.decoder).join();
        var data = jsonDecode(responseBody);
        setState(() {
          _totalCases = data['cases'];
          _totalDeaths = data['deaths'];
          _totalRecovered = data['recovered'];
        });
      } else {
        print('Error: HTTP status ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      httpClient.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19 Tracker'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _controller,
                onChanged: (value) {
                  _country = value;
                },
                decoration: InputDecoration(
                  labelText: 'Enter Country',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _getCountryData(_country);
                },
                child: Text('Search'),
              ),
              SizedBox(height: 20.0),
              Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'COVID-19 Statistics for $_country',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      ListTile(
                        title: Text(
                          'Total Cases:',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        trailing: Text(
                          '$_totalCases',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Total Deaths:',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        trailing: Text(
                          '$_totalDeaths',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Total Recovered:',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        trailing: Text(
                          '$_totalRecovered',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
