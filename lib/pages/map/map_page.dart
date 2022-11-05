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

  Widget buildTile(context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
          ),
        ),
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
                buttonSize: 56.0,
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
              body: Container()),
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                  ),
                  width: 400,
                  height: 260,
                  child: Image.asset('assets/images/ukraine.png'),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 10,
                  left: 55,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "ltsk");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 30,
                  left: 80,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "rvn");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 55,
                  left: 35,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "lviv");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 55,
                  left: 70,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "trpl");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 75,
                  left: 55,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "ivnfr");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 100,
                  left: 20,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "uzhg");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 100,
                  left: 80,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "chernivtsi");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 70,
                  left: 100,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "khml");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 30,
                  left: 130,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "zhtmr");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 90,
                  left: 135,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "vinnytsia");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 70,
                  left: 160,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "chrks");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 40,
                  left: 170,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "kyiv");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 5,
                  left: 185,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "chrngv");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 20,
                  left: 230,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "sumy");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 60,
                  left: 215,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "pltv");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 90,
                  left: 190,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "krpvnts");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 130,
                  left: 180,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "mklv");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 170,
                  left: 145,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "odss");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 150,
                  left: 220,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "khrsn");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 185,
                  left: 245,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "smphrpl");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 135,
                  left: 260,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "zprzh");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 95,
                  left: 255,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "dnpr");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 55,
                  left: 260,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "khrkv");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 70,
                  left: 310,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "lhnsk");
                      log(selected);
                    },
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 110,
                  left: 300,
                  child: StyledIconButton(
                    onPressed: () {
                      setState(() => selected = "dntsk");
                      log(selected);
                    },
                  ),
                ),
              ]
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.all(10),
              constraints: const BoxConstraints(
                  maxWidth: 120, minWidth: 90, minHeight: 80),
              child: ExpansionWidget(
                titleBuilder: (double animationValue, _, bool isExpanded,
                    toggleFunction) {
                  return InkWell(
                    onTap: () => toggleFunction(animated: true),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Transform.rotate(
                          angle: 3.14 * animationValue / 2,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Theme.of(context).colorScheme.shadow,
                          ),
                        ),
                        buildTile(context),
                      ],
                    ),
                  );
                },
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  // children: [
                  //   buildTile(context),
                  //   buildTile(context),
                  //   buildTile(context),
                  //   buildTile(context),
                  //   buildTile(context),
                  // ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
