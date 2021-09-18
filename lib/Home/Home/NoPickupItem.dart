import 'package:flutter/material.dart';

class NoPickupItem extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[300])),
      child:Column(
        children: [
          SizedBox(height: 20,),
          Text('You Have No Pickup', style: TextStyle(fontSize: 24),),
          SizedBox(height: 20,),
          Image(
            height: screenSize.width * 0.5,
            image: AssetImage('assets/images/sad_man2.png')
          ),              
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}