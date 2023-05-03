import 'package:flutter/material.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> us = [
      'André Rodrigues',
      'Luiz Queiroz',
      'Manuel Neto',
      'Patrícia Sousa',
      'Rúben Fonseca',
    ];

    return Scaffold(
      key: const Key('creditsPage'),
      appBar: AppBar(
        title: const Text(
          'Créditos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'FootLinker foi desenvolvida por:',
              style: TextStyle(fontSize: 20),
            ),
          ),
          for (var name in us)
            ListTile(
              leading: const Icon(
                Icons.person,
                size: 30,
              ),
              title: Text(
                name,
                style: const TextStyle(fontSize: 20),
              ),
            ),
        ],
      ),
    );
  }
}
