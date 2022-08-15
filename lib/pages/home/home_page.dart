import 'package:flutter/material.dart';
import 'package:lang_app/core/database.dart';
import 'package:lang_app/models/news.dart';
import 'package:lang_app/pages/templates/gradients.dart';
import 'package:lang_app/pages/templates/input_text_field.dart';

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
    return Tab(text: label);
  }

  @override
  Widget build(BuildContext context) {
    var containerBorder = BorderRadius.all(Radius.circular(10));

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
                labelStyle: Theme.of(context).textTheme.headline6,
                labelColor: Colors.black,
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: Colors.yellow,
                    ),
                    insets: EdgeInsets.symmetric(horizontal: 15)),
              ),
            ],
          ),
        ),
        body:
            //Upper decor and searchbar

            //Body
            TabBarView(
          children: widget.categories.map((e) => Text(e)).toList(),
        ),
      ),
    );
  }
}
