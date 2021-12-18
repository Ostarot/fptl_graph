import 'package:flutter/material.dart';
import "dart:io";
import 'dart:developer';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' show WidgetsFlutterBinding;
import "dart:convert";

import 'classes.dart';
import 'trying.dart';

List smth = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String doc = await rootBundle.loadString('assets/hell.json');
  var data = json.decode(doc);
  int len = data.length;

  var types = Set();
  var lens = Set();
  //for (int i = 0; i < len; i++) types.add(data[i]['children']);
  // int n1 = 0;
  // int n2 = 0;
  // int n3 = 0;
  // for (int i = 0; i < len; i++)
  // {
  //   if (data[i]['children'] != null)
  //   {
  //     n1++;
  //     //types.add(data[i]['children'].length);
  //     if (data[i]['children'].contains(data[i]['id'])) n2++;
  //     //if (data[i]['from'] != data[i]['to']) print(data[i]);
  //     //print(data[i]);
  //   }
  // }
  //
  // print(n1);
  // print(n2);

  //for (int i = 0; i < types.length; i++) lens.add(types[i].length);

  //var smth = []; СЕЙЧАС ПРОБУЮ С ГЛОБАЛЬНЫМ СПИСКОМ

  for (int i = 0; i < len; i++)
  {
    var a = data[i];
    if (data[i]['type'] == 'Constant') smth.add(Constant(a['id'], a['type'], a['line'], a['column'], a['valueType'], a['value']));
    if (data[i]['type'] == 'Parallel') smth.add(Parallel(a['id'], a['type'], a['complex'], a['children']));
    if (data[i]['type'] == 'Take') smth.add(Take(a['id'], a['type'], a['line'], a['column'], a['from'], a['to']));
    if (data[i]['type'] == 'Function') smth.add(Function1(a['id'], a['type'], a['line'], a['column'], a['complex'], a['name']));
    if (data[i]['type'] == 'Sequential') smth.add(Sequential(a['id'], a['type'], a['complex'], a['children']));
    if (data[i]['type'] == 'Scheme') smth.add(Scheme(a['id'], a['type'], a['complex'], a['name'], a['children']));
    if (data[i]['type'] == 'Condition') smth.add(Condition(a['id'], a['type'], a['complex'], a['children']));
    //smth.add(obj);
  }
  smth.sort((a, b) => a.id.compareTo(b.id)); //СОРТИРОВКА

  // for (int i = 0; i < len; i++){
  //   if (smth[i].runtimeType != 'Constant') print('children');
  // }

  print(!['Constant', 'Type'].contains(smth[2].type));

  // var a = data[5];
  // var t = Scheme(a['id'], a['type'], a['complex'], a['name'], a['children']);
  // print(t.runtimeType);

  // print('sorted');
  // for (int i = 0; i < smth.length; i++)
  //   print(smth[i].id);

    runApp(MaterialApp(
        home: FutureBuilder(
            future: loadAsset(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MyApp(doc: snapshot.data.toString());//(snapshot.data.toString()); snapshot.data.toString()
              } else {
                return Text('No data was loaded');
              }
            })
    )

      // MaterialApp(
      //   home: Scaffold(
      //     appBar: AppBar(title: Text("hello"),),
      //     body: MyWidget(), //MyWidget(0)
      //   ),
      // ),
    );
  }


class MyWidget extends StatefulWidget {

  MyWidget();

  @override
  MyWidgetState createState() => MyWidgetState();
}

class MyWidgetState extends State<MyWidget> {

  @override
  Widget build(BuildContext context) {
    //String data = await loadAsset(); //rootBundle.loadString('assets/hell.xml');
    return Text("newapp",);
  }
}

// Future<String> loadAsset(BuildContext context) async {
//   return await DefaultAssetBundle.of(context).loadString('assets/hell.json');
// }

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/hell.json');
}