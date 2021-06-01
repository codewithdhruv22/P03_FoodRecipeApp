import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                    Color(0xff213A50),
                  Color(0xff071938)
                ]
              ),
            ),
          ),
          SafeArea(child: Text("HELLO I AM HOME PAGE", style: TextStyle(color: Colors.white),))
        ],
      ),
    );
  }
}
