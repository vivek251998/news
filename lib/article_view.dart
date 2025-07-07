import 'package:flutter/material.dart';
import 'article_model.dart';
import 'package:url_launcher/url_launcher.dart';


class ArticleView extends StatelessWidget {
  final Article article;

  const ArticleView({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article.title!)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (article.urlToImage!.isNotEmpty)
              Image.network(article.urlToImage!, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(article.title!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(article.description!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => launchUrl(Uri.parse(article.url!)),
              child: const Text("Read Full Article"),
            )
          ],
        ),
      ),
    );
  }
}