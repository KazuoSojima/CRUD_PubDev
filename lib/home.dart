import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var automovel = ['palio', 'corsa', 'gol', 'uno'];

  /*Map<String, dynamic> carros = {
    'id': '01',
    'modelo': 'palio',
    'placa': 'ASD1234',
    'chassi': '123456789',
  };*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Carros'),
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            onPressed: () {
              cadastrarCarro(context).then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Item $value salvo com sucesso'),
                    duration: const Duration(milliseconds: 2000),
                  ),
                );
              });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Future cadastrarCarro(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('cadastrar novo carro'),
            content: TextField(controller: controller),
            actions: [
              MaterialButton(
                elevation: 5.0,
                child: const Text('salvar'),
                onPressed: () {
                  Navigator.of(context).pop(controller.text.toString());
                },
              )
            ],
          );
        });
  }
}
