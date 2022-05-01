import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget{
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePage();

}

class _FavoritePage extends State<FavoritePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Scaffold(
      body: Center(
        child: Text("TODO !!!", style: TextStyle(fontSize: 50),),
      ),
    );
  }

}