import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  Widget buildTile(context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/attractions.png'),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Stack(
        children: [
          Scaffold(
              floatingActionButton: SpeedDial(
                icon: Icons.menu,
                activeIcon: Icons.close,
                backgroundColor: const Color(0xff0068C9),
                foregroundColor: Colors.white,
                activeBackgroundColor: const Color(0xFFF2D84F),
                activeForegroundColor: Colors.white,
                buttonSize: 56.0,
                visible: true,
                closeManually: false,
                curve: Curves.bounceIn,
                overlayColor: Colors.black,
                overlayOpacity: 0.5,
                children: [
                  SpeedDialChild(
                      //speed dial child
                      child: const Icon(Icons.accessibility),
                      label: 'Language'),
                ],
              ),
              body: Container()),
          Image.asset('assets/images/ornament.png', fit: BoxFit.cover),
          Image.asset('assets/images/ukraine.png'),
          ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: 120, minWidth: 90, minHeight: 80),
            child: ExpansionWidget(
              titleBuilder:
                  (double animationValue, _, bool isExpaned, toogleFunction) {
                return InkWell(
                    onTap: () => toogleFunction(animated: true),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Transform.rotate(
                            angle: 3.14 * animationValue / 2,
                            child: Icon(Icons.arrow_right, size: 40),
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
        ],
      ),
    );
  }
}
