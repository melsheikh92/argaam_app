import 'package:argaam_app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ArticleScreen extends StatelessWidget {
  var article;

  ArticleScreen(@required this.article);

  var website = "https://www.argaam.com/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppTheme.primaryColor,
          actions: <Widget>[
            InkWell(
              onTap: () {
                Share.share(website);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
              ),
            )
          ],
          title: Text(
            "أرقام",
            style: TextStyle(
                fontFamily: "MainLogoFont",
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                decorationStyle: TextDecorationStyle.solid),
          ),
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .3,
              child: Image.network(
                this.article["url"],
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                this.article["body"],
                textDirection: TextDirection.rtl,
              ),
            )
          ],
        ));
  }
}
