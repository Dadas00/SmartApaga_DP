import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton(
              onPressed: null,
              child:
                  Text('Terms of Use', style: TextStyle(color: Colors.black))),
          Container(height: 15, child: VerticalDivider(color: Colors.black)),
          TextButton(
            onPressed: null,
            child:
                Text('Privacy Policy', style: TextStyle(color: Colors.black)),
          )
        ],
      ),
    );
  }
}
