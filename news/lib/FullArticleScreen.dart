import 'package:flutter/material.dart';

import 'main.dart';

class FullArticleScreen extends StatelessWidget {
  final NewsArticle article;

  const FullArticleScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Text(article.description),
        ),
      ),
    );
  }
}

class AnimatedNewsTile extends StatefulWidget {
  final NewsArticle article;

  AnimatedNewsTile({required this.article});

  @override
  _AnimatedNewsTileState createState() => _AnimatedNewsTileState();
}

class _AnimatedNewsTileState extends State<AnimatedNewsTile> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isHovered ? Colors.blue : Colors.white,
        boxShadow: [
          BoxShadow(
            color: isHovered ? Colors.blue.withOpacity(0.5) : Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // Navigate to the full article screen.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullArticleScreen(article: widget.article),
            ),
          );
        },
        onHover: (hover) {
          setState(() {
            isHovered = hover;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.article.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: isHovered ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              widget.article.description,
              style: TextStyle(
                fontSize: 16,
                color: isHovered ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}