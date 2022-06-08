import 'package:flutter/material.dart';
import 'package:lang_app/core/inherit_provider.dart';
import 'package:lang_app/models/test.dart';
import 'package:lang_app/screen/levels/test/test_holder.dart';

class LevelPage extends StatefulWidget {
  const LevelPage({Key? key}) : super(key: key);

  @override
  State<LevelPage> createState() => _LevelPage();
}

class _LevelPage extends State<LevelPage> {
  late Widget page;

  List<Test> testList = <Test>[];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (testList.isEmpty) {
      _loadTests();
    }
    _updatePage();
  }

  _loadTests() async {
    testList =
        (await InheritedDataProvider.of(context)!.databaseService.getTests())
            .toList();
    _updatePage();
  }

  _updatePage() {
    setState(() {
      if (testList.isEmpty) {
        page = const CircularProgressIndicator();
      } else {
        page = _buildLevelsList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: page);
  }

  Widget _buildLevelsList() {
    return ListView.builder(
      itemCount: testList.length,
      itemBuilder: (context, index) {
        return MaterialButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return TestHolder(test: testList[index]);
            }));
          },
          child: Text(testList[index].name),
          color: Colors.orangeAccent,
        );
      },
    );
  }
}
