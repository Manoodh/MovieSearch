import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webdata/utils/constants.dart';
import 'package:toast/toast.dart';
import 'dart:convert';

class SeriesDetails extends StatefulWidget {
  final String id;

  SeriesDetails({Key key, @required this.id}) : super(key: key);
  static const String routeName = "/series_details";

  @override
  _SeriesDetailsState createState() => _SeriesDetailsState();
}

class _SeriesDetailsState extends State<SeriesDetails> {
  Map<String, dynamic> data;

  var url = "https://api.themoviedb.org/3/tv/";

  String apikey = "?api_key=7f5bf5e052db433d02faf6fda2da2547";

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

  // Widget _buildListView() {
  //   return ListView.builder(
  //       padding: const EdgeInsets.all(16.0),
  //       itemCount: seasons == null ? 0 : seasons.length,
  //       itemBuilder: (context, index) {
  //         return _buildRow(seasons[index], index);
  //         // return _buildRow(data[index]);
  //       });
  // }

  // Widget _buildRow(dynamic item, int index) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: ListTile(
  //       title: Text(
  //         item['air_date'] == null ? '' : item['air_date'],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Series"),
      ),
      body: data == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.network(imgurl + data['poster_path']),
                    Text(
                        data['original_name'] == null
                            ? ''
                            : data['original_name'],
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Status : " + data['status'].toString()),
                    Text("No. of Seasons : " +
                        data['number_of_seasons'].toString()),
                    Text("No. of Episodes : " +
                        data['number_of_episodes'].toString()),
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
