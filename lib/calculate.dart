import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tile_calculator/send_msg.dart';

class calculate extends StatelessWidget {
  const calculate({super.key});

  @override
  Widget build(BuildContextcontext) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: tiles(),
      ),
    );
  }
}

class tiles extends StatefulWidget {
  const tiles({super.key});

  @override
  State<tiles> createState() => _tilesState();
}

class _tilesState extends State<tiles> {
  TextEditingController _length = TextEditingController();
  TextEditingController _width = TextEditingController();
  TextEditingController _t1 = TextEditingController();
  TextEditingController _t2 = TextEditingController();

  double _tiles = 0.0;
  double _extra = 0.0;
  double _total = 0.0;

  FirebaseFirestore _ab = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculate Tiles'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: TextField(
                  controller: _length,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Length',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: TextField(
                  controller: _width,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Width',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: TextField(
                  controller: _t1,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Tile Length',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: TextField(
                  controller: _t2,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Tile Width',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(
                    () {
                      double length = double.parse(_length.text);
                      double width = double.parse(_width.text);
                      double t1 = double.parse(_t1.text);
                      double t2 = double.parse(_t2.text);

                      double t3 = t1 * t2;
                      _tiles = length * width * (1 / t3);
                      _extra = _tiles * 0.1;
                      _total = _tiles + _extra;
                      print('Tiles : $_tiles');
                      print('Extra Tiles : $_extra');
                      print('Total Tiles  Required : $_total');

                      _ab.collection('Tiles').add({
                        'Tiles': _tiles,
                        'Extra Tiles': _extra,
                        'Total Tiles Required': _total,
                      }).then((value) {
                        print(value);
                      }).catchError((e) {
                        print(e);
                      });
                    },
                  );
                },
                child: Text(
                  'Calculate',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    height: 50,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      'Extra 10% = ${_extra.toStringAsFixed(2)}',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    height: 50,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      'Total Tiles Required: ${_total.toStringAsFixed(2)}',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => message(
                          tile: _tiles.toStringAsFixed(2),
                          extra: _extra.toStringAsFixed(2),
                          total: _total.toStringAsFixed(2),
                        ),
                      ),
                    );
                  });
                },
                child: Text(
                  'Send Data',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
