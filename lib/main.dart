import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const Cocalc());
}

class Cocalc extends StatelessWidget {
  const Cocalc({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solves system of linear equations involving complex numbers',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceDim,
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              spacing: 20,
              children: <Widget>[
                Expanded(
                  child: DataArea(),
                ),
                Expanded(
                  child: UserControls(),
                ),
              ],
            )));
  }
}

class UserControls extends StatelessWidget {
  const UserControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: 20, children: [
      Expanded(child: Numpad()),
      Align(
        alignment: Alignment.topLeft,
        child: Column(spacing: 10, children: [
          Expanded(child: NumpadButton(text: "frac")),
          Expanded(child: NumpadButton(text: "+")),
          Expanded(child: NumpadButton(text: "-")),
          Expanded(child: NumpadButton(text: "i")),
        ]),
      )
    ]);
  }
}

class Numpad extends StatelessWidget {
  const Numpad({super.key});

  @override
  Widget build(BuildContext context) {
    var numpad = <Widget>[
      Expanded(child: NumpadButton(text: "7")),
      Expanded(child: NumpadButton(text: "8")),
      Expanded(child: NumpadButton(text: "9")),
      Expanded(child: NumpadButton(text: "4")),
      Expanded(child: NumpadButton(text: "5")),
      Expanded(child: NumpadButton(text: "6")),
      Expanded(child: NumpadButton(text: "1")),
      Expanded(child: NumpadButton(text: "2")),
      Expanded(child: NumpadButton(text: "3")),
      Expanded(child: NumpadButton(text: ".")),
      Expanded(flex: 2, child: NumpadButton(text: "0")),
      Expanded(child: NumpadButton(text: "∠")),
    ];

    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: numpad.sublist(0, 3),
          ),
        ),
        Expanded(
          child: Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: numpad.sublist(3, 6),
          ),
        ),
        Expanded(
          child: Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: numpad.sublist(6, 9),
          ),
        ),
        Expanded(
            child: Row(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: numpad.sublist(9, 12))),
      ],
    );
  }
}

class NumpadButton extends StatelessWidget {
  final String text;

  const NumpadButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final bstyle = TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: Size.fromWidth(100),
        backgroundColor: Theme.of(context).colorScheme.surface);
    final tstyle = TextStyle(fontSize: 30);
    return TextButton(
        onPressed: () {}, style: bstyle, child: Text(text, style: tstyle));
  }
}

class DataArea extends StatefulWidget {
  const DataArea({super.key});

  @override
  State<DataArea> createState() => _DataArea();
}

class _DataArea extends State<DataArea> {
  var _varCount = 2;
  var _eqnCount = 2;

  void addVariable() {
    setState(() {
      _varCount++;
    });
  }

  void addEquation() {
    setState(() {
      _eqnCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          spacing: 30,
          children: [
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: addVariable,
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.purple.shade200,
                        foregroundColor: Colors.white),
                    child: Text("+ Add Variable")),
                TextButton(
                    onPressed: addEquation,
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blue.shade200,
                        foregroundColor: Colors.white),
                    child: Text("+ Add Equation")),
                TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.greenAccent.shade200,
                        foregroundColor: Colors.white),
                    child: Text("Solve"))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Table(
                  defaultColumnWidth: FixedColumnWidth(100),
                  children: List.generate(
                    max(_varCount, _eqnCount),
                    (index) => TableRow(
                      children: List.generate(
                        _varCount,
                        (index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

