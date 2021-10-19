import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var automovel = ['palio', 'corsa', 'gol', 'uno'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Carros'),
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: automovel.length,
          itemBuilder: (context, int index) {
            return ListTile(
              title: Text(automovel[index]),
            );
          }),
    );
  }
}
