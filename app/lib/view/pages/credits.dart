import 'package:flutter/material.dart';

class Credits extends StatelessWidget {
  const Credits({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> us = [
      "André Rodrigues",
      "Luiz Queiroz",
      "Manuel Neto",
      "Patrícia Sousa",
      "Rúben Fonseca"
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Créditos')),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text('FootLinker foi desenvolvida por:'),
          ),
          for (var name in us)
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(name),
            ),
        ],
      ),
    );
  }
}
