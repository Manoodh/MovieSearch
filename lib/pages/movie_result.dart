import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webdata/pages/details.dart';
import 'package:webdata/utils/constants.dart';
import 'package:toast/toast.dart';
import 'dart:convert';

class MovieResult extends StatefulWidget {
  static const String routeName = "/movie";
  MovieResult({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MovieResultState createState() => _MovieResultState();
}

class _MovieResultState extends State<MovieResult> {
  String url =
      "https://api.themoviedb.org/3/search/movie?api_key=<api_key>&query=";

  String img_url = "https://image.tmdb.org/t/p/w500/";
  List data;
  String name = Constants.prefs.getString("movie_name");

  // Function to get the JSON data
  Future<String> getJSONData() async {
    var response = await http.get(
        // Encode the url
        Uri.encodeFull(url + Constants.prefs.getString("movie_name")),
        // Only accept JSON response
        headers: {"Accept": "application/json"});

    setState(() {
      // Get the JSON data
      data = json.decode(response.body)['results'];
    });

    return "Successfull";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Result"),
      ),
      body: data == null
          ? Center(child: CircularProgressIndicator())
          : _buildListView(),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (context, index) {
          return _buildRow(data[index], index);
          // return _buildRow(data[index]);
        });
  }

  Widget _buildRow(dynamic item, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          item['original_title'] == null ? '' : item['original_title'],
        ),
        subtitle: Text(item['overview'] == ""
            ? 'No Description'
            : "Description: " + item['overview']),
        onTap: () {
          Constants.prefs.setString("id", item['id'].toString());
          Navigator.pushNamed(context, Details.routeName);
        },
        trailing: Image.network(
            item['poster_path'] == null ? "" : img_url + item['poster_path']),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Call the getJSONData() method when the app initializes
    this.getJSONData();
  }
}
