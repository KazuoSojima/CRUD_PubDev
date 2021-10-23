import 'dart:convert';

import 'package:crud_pupdev/model/carros.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Carros> automovel = [];

  TextEditingController controller = TextEditingController();

  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Carros> result = decoded.map((x) => Carros.fromJson(x)).toList();
      setState(() {
        automovel = result;
      });
    }
  }

  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(automovel));
  }

  _HomeState() {
    load();
  }

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
              title: Text(automovel[index].carro),
              trailing: Wrap(
                spacing: 15,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.black45,
                    onPressed: () {
                      editarItem(index);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red[300],
                    onPressed: () {
                      removerItem(index);
                    },
                  ),
                ],
              ),
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
                    save();

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
      automovel.add(Carros(carro: controller.text));
      controller.clear();
    });
  }

  editarItem(int index) {
    var carro = automovel[index].carro;
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('deseja alterar $carro ?'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'ex. Fusca',
              ),
            ),
            actions: [
              Row(
                children: [
                  MaterialButton(
                    elevation: 5.0,
                    child: const Text('salvar'),
                    onPressed: () {
                      var input = controller.text;
                      if (input == '') {
                        Navigator.of(context).pop();
                      } else {
                        setState(() {
                          automovel[index].carro = controller.text;
                        });
                        //save();
                        controller.clear();
                        Navigator.of(context).pop();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Item $input salvo com sucesso'),
                            duration: const Duration(milliseconds: 2000),
                          ),
                        );
                      }
                    },
                  ),
                  MaterialButton(
                    elevation: 5.0,
                    child: const Text('não'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      controller.clear();
                    },
                  ),
                ],
              )
            ],
          );
        });
  }

  removerItem(int index) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text(
                'deseja mesmo remover ${automovel[index].carro} da lista?'),
            actions: [
              Row(
                children: [
                  MaterialButton(
                    elevation: 5.0,
                    child: const Text('sim'),
                    onPressed: () {
                      setState(() {
                        automovel.removeAt(index);
                        Navigator.of(context).pop();
                        save();
                      });
                    },
                  ),
                  MaterialButton(
                    elevation: 5.0,
                    child: const Text('não'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          );
        });
  }
}
