import 'package:flutter/material.dart';
import 'package:learn_movie_details_page/movie_api.dart';

import 'models.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MovieDetailsPage(movie: testMovie));
  }
}

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  MovieDetailsPage({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 300,
                child: FadeInImage.assetNetwork(
                    placeholder: "",
                    image:
                        "https://pmcvariety.files.wordpress.com/2013/07/the-secret-life-of-pets-3.jpg?w=1000&h=562&crop=1"),
              ),
              Padding(
                  padding: EdgeInsets.all(20),
                  child: MovieDetailsHeader(movie: movie))
            ],
          ),
        ),
      ),
    );
  }
}

class MovieDetailsHeader extends StatelessWidget {
  MovieDetailsHeader({this.movie});

  final Movie movie;

  List<Widget> _buildCategoryChips(TextTheme textTheme) {
    return ["Action", "Comedy"].map((category) {
      return Padding(
        padding: EdgeInsets.only(right: 8.0),
        child: Chip(
          label: Text(category),
          labelStyle: textTheme.caption,
          backgroundColor: Colors.black12,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var movieInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("Secret Life of Pets", style: textTheme.title),
        SizedBox(height: 8),

        /*rating*/
        Column(
          children: <Widget>[
            Text("8.0", style: textTheme.subtitle.copyWith(color: Colors.red)),
            Text("Ratings")
          ],
        ),
        SizedBox(height: 12),

        /*chips*/
        Row(
          children: _buildCategoryChips(textTheme),
        )
      ],
    );
    return Column(
      children: <Widget>[
        /*cover*/
        Row(
          children: <Widget>[
            SizedBox(
              height: 230,
              child: FadeInImage.assetNetwork(
                  placeholder: "",
                  image:
                      "https://upload.wikimedia.org/wikipedia/en/6/64/The_Secret_Life_of_Pets_poster.jpg"),
            ),
            SizedBox(width: 16),
            movieInfo
          ],
        ),
        SizedBox(height: 32),

        /*film description*/
        Column(
          children: <Widget>[
            Text("Store line", style: textTheme.subhead.copyWith(fontSize: 18)),
            SizedBox(height: 8),
            Text(
                "In a Manhattan apartment building, Max's life as a favorite pet is turned upside-down, when his owner brings home sloppy mongrel Duke. They must put their quarrels aside when they learn that adorable white bunny Snowball is building an army of lost pets determined to wreak revenge.")
          ],
        )
      ],
    );
  }
}
