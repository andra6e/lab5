import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lanzamientos',
      home: NewsScreen(),
    );
  }
}

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<dynamic> lunchList = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final uri = Uri.parse(
        'https://api.spacexdata.com/v5/launches');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      setState(() {
        lunchList = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lanzamientos'),
      ),
      body: ListView.builder(
        itemCount: lunchList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(lunchList[index]['name'] ?? ''),
              subtitle: Text(lunchList[index]['date_utc'] ?? ''),
              trailing: Text(lunchList[index]['success'] ? 'failure':'successful'),
              leading: Image.network(lunchList[index]['links']['patch']['large']??''),
            ),
          );
        },
      ),
    );
  }
}
