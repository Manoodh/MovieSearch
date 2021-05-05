import 'package:flutter/material.dart';
import 'package:webdata/pages/movie_result.dart';
import 'package:webdata/pages/series_result.dart';
import 'package:webdata/pages/upcoming.dart';
import 'package:webdata/utils/constants.dart';
import 'package:toast/toast.dart';

class MoviePage extends StatefulWidget {
  static const String routeName = "/moviesearch";
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final formKey = GlobalKey<FormState>();
  final _movienameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Movie"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _movienameController,
                        keyboardType: TextInputType.emailAddress,
                        // validator: (s) {},
                        decoration: InputDecoration(
                            hintText: "Enter Movie name",
                            labelText: "Search Movie"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Constants.prefs.setString(
                              "movie_name", _movienameController.text);
                          Toast.show(_movienameController.text, context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                          Navigator.pushNamed(context, MovieResult.routeName);
                        },
                        child: Text("Search Movie"),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Constants.prefs.setString(
                                "movie_name", _movienameController.text);
                            Toast.show(_movienameController.text, context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM);
                            Navigator.pushNamed(
                                context, SeriesResult.routeName);
                          },
                          child: Text("Search TV Show")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Upcoming.routeName);
                          },
                          child: Text("Upcoming Movies "))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
