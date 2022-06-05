import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lang_app/core/database.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget{
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPage();

}

class _NewsPage extends State<NewsPage>{
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseService().newsCollection.snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return Text("Завантаження...");
        return Center(
          child: _buildList(snapshot.data!),
        );
      },
    );
  }

  Widget _buildList(QuerySnapshot snapshot){
    return ListView.builder(
      itemCount: snapshot.docs.length,
      itemBuilder: (context, index){
        final doc = snapshot.docs[index];
        return ListTile(
          title: Text(doc['title']),
          subtitle: Text(doc['subtitle']),
          leading: Icon(Icons.new_releases_sharp),
          onTap: () async{
            await launchUrl(Uri.parse(doc['url']));
          },
        );
      },
    );
  }
}