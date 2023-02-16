
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomMarker extends StatelessWidget {
  final String title;
  const CustomMarker({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      child:  Center(
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}



