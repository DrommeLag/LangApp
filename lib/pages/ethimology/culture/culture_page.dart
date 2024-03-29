import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lang_app/core/database.dart';
import 'package:lang_app/models/card.dart';
import 'package:lang_app/models/view_point.dart';
import 'package:lang_app/pages/templates/region_map.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CulturePage extends StatefulWidget {
  const CulturePage({Key? key, required this.selected}) : super(key: key);
  final String selected;

  @override
  State<CulturePage> createState() => _CulturePageState();
}

class _CulturePageState extends State<CulturePage> {

  List<int> ids = [];
  List<ViewPoint> viewPoints = [];
  bool loaded = false;

  loadData() async {
    log(widget.selected);

    // TODO: Це костиль, який треба буде пофіксати якщо буде можливість догружати дані
    if (viewPoints.isEmpty) {
      await DatabaseService()
          .getViewPointsByRegion(widget.selected)
          .then((value) async{
        ids = value.items.cast<int>();
        for (int id in ids) {
          await DatabaseService()
              .getViewPoint(id)
              .then((value) => viewPoints.add(value));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context)!;

    return FutureBuilder(
      future: loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && viewPoints.isNotEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: Text(regionMap[widget.selected]!),
            ),
            body: Center(
              child: Scrollbar(
                thumbVisibility: true,
                thickness: 10,
                child: ListView.builder(
                  itemCount: viewPoints.length,
                  itemBuilder: (context, index) {
                    return StyledCard(
                        viewPoints[index].name, viewPoints[index].description,
                        viewPoints[index].img);
                  },
                ),
              ),
            )
        );}
        else if (snapshot.connectionState == ConnectionState.done && viewPoints.isEmpty){
          return Scaffold(
            appBar: AppBar(
              title: Text(regionMap[widget.selected]!),
            ),
            body: Center(
              child: Text("${local.mapNoData} ${regionMap[widget.selected]}",
                style: const TextStyle(
                  fontSize: 30,),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        else {
          return Scaffold(
            appBar: AppBar(
              title: Text(regionMap[widget.selected]!),
            ),
            body: Center(child:
              Text(local.loading , style: TextStyle(
                fontSize: 30,
              ),),
            ),
          );
        }
      },
    );
  }
}
