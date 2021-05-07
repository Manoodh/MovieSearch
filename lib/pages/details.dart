import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webdata/utils/constants.dart';
import 'package:toast/toast.dart';
import 'dart:convert';

class Details extends StatefulWidget {
  final String id;

  Details({Key key, @required this.id}) : super(key: key);
  static const String routeName = "/details";

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Map<String, dynamic> data;

  var url = "https://api.themoviedb.org/3/movie/";

  String apikey = "?<api_key>";

  String imgurl = "https://image.tmdb.org/t/p/w500/";
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url + Constants.prefs.getString("id") + apikey);
    data = jsonDecode(res.body);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie"),
      ),
      body: data == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.network(imgurl + data['poster_path']),
                    Text(data['original_title'].toString(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Status : " + data['status'].toString()),
                    Text("Release data : " + data['release_date'].toString()),
                    Text("Revenue: " + data['revenue'].toString() + "\$"),
                    Text("Vote Average: " +
                        data['vote_average'].toString() +
                        "/10"),
                    Text("Description : " + data['overview'].toString()),
                  ],
                ),
              ),
            ),
      //data == null
      //     ? Center(child: CircularProgressIndicator())
      //     : _buildListView(),
    );
  }
}
