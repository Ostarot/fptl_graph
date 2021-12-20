import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' show WidgetsFlutterBinding;
import 'package:visual_v1/classes.dart';
import "dart:convert";

import 'trying.dart';

List<FPTLNode> smth = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
      home: FutureBuilder(
          future: loadAsset(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MyApp(doc: snapshot.data.toString());
            } else {
              return const Text('No data was loaded');
            }
          })
  )
  );
}

Future<String> loadAsset() async {
  String doc = await rootBundle.loadString('assets/hell.json');

  smth = (json.decode(doc) as List)
      .map((e) => FPTLNode(e))
      .toList();
  smth.sort((a, b) => a.id.compareTo(b.id));
  return doc;
}