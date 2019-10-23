import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// main function that runs the whole app
void main() {
  debugPaintSizeEnabled = true;
  runApp(
    MaterialApp(
      title: 'Carb',
      home: MacuroApp(),
    ),
  );
}

// Macuro application class that includes build function
class MacuroApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget buildSection(Color background) {
      return Container(
        child: CounterWidget(background),
      );
    }

    return new MaterialApp(
      title: 'Macuro',
      theme: new ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              bottom: TabBar(
                indicatorColor: Colors.redAccent,
                tabs: [
                  Tab(
                    text: "Carbs",
                  ),
                  Tab(
                    text: "Proteins",
                  ),
                  Tab(
                    text: "Fats",
                  ),
                ],
              ),
              title: Text("Macuro")),
          body: TabBarView(
            children: <Widget>[
              buildSection(Colors.green[200]),
              buildSection(Colors.red[200]),
              buildSection(Colors.yellow[200]),
            ],
          ),
        ),
      ),
    );
  }
}

// Counter stateful widget that is used to increase/decrease value
class CounterWidget extends StatefulWidget {
  Color _background;

  CounterWidget(Color bg) {
    this._background = bg;
  }

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

// Counter state that actually builds the widget and implements interactivity
class _CounterWidgetState extends State<CounterWidget> {
  int _value = 0;
  int _tempValue = 0;

  void _offsetVal(DragUpdateDetails details) {
    setState(() {
      if (_value - details.delta.dy.round() >=
          0) // prevents value being displayed from becoming negative
        _value -= details.delta.dy.round();
    });
    // Temporary value shown so user does not need to do math
    void _tempVal(DragUpdateDetails details) {
      setState(() {
        _tempValue = 0;
        if (_tempValue - details.delta.dy.round() >= 0)
          _tempValue -= details.delta.dy.round();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _offsetVal, 
      // TODO: add in background that changes with the increase/decrease in value
      child: Container(
        color: widget._background, // need this for Container to fill screen
        alignment: Alignment.center,
        child: Text(
          '$_value' 'g',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 90.0,
          ),
        ),
      ),
    );
  }
}
