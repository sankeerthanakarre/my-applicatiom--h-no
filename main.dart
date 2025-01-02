import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data from API'),
        ),
        body: Center(
          child: FetchDataWidget(),
        ),
      ),
    );
  }
}

class FetchDataWidget extends StatefulWidget {
  @override
  _FetchDataWidgetState createState() => _FetchDataWidgetState();
}

class _FetchDataWidgetState extends State<FetchDataWidget> {
  final String apiUrl = "https://jsonplaceholder.typicode.com/posts";
  List<dynamic> _data = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          _data = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _data.isEmpty
        ? CircularProgressIndicator()
        : ListView.builder(
            itemCount: _data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_data[index]['title']),
                subtitle: Text(_data[index]['body']),
              );
            },
          );
  }
}
