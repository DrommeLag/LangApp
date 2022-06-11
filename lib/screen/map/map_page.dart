import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: <Widget>[
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
                  label: 'Language'
              ),
            ],
          ),
          body: Container()),
      Image.asset('assets/images/ornament.png', fit: BoxFit.cover),
      Image.asset('assets/images/ukraine.png'),
    ],
    );
  }
}
