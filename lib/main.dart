import 'package:flutter/cupertino.dart';
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
  final heroImageHeight = 300.0;
  final Movie movie;

  MovieDetailsPage({Key key, this.movie}) : super(key: key);

  SizedBox buildHeroImage() {
    return SizedBox(
      height: heroImageHeight,
      child: FadeInImage.assetNetwork(
          fit: BoxFit.fitWidth,
          placeholder: "",
          image:
              "https://pmcvariety.files.wordpress.com/2013/07/the-secret-life-of-pets-3.jpg?w=1000&h=562&crop=1"),
    );
  }

  List<Widget> sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return [
      SliverAppBar(
          pinned: true, expandedHeight: 200, flexibleSpace: buildHeroImage())
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: sliverBuilder,
          body: Stack(
            children: <Widget>[
              Container(
                child: Padding(
                    padding: EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 20),
                    child: MovieDetailsHeader(movie: movie)),
              )
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
  final List<String> photos = List.generate(
      10,
      (int i) =>
          "https://upload.wikimedia.org/wikipedia/en/6/64/The_Secret_Life_of_Pets_poster.jpg");

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

  Widget itemBuilder(BuildContext context, int index) {
    String photoUrl = photos.elementAt(index);
    return new Padding(
        padding: EdgeInsets.only(right: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: Row(
            children: <Widget>[
              Image.asset(photoUrl, fit: BoxFit.cover),
              CupertinoAlertDialog(
                  title: Text("title"), content: Text(photos.elementAt(0)))
            ],
          ),
        ));
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
              child: Material(
                elevation: 8,
                child: FadeInImage.assetNetwork(
                    placeholder: "",
                    image:
                        "https://upload.wikimedia.org/wikipedia/en/6/64/The_Secret_Life_of_Pets_poster.jpg"),
              ),
            ),
            SizedBox(width: 16),
            movieInfo
          ],
        ),
        SizedBox(height: 32),

        /*film description*/
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Storyline",
              style: textTheme.subhead.copyWith(fontSize: 18),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 8),
            Text(
                "In a Manhattan apartment building, Max's life as a favorite pet is turned upside-down, when his owner brings home sloppy mongrel Duke. They must put their quarrels aside when they learn that adorable white bunny Snowball is building an army of lost pets determined to wreak revenge."),
            SizedBox(
              height: 100,
              child: (ListView.builder(
                itemCount: photos.length,
                itemBuilder: itemBuilder,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(8),
              )),
            )
          ],
        )
      ],
    );
  }
}
