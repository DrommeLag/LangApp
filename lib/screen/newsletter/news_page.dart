import 'package:flutter/material.dart';
import 'package:lang_app/core/database.dart';
import 'package:lang_app/models/news.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPage();
}

class _NewsPage extends State<NewsPage> {
  List<News> news = [];

  late Widget page;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (news.isEmpty) {
      _loadNews();
    }
    _updatePage();
  }

  _loadNews() async {
    news = await DatabaseService() 
        .getAllNews()
        .then((value) => value.toList());
    _updatePage();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: page);
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(news[index].title),
          subtitle: Text(news[index].subtitle),
          leading: const Icon(Icons.new_releases_sharp),
          onTap: () async {
            await launchUrl(Uri.parse(news[index].url));
          },
        );
      },
    );
  }

  void _updatePage() {
    setState(() {
      if (news.isEmpty) {
        page = const CircularProgressIndicator();
      } else {
        page = _buildList();
      }
    });
  }
}
