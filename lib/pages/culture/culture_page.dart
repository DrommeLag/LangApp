import 'package:flutter/material.dart';
import 'package:lang_app/models/card.dart';

class CulturePage extends StatefulWidget {
  const CulturePage({Key? key}) : super(key: key);

  @override
  State<CulturePage> createState() => _CulturePageState();
}

class _CulturePageState extends State<CulturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Let it be Volyn"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return StyledCard("title", "description", "assets/images/culture_preview.png");
            // return Card(
            //   color: Theme.of(context).colorScheme.secondaryContainer,
            //   child: InkWell(
            //     splashColor: Colors.yellow[600],
            //     onTap: () {
            //       debugPrint('Card tapped.');
            //     },
            //     child: SizedBox(
            //       width: 50,
            //       height: 300,
            //       child: Center(
            //         child: Column(
            //           children: [
            //             Image.asset("assets/images/culture_preview.png"),
            //             Text('Some culture info', style: TextStyle(
            //               color: Theme.of(context).colorScheme.onSecondary,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 24,
            //             ),),
            //           ],
            //         )
            //       ),
            //     ),
            //   ),
            // );
          },
        ),
      ),
    );
  }
}
