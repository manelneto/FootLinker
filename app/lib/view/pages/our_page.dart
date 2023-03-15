import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OurPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> us = ["André Rodrigues", "Luiz Queiroz", "Manuel Neto", "Patrícia Sousa", "Rúben Fonseca"];

    return ListView(
      children: [
        const Padding(
            padding: EdgeInsets.all(20),
            child: Text('FootLinker foi desenvolvida por:'),
        ),
        for (var name in us)
          ListTile(
            leading: Icon(Icons.person),
            title: Text(name),
          ),
      ],
    );
  }
}