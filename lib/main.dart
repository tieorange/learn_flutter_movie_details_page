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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            MovieDetailsHeader(movie: movie),
            Padding(padding: EdgeInsets.all(20))
          ],
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Row(
          children: _buildCategoryChips(textTheme),
        )
      ],
    );
    return Container(
      child: movieInfo,
    );
  }
}
