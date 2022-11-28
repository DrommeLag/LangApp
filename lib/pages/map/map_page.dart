import 'dart:developer';

import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:lang_app/pages/ethimology/culture/culture_page.dart';
import 'package:lang_app/pages/templates/material_push_template.dart';
import 'package:lang_app/pages/templates/styled_icon_button.dart';
import 'package:lang_app/pages/templates/toast_error_message.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  String selected = "def";

  String language = "assets/images/language.png";
  String culture = "assets/images/culture.png";
  String attractions = "assets/images/attractions.png";
  String imagePath = "assets/images/language.png";

  Widget buildMarker(top, left, region) {
    return Positioned(
      top: top,
      left: left,
      child: StyledIconButton(
        selected: (selected == region),
        onPressed: () {
          setState(() => selected = region);
          log(selected);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Stack(
        children: [
          Scaffold(
              floatingActionButton: SpeedDial(
                icon: Icons.menu,
                activeIcon: Icons.close,
                backgroundColor: const Color(0xff0068C9),
                foregroundColor: Colors.white,
                activeBackgroundColor: const Color(0xFFF2D84F),
                activeForegroundColor: Colors.black,
                buttonSize: const Size.square(56),
                visible: true,
                closeManually: false,
                curve: Curves.bounceIn,
                overlayColor: Colors.black,
                overlayOpacity: 0.5,
                children: [
                  SpeedDialChild(
                    child: const Icon(Icons.language_rounded),
                    backgroundColor: const Color(0xFFF2D84F),
                    foregroundColor: Colors.black,
                    label: 'Мова',
                    onTap: () {
                      if (imagePath == attractions) {
                        imagePath = language;
                      } else if (imagePath == culture) {
                        imagePath = language;
                      } else {
                        imagePath = language;
                      }
                      setState(() {});
                    },
                  ),
                  SpeedDialChild(
                    child: const Icon(Icons.people_outline_rounded),
                    backgroundColor: const Color(0xFFF2D84F),
                    foregroundColor: Colors.black,
                    label: 'Культура',
                    onTap: () {
                      if (imagePath == attractions) {
                        imagePath = culture;
                      } else if (imagePath == language) {
                        imagePath = culture;
                      } else {
                        imagePath = culture;
                      }
                      setState(() {});
                    },
                  ),
                  SpeedDialChild(
                    child: const Icon(Icons.location_on_outlined),
                    backgroundColor: const Color(0xFFF2D84F),
                    foregroundColor: Colors.black,
                    label: "Пам'ятки",
                    onTap: () {
                      if (imagePath == culture) {
                        imagePath = attractions;
                      } else if (imagePath == culture) {
                        imagePath = attractions;
                      } else {
                        imagePath = attractions;
                      }
                      if (selected == "def") {
                        showToastErrorMessage("Оберіть регіон на карті.");
                      }
                      else {
                        materialPushPage(context, CulturePage(selected: selected));
                      }
                      setState(() {});
                    },
                  ),
                ],
              ),
              body: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurface,
                  image: DecorationImage(
                    image: const AssetImage("assets/images/ornament.png"),
                    alignment: Alignment.centerRight,
                    colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary.withOpacity(0.5), BlendMode.srcOut),
                  ),
                ),
              ),
          ),
          Positioned(
            top: 20,
            left: 5,
            child: Row(children: [
              Image.asset("assets/images/ua_girl.png"),
              Text(
                  (selected == "def")
                      ? "Ви не обрали жодного регіону."
                      : "Ви обрали $selected",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  width: 400,
                  height: 260,
                  child: Image.asset('assets/images/ukraine.png'),
                ),
                buildMarker(10.0, 55.0, "lutsk"),
                buildMarker(30.0, 80.0, "rivne"),
                buildMarker(55.0, 35.0, "lviv"),
                buildMarker(55.0, 70.0, "ternopil"),
                buildMarker(75.0, 55.0, "ivano-frankivsk"),
                buildMarker(100.0, 20.0, "uzhgorod"),
                buildMarker(100.0, 80.0, "chernivtsi"),
                buildMarker(70.0, 100.0, "khmelnitskiy"),
                buildMarker(30.0, 130.0, "zhytomir"),
                buildMarker(90.0, 135.0, "vinnytsia"),
                buildMarker(70.0, 160.0, "cherkasy"),
                buildMarker(40.0, 170.0, "kyiv"),
                buildMarker(5.0, 185.0, "chernigiv"),
                buildMarker(20.0, 230.0, "sumy"),
                buildMarker(60.0, 215.0, "poltava"),
                buildMarker(90.0, 190.0, "kropyvnitskiy"),
                buildMarker(130.0, 180.0, "mykolaiv"),
                buildMarker(170.0, 145.0, "odessa"),
                buildMarker(150.0, 220.0, "kherson"),
                buildMarker(185.0, 245.0, "sympheropol"),
                buildMarker(135.0, 260.0, "zaporizhzhya"),
                buildMarker(95.0, 255.0, "dnipro"),
                buildMarker(55.0, 260.0, "kharkiv"),
                buildMarker(70.0, 310.0, "luhansk"),
                buildMarker(110.0, 300.0, "donetsk"),
              ]
            ),
          ),
        ],
      ),
    );
  }
}
