import 'dart:async';
import 'dart:io';
import 'dart:io' as prefix0;

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() async {

  var data =  await readData();
  if (data != null) {
    String message = await readData();
    print(message);
  }

  runApp(new MaterialApp(
    title: 'IO',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _enterDataField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('ReadWrite'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(13.4),
        alignment: Alignment.topCenter,
        child: ListTile(
          title: TextField(
            controller: _enterDataField,
            decoration: InputDecoration(
                labelText: 'Write something'
            ),
          ),
          subtitle: FlatButton(
            onPressed: () {
              //save to file
              writeData(_enterDataField.text);
              //TODO
              //if statements to not save null etc.
            },
            child: Column(
              children: <Widget>[
                Text('Save Data'),
                Padding(padding: EdgeInsets.all(14.5)),
                Text('Saved data goes here'),
                FutureBuilder(
                  future: readData(),
                  builder: (BuildContext context, AsyncSnapshot<String> data) {
                    if (data.hasData != null) {
                      return Text(
                        data.data.toString(),
                        style: TextStyle(
                          color: Colors.blueAccent
                        ),
                      );
                    }else {
                      return Text("No data saved");
                    }
                  })
              ],
            ),
          ),
        ),
      ),
    );
  }
}



  //Below is the read write
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;//home/directory/
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return new File('$path/data.txt');//home/directory/data.txt
  }
  //write and read from our file
Future<File> writeData(String message) async {
    final file = await _localFile;
    //write to file
  return file.writeAsString('$message');
}

Future<String> readData() async {
    try {
      final file = await _localFile;
      //Read
      String data = await file.readAsString();

      return data;

    }catch (e) {
      return "Nothing saved yet!";
    }
}

