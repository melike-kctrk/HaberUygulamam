import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:haberuygulamam/Data/news_service.dart';
import 'package:haberuygulamam/models/article.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haberler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Haberler'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Articles> articles = [];

  @override
  void initState() {
    NewsService.getNews().then((value) {
      setState(() {
        articles = value ?? [];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedTextKit(
          animatedTexts: [
            ScaleAnimatedText(
              widget.title,
              textStyle: TextStyle(fontSize: 40.0),
              duration: Duration(milliseconds: 2000),
            ),
          ],
          repeatForever: true,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  Image.network(articles[index].urlToImage ?? ''),
                  ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(horizontal: 4),
                    leading: Image.asset(
                      'images/images.jpg',
                      fit: BoxFit.cover,
                    ),
                    title: ListTile(
                      title: Text(articles[index].title ?? ''),
                      subtitle: Text(articles[index].author ?? ''),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(articles[index].description ?? ''),
                      ),
                    ],
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () async {
                            await launch(articles[index].url ?? '');
                          },
                          child: Text('Habere Git')),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
