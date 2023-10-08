import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'algo_navigation.dart';
import 'bar_painter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> _numbers = [];
  double _sampleSize = 500;
  late StreamController<List<int>> _streamController;
  late Stream<List<int>> _stream;
  int val = 2500;
  String currentPage = "Bubble Sort";
  bool isVisualizing = false;
  TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _streamController = StreamController<List<int>>();
    _stream = _streamController.stream;
    _randomise();
  }

  _randomise() {
    _numbers = [];
    for (int i = 0; i < _sampleSize; ++i) {
      _numbers.add(Random().nextInt(500));
    }
    setState(() {
      isVisualizing = false;
    });
    _streamController.add(_numbers);
  }

  void handleClick(String value) {
    switch (value) {
      case 'Bubble Sort':
        setState(() {
          _randomise();
          isVisualizing = false;
          currentPage = value;
        });
        break;
      case 'Selection Sort':
        setState(() {
          _randomise();
          isVisualizing = false;
          currentPage = value;
        });
        break;
      case 'Insertion Sort':
        setState(() {
          _randomise();
          isVisualizing = false;
          currentPage = value;
        });
        break;
      case 'Merge Sort':
        setState(() {
          _randomise();
          isVisualizing = false;
          currentPage = value;
        });
        break;
      case 'Quick Sort':
        setState(() {
          _randomise();
          isVisualizing = false;
          currentPage = value;
        });
        break;
      case 'Heap Sort':
        setState(() {
          _randomise();
          isVisualizing = false;
          currentPage = value;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sorting Visualizer"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Bubble Sort',
                'Selection Sort',
                'Insertion Sort',
                'Merge Sort',
                'Quick Sort',
                'Heap Sort'
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
          PopupMenuButton<String>(
            // help
            itemBuilder: (BuildContext context) {
              return {'Help'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: _stream,
        builder: ((context, snapshot) {
          int counter = 0;

          return Row(
            children: _numbers.map((int number) {
              counter++;
              return CustomPaint(
                painter: BarPainter(
                  width: MediaQuery.of(context).size.width / _sampleSize,
                  value: number,
                  index: counter,
                ),
              );
            }).toList(),
          );
        }),
      ),
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  child: Text(
                    "Generate Random",
                  ),
                  onPressed: _randomise,
                ),
              ),
              Expanded(
                child: TextButton(
                  child: Text(
                    "Visualise",
                  ),
                  onPressed: isVisualizing == false
                      ? () {
                          generateAlgoAccordingToPage(currentPage, _numbers,
                              _streamController, val, _sampleSize);
                          setState(() {
                            isVisualizing = !isVisualizing;
                          });
                        }
                      : null,
                ),
              ),
            ],
          ),
          Slider(
            value: val.toDouble(),
            max: 5000,
            min: 500,
            onChanged: (newVal) {
              setState(() {
                val = newVal.floor();
              });
            },
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Array Length',
              ),
              onFieldSubmitted: (newLen) {
                setState(() {
                  _sampleSize = double.parse(newLen);
                });
              },
            ),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
