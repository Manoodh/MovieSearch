import 'package:flutter/material.dart';
import 'package:webdata/pages/details.dart';
import 'package:webdata/pages/movie_page.dart';
import 'package:webdata/pages/movie_result.dart';
import 'package:webdata/pages/series_details.dart';
import 'package:webdata/pages/series_result.dart';
import 'package:webdata/pages/upcoming.dart';
import 'package:webdata/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MoviePage(),
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      routes: {
        MovieResult.routeName: (context) => MovieResult(),
        MoviePage.routeName: (context) => MoviePage(),
        Details.routeName: (context) => Details(),
        SeriesResult.routeName: (context) => SeriesResult(),
        SeriesDetails.routeName: (context) => SeriesDetails(),
        Upcoming.routeName: (context) => Upcoming(),
      },
    );
  }
}
