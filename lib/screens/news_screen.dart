import 'package:flutter/material.dart';
import 'package:flutter_news/models/product.dart';

import '../widgets/news_item.dart';

import '../widgets/getDataFromAPI.dart';

class NewsScreen extends StatefulWidget {
  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  
  Future<Product?> upload = HttpResponse().getData();

  List<Article> array = [];
  List<Article> arrayForDisplay = [];


  @override
  void initState() {
    upload.then((value) {
      setState(() {
        array.addAll(value!.articles);
        arrayForDisplay = array;
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: arrayForDisplay.length + 1,
        itemBuilder: (ctx, i) {
          return i == 0 ? _searchBar() : NewsItem(arrayForDisplay[i - 1]);
        },
      ),
    );
  }


  _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      child: TextField(
        decoration: new InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: "Пошук...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            arrayForDisplay = array.where((el) {
              var elTitle = el.title.toLowerCase();
              return elTitle.contains(text);
            }).toList();
          });
        },
      ),
    );
  }
}
