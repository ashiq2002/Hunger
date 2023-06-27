import 'package:flutter/material.dart';

import '../../../model/donut_model.dart';
import '../component/donut_tile.dart';

class DonutTab extends StatelessWidget {
  const DonutTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DonutModel> donuts =[
      DonutModel(
          donutFlavor: 'Ice Cream',
          donutPrice: 67,
          donutColor: Colors.blue,
          imagePath: 'assets/images/chocolate_donut.png'),
      DonutModel(
          donutFlavor: 'Strawberry',
          donutPrice: 55,
          donutColor: Colors.red,
          imagePath: 'assets/images/strawberry_donut.png'),
      DonutModel(
          donutFlavor: 'Grape Ape',
          donutPrice: 84,
          donutColor: Colors.purple,
          imagePath: 'assets/images/grape_donut.png'),
      DonutModel(
          donutFlavor: 'Coco',
          donutPrice: 45,
          donutColor: Colors.brown,
          imagePath: 'assets/images/chocolate_donut.png')
    ];
    return  Scaffold(
      body: GridView.builder(
          padding: const EdgeInsets.all(8),

          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1/1.8
          ),
          itemCount: donuts.length,

          itemBuilder: (context, index)=> DonutTile(
              donutModel: donuts[index]
          )
      ),
    );
  }
}
