import 'package:flutter/material.dart';
import 'package:flutter_news/models/product.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsItem extends StatelessWidget {
  final Article articles;
  NewsItem(this.articles);

  _launchURL() async {
    var url = articles.url;
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            child: Visibility(
              child: Image.network(
                articles.urlToImage ?? '',
                height: 175,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              visible: articles.urlToImage != null,
            ),
          ),
          Padding(padding: EdgeInsets.all(5)),
          ListTile(
            contentPadding: EdgeInsets.all(1),
            leading: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: CircleAvatar(
                backgroundColor: Colors.blue, //передаємо наші кольори
                radius: 10,
              ),
            ),
            title: Text(
              articles.title, //назва Новини
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                articles.source.name, //назва Новини
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            trailing: Container(
              width: 85,
              child: Row(children: [
                Text(
                  DateFormat.Hm().format(articles.publishedAt),
                ),
                IconButton(
                  onPressed: _launchURL,
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(
              articles.description,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
