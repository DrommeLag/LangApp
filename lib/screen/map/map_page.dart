import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
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
                      setState(() {});
                    },
                  ),
                ],
              ),
              body: Container()),
          Align(
              alignment: Alignment.center,
              child: Image.asset('assets/images/ukraine.png')),
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
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Theme.of(context).colorScheme.shadow,
                          ),
                          alignment: Alignment.center,
                        ),
                        buildTile(context),
                      ],
                    ),
                  );
                },
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    buildTile(context),
                    buildTile(context),
                    buildTile(context),
                    buildTile(context),
                    buildTile(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
