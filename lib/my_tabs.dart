import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTabs extends StatelessWidget {
  final Color color;
  final String text;
  const AppTabs({Key? key, required this.color, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only( left: 10),
      width: 120,
      height: 50,
      child: Text(
        this.text, style: TextStyle(color: Colors.white),
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: this.color,
        boxShadow:[ BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 7,
            offset: Offset(0, 0)
        )
        ],
      ),
    );
  }
}
