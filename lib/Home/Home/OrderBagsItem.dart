import 'package:flutter/material.dart';

class OrderBagsItem extends StatelessWidget {
  final int bagCount;

  OrderBagsItem(this.bagCount);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width * 0.7,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]), color: Colors.green),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
          ),
          Image(
              height: screenSize.width * 0.15,
              image: AssetImage('assets/images/bag.png')),
          SizedBox(
            width: screenSize.width * 0.3,
          ),
          Text(
            '$bagCount',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
