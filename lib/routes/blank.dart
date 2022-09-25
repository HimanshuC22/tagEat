import 'package:flutter/material.dart';

class BlankPage extends StatefulWidget {
  const BlankPage({ Key? key }) : super(key: key);

  @override
  State<BlankPage> createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child:Icon(Icons.dinner_dining_outlined));
  }
}