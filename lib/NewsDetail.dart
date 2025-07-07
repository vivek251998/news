import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../article_model.dart';

class NewsDetailPage extends StatelessWidget {
  final Article article;

  const NewsDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article.author ?? 'News')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(article.urlToImage!,
                    width: double.infinity, height: 200, fit: BoxFit.cover),
              ),
            const SizedBox(height: 12),
            Text(
              article.title ?? '',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              article.content ?? article.description ?? 'No content available.',
              style: const TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => launchUrl(Uri.parse(article.url!)),
              child: Center(child: Text("Read Full NEWS")),
            )
          ],
        ),
      ),
    );
  }
}
