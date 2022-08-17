import 'package:flutter/material.dart';
import 'package:lang_app/core/database_service.dart';
import 'package:lang_app/models/news.dart';
import 'package:lang_app/models/article.dart';
import 'package:lang_app/pages/home/article_page.dart';
import 'package:lang_app/pages/home/headline_article_widget.dart';
import 'package:lang_app/pages/templates/gradients.dart';
import 'package:lang_app/pages/templates/input_text_field.dart';
import 'package:lang_app/pages/templates/material_push_template.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  final categories = const [
    'For me',
    'Something',
    'Brands',
    'Media',
    'Sport',
  ];

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  var searchController = TextEditingController();

  var _textInputFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _textInputFocus.addListener(_toggleFocusInInput);
  }

  @override
  void dispose() {
    _textInputFocus.removeListener(_toggleFocusInInput);
    super.dispose();
  }

  var _borderAsPadding = EdgeInsets.all(1);
  _toggleFocusInInput() {
    if (_textInputFocus.hasFocus) {
      _borderAsPadding = EdgeInsets.all(2);
    } else {
      _borderAsPadding = EdgeInsets.all(1);
    }
    setState(() {});
  }

  Widget _tabBuilder(String label) {
    return Tab(
      text: label,
      height: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    var containerBorder = BorderRadius.all(Radius.circular(10));

    String filler =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

    String longDesc =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        + "\\img[https://www.verywellmind.com/thmb/yzwrx39kF66ZyCPi9RbkmwD8qP8=/800x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-172163714-56910a493df78cafda818537.jpg]"
        + "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        + "\\img[https://www.verywellmind.com/thmb/yzwrx39kF66ZyCPi9RbkmwD8qP8=/800x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-172163714-56910a493df78cafda818537.jpg]"
        +"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        + "\\img[https://www.verywellmind.com/thmb/yzwrx39kF66ZyCPi9RbkmwD8qP8=/800x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-172163714-56910a493df78cafda818537.jpg]"
        +"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        + "\\img[https://www.verywellmind.com/thmb/yzwrx39kF66ZyCPi9RbkmwD8qP8=/800x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-172163714-56910a493df78cafda818537.jpg]"
        +"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        + "\\img[https://www.verywellmind.com/thmb/yzwrx39kF66ZyCPi9RbkmwD8qP8=/800x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-172163714-56910a493df78cafda818537.jpg]";
    return DefaultTabController(
      length: widget.categories.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150),
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
                    margin: EdgeInsets.symmetric(horizontal: 30),
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
                          padding: EdgeInsets.symmetric(horizontal: 10),
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
                              contentPadding: EdgeInsets.all(10),
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
                tabs: widget.categories.map((e) => _tabBuilder(e)).toList(),
                isScrollable: true,
                labelStyle: Theme.of(context).textTheme.bodyLarge,
                labelColor: Theme.of(context).colorScheme.primary,
                indicator: UnderlineTabIndicator(
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
//TODO: rewrite on deployment. ONLY FOR TESTS
          children: widget.categories.map((e) {
            var article = Article(
              e,
              filler,
              const AssetImage("assets/tests/test.png"),
              () async => longDesc,
            );
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: ListView(
                children: List.filled(
                  5,
                  ArticleWidget(
                    () => materialPushPage(
                        context, ArticlePage(article: article)),
                    article,
                  ),
                ),
              ),
            );
          }).toList(),
//Up to here
        ),
      ),
    );
  }
}
