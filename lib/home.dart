import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var automovel = ['palio', 'corsa', 'gol', 'uno'];
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Carros'),
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            onPressed: () {
              cadastrarCarro(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: automovel.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(automovel[index]),
              trailing: Wrap(
                spacing: 15, // space between two icons
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.black45,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red[300],
                    onPressed: () {
                      removerItem();
                    },
                  ),
                ],
              ),
              onLongPress: editarItem(),
            );
          }),
    );
  }

  Future cadastrarCarro(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('cadastrar novo carro'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'ex. Fusca',
              ),
            ),
            actions: [
              MaterialButton(
                elevation: 5.0,
                child: const Text('salvar'),
                onPressed: () {
                  var input = controller.text;
                  if (input == '') {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pop(controller.text.toString());
                    addToList();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Item $input salvo com sucesso'),
                        duration: const Duration(milliseconds: 2000),
                      ),
                    );
                  }
                },
              )
            ],
          );
        });
  }

  addToList() {
    setState(() {
      automovel.add(controller.text);
      controller.text = "";
    });
  }

  editarItem() {}

  removerItem() {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('deseja mesmo remover $controller.text da lista?'),
            actions: [
              Row(
                children: [
                  MaterialButton(
                    elevation: 5.0,
                    child: const Text('sim'),
                    onPressed: () {},
                  ),
                  MaterialButton(
                    elevation: 5.0,
                    child: const Text('não'),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          );
        });
  }
}
