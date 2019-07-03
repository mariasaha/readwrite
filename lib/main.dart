import 'dart:async';
import 'dart:io';
import 'dart:io' as prefix0;

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
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
  @override
  Widget build(BuildContext context) {
    return Container();
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
}
