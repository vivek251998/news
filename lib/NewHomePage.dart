import 'package:flutter/material.dart';
import '../NewsService.dart';
import '../SearchView.dart';
import '../article_model.dart';
import 'NewsDetail.dart';
import 'package:get/get.dart';

class Newhomepage extends StatefulWidget {
  const Newhomepage({super.key});

  @override
  State<Newhomepage> createState() => _NewhomepageState();
}

class _NewhomepageState extends State<Newhomepage>
    with SingleTickerProviderStateMixin {
  final List<String> categories = [
    'All',
    'General',
    'Technology',
    'Sports',
    'Business',
    'Entertainment',
    'Science',
    'Health'
  ];
  late TabController _tabController;
  List<Article> articles = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
    _tabController.addListener(() {
      fetchNewsByCategory(categories[_tabController.index]);
    });
    fetchNewsByCategory('All');
  }

  Future<void> fetchNewsByCategory(String category) async {
    setState(() => isLoading = true);
    try {
      articles = category == 'All'
          ? await NewsService.fetchNewss()
          : await NewsService.fetchNews(category.toLowerCase(), 1);
    } catch (e) {
      print(e);
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("News Categories"),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Get.to(() => const SearchView()),
          ),
        ],
        bottom: TabBar(
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          controller: _tabController,
          tabs: categories.map((cat) => Tab(text: cat)).toList(),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NewsDetailPage(article: article),
                    ),
                  ),
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (article.urlToImage != null)
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(15)),
                            child: Image.network(article.urlToImage!,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article.title ?? 'No title',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                article.description ?? 'No description',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.watch_later_outlined,
                                    size: 14,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    article.publishedAt != null
                                        ? article.publishedAt!.split('T').first
                                        : '',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
