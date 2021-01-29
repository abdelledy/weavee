import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weavee/tests/models/days.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String woeid;
  Future<Days> fetchWoei(String city) async {
    final response = await http
        .get('https://www.metaweather.com/api/location/search/?query=$city');
    if (response != null) {
      var result = jsonDecode(response.body)[0];
      woeid = result['woeid'].toString();
      // print('Woeid : ' + woeid);
      // ----------------------- Data ----------------------
      final weatherData =
          await http.get('https://www.metaweather.com/api/location/$woeid');
      if (weatherData != null) {
        return Days.fromJson(jsonDecode(weatherData.body));
      } else {
        throw Exception('Faild to get Woeid');
      }
      // ----------------------- Data ----------------------
    } else {
      throw Exception('Faild to get Woeid');
    }
  }

  Future<Days> fetchData;
  @override
  void initState() {
    super.initState();
    fetchData = fetchWoei('Casablanca');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Build in Silence'),
        centerTitle: true,
      ),
      body: Center(
          child: FutureBuilder<Days>(
              future: fetchData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      SizedBox(height: 100.0),
                      Text(
                        'City : ' + snapshot.data.city,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Date : ' + snapshot.data.date,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Temp : ' + snapshot.data.temp,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Sunrise : ' + snapshot.data.sunrise,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Sunset : ' + snapshot.data.sunset,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                          height: 100,
                          child: Image.asset(snapshot.data.imgUrl)),
                      Icon(snapshot.data.one.icon,
                          color: Colors.black, size: 40.0),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              })),
    );
  }
}
