import 'package:flutter/material.dart';
import 'package:hunger/provider/cart_provider.dart';
import 'package:provider/provider.dart';

import '../../../model/donut_model.dart';

class DonutTile extends StatelessWidget {
  final DonutModel donutModel;
  const DonutTile({Key? key, required this.donutModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: donutModel.donutColor[50],
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            //donut price
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: donutModel.donutColor[800],
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
                  child: Text(
                    '\$${donutModel.donutPrice}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                )
              ],
            ),

            //donut image
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12),
              child: Image.asset(donutModel.imagePath),
            ),

            //donut flavor
            Text(
              donutModel.donutFlavor,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(
              height: 4,
            ),

            Text(
              'Dunkins',
              style: TextStyle(color: Colors.grey[600]),
            ),

            const SizedBox(
              height: 12,
            ),

            //love icon + add button
            Consumer<CartProvider>(builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //add to favorite
                    IconButton(
                      icon: const Icon(Icons.favorite),
                      color: Colors.pink[400],
                      onPressed: () {},
                    ),
                    //add to cart
                    IconButton(
                      icon: const Icon(Icons.add),
                      color: Colors.grey[800],
                      onPressed: () {//add item into cart item list
                        value.addToCart(donutModel);
                      },
                    )
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
