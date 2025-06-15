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
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 1))
                        ]),
                  )),
                  SizedBox(height: 10),
                  Expanded(
                    child: Row(
                        children: [
                          Numpad(constraints: constraints),
                          SizedBox(width: 20),
                          ExtraButtons()
                        ]),
                  ),
                ],
              ));
        }));
  }
}

class Numpad extends StatelessWidget {
  const Numpad({super.key, required this.constraints});

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    var numpad = <Widget>[
      NumpadButton(text: "7"),
      NumpadButton(text: "8"),
      NumpadButton(text: "9"),
      NumpadButton(text: "4"),
      NumpadButton(text: "5"),
      NumpadButton(text: "6"),
      NumpadButton(text: "1"),
      NumpadButton(text: "2"),
      NumpadButton(text: "3"),
      NumpadButton(text: "."),
      NumpadButton(text: "0"),
      NumpadButton(text: "∠"),
    ];

    return SizedBox(
      width: constraints.maxHeight * 0.86,
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 2.5,
        shrinkWrap: true,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: numpad,
      ),
    );
  }
}

class ExtraButtons extends StatelessWidget {
  const ExtraButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(spacing: 10, children: [
          Expanded(child: NumpadButton(text: "+")),
          Expanded(child: NumpadButton(text: "-")),
          Expanded(child: NumpadButton(text: "i")),
        ]),
      ),
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
        backgroundColor: Theme.of(context).colorScheme.surface);
    final tstyle = TextStyle(fontSize: 30);
    return TextButton(
        onPressed: () {}, style: bstyle, child: Text(text, style: tstyle));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
