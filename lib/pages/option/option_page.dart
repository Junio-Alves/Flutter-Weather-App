import 'package:flutter/material.dart';

class OptionPage extends StatefulWidget {
  const OptionPage({super.key});

  @override
  State<OptionPage> createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Options"),
      ),
      body: Column(
        children: [
          optionCard(text: "Selecionar Linguagem", navigator: () {}),
          optionCard(text: "Selecionar Tema", navigator: () {}),
          optionCard(text: "Unidade de Temperatura", navigator: () {}),
          optionCard(text: "Unidade de velocidade do vento ", navigator: () {}),
          optionCard(text: "Tipo de Hora", navigator: () {}),
          optionCard(text: "Notificações", navigator: () {}),
        ],
      ),
    );
  }
}

optionCard({required String text, required Function navigator}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(5)),
      child: InkWell(
        onTap: () {
          navigator;
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
