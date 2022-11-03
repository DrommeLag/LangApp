import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lang_app/core/database_service.dart';
import 'package:lang_app/models/article.dart';
import 'package:lang_app/models/article_tag.dart';
import 'package:lang_app/models/event_tag.dart';
import 'package:lang_app/pages/home/article_page.dart';
import 'package:lang_app/pages/home/event_page.dart';
import 'package:lang_app/pages/home/headline_article_widget.dart';
import 'package:lang_app/pages/home/headline_event_widget.dart';
import 'package:lang_app/pages/templates/gradients.dart';
import 'package:lang_app/pages/templates/material_push_template.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  var searchController = TextEditingController();

  final _textInputFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _textInputFocus.addListener(_toggleFocusInInput);

    for (var cat in ArticleCategory.values) {
      _listLoader(cat.index);
    }
  }

  @override
  void dispose() {
    _textInputFocus.removeListener(_toggleFocusInInput);
    super.dispose();
  }

  var _borderAsPadding = const EdgeInsets.all(1);
  _toggleFocusInInput() {
    if (_textInputFocus.hasFocus) {
      _borderAsPadding = const EdgeInsets.all(2);
    } else {
      _borderAsPadding = const EdgeInsets.all(1);
    }
    setState(() {});
  }

  Widget _tabBuilder(String label) {
    return Tab(
      text: label,
      height: 20,
    );
  }

  List<bool> isAll = List.filled(ArticleCategory.values.length, false);
  List<List<ArticleTag>> buffer =
      ArticleCategory.values.map((e) => <ArticleTag>[]).toList();
  List<ScrollController> controllers =
      ArticleCategory.values.map((_) => ScrollController()).toList();

  void _listLoader(int index) async {
    if (!isAll[index]) {
      int lastLen = buffer[index].length;
      await DatabaseService()
          .getRecentArticleTagByCategory(ArticleCategory.values[index],
              buffer[index].lastOrNull?.publishing)
          .then((value) => buffer[index].addAll(value));
      if (buffer[index].length - lastLen != 10) {
        isAll[index] = true;
      }

      setState(() {});
    }
  }

  bool _handleScrollNotification(ScrollNotification notification, int index) {
    if (notification is ScrollEndNotification) {
      if (controllers[index].position.extentAfter == 0) {
        _listLoader(index);
      }
    }
    return false;
  }

  Widget _generatePage(List<Widget> children, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: NotificationListener<ScrollNotification>(
          onNotification: (notification) =>
              _handleScrollNotification(notification, index),
          child: ListView(
            controller: controllers[index],
            children: [
              ...children,
              if (!isAll[index])
                Container(
                    alignment: Alignment.center,
                    height: 80,
                    child: const CircularProgressIndicator())
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    var containerBorder = const BorderRadius.all(Radius.circular(10));

    return DefaultTabController(
      length: ArticleCategory.values.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  //Background upper decor
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: backgroundGradient,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(10)),
                      ),
                      height: 75,
                    ),
                  ),

                  //TextField
                  //Border
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: searchbarGradient,
                      borderRadius: containerBorder,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          margin: _borderAsPadding,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: containerBorder,
                          ),
                        ),

                        //TextField itself
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            controller: searchController,
                            style: Theme.of(context).textTheme.titleMedium,
                            focusNode: _textInputFocus,
                            decoration: InputDecoration(
                              hintText: "Whats new?",
                              hintStyle: Theme.of(context)
                                  .inputDecorationTheme
                                  .hintStyle,
                              isDense: true,
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: containerBorder,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //Categories
              TabBar(
                tabs: ArticleCategory.values
                    .map((e) => _tabBuilder(e.name))
                    .toList(),
                isScrollable: true,
                labelStyle: Theme.of(context).textTheme.bodyLarge,
                labelColor: Theme.of(context).colorScheme.primary,
                indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: Colors.yellow,
                    ),
                    insets: EdgeInsets.symmetric(horizontal: 20)),
              ),
            ],
          ),
        ),
        body:
            //Upper decor and searchbar

            //Body
            TabBarView(
          children: [
            _generatePage(
                buffer[0].map((a) => ArticleWidget(() {
                      materialPushPage(context, ArticlePage(a));
                    }, a)).toList(),
                0),
            _generatePage(
                buffer[1].map((a) => EventWidget(() {
                      materialPushPage(context, EventPage(a as EventTag));
                    }, a as EventTag)).toList(),
                1),
            _generatePage(
                buffer[2].map((a) => ArticleWidget(() {
                      materialPushPage(context, ArticlePage(a));
                    }, a)).toList(),
                2),
            _generatePage(
                buffer[3].map((a) => ArticleWidget(() {
                      materialPushPage(context, ArticlePage(a));
                    }, a)).toList(),
                3),
            _generatePage(
                buffer[4].map((a) => ArticleWidget(() {
                      materialPushPage(context, ArticlePage(a));
                    }, a)).toList(),
                4),
          ],

          //  ArticleCategory.values
          //     .map(
          //       (e) => Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 30),
          //         child: NotificationListener<ScrollNotification>(
          //             onNotification: (notification) =>
          //                 _handleScrollNotification(notification, e),
          //             child: ListView(
          //               controller: controllers[e.index],
          //               children: [
          //                 ...(buffer[e.index].map((a) => ArticleWidget(() {
          //                       materialPushPage(
          //                           context, ArticlePage(id: a.id!));
          //                     }, a))),
          //                 if (!isAll[e.index])
          //                   Container(
          //                     alignment: Alignment.center,
          //                       height: 80, child: const CircularProgressIndicator())
          //               ],
          //             )),
          //       ),
          //     )
          //     .toList(),
        ),
      ),
    );
  }
}
