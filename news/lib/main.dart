import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const LokalNewsApp());
  false;
}

class LokalNewsApp extends StatelessWidget {
  const LokalNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lokal News by Rudra',
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // splash screen animation
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const NewsScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // splash screen animation 2
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              'Lokal News by Rudra',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final String apiKey = '0ddedbe25a284afdaa9dab2c1f089d86';
  final String baseUrl = 'https://newsapi.org/v2/top-headlines';

  TextEditingController searchController = TextEditingController();
  String selectedCountry = 'in';
  List<NewsArticle> articles = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final url = Uri.parse('$baseUrl?country=$selectedCountry&apiKey=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      final articlesData = parsed['articles'] as List<dynamic>;
      setState(() {
        articles = articlesData.map((json) => NewsArticle.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokal News App', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.sentiment_satisfied_alt, color: Colors.black,), onPressed: () {

          },
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black,), onPressed: () {

          },
          ),
        ],
        shadowColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          )
        ),

      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search News Here',
                      icon: Icon(Icons.search),

                    ),
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedCountry,
                  onChanged: (value) {
                    setState(() {
                      selectedCountry = value!;
                    });
                    fetchNews();
                  },
                  items: <String>['us', 'gb', 'in', 'au','ru']
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value.toUpperCase(), style: const TextStyle(color: Colors.black),),
                    ),
                  )
                      .toList(),
                  icon: const Icon(Icons.arrow_drop_down_circle_outlined,),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return ListTile(
                  title: Text(article.title, style: const TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(article.description, style: const TextStyle(fontWeight: FontWeight.normal),),
                  onTap: () {
                            // on tap action will be here later
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NewsArticle {
  final String title;
  final String description;
  final String url;

  NewsArticle({
    required this.title,
    required this.description,
    required this.url,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
    );
  }
}

