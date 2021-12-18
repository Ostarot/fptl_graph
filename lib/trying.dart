import 'dart:math';

import 'package:flutter/material.dart';
import "dart:io";
import 'dart:developer';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' show WidgetsFlutterBinding;
import "dart:convert";

import 'classes.dart';
import 'main.dart';

import 'package:graphview/GraphView.dart';


class MyApp extends StatelessWidget {
  final String doc;

  MyApp({required this.doc});

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: TreeViewPage(doc: doc),
  );
}

class TreeViewPage extends StatefulWidget {
  String doc;

  TreeViewPage({required this.doc});

  @override
  _TreeViewPageState createState() => _TreeViewPageState(doc: doc);
}

class _TreeViewPageState extends State<TreeViewPage> {

  String doc;
  _TreeViewPageState({required this.doc});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Wrap(
              children: [
                // Container(
                //   width: 100,
                //   child: TextFormField(
                //     initialValue: builder.siblingSeparation.toString(),
                //     decoration: InputDecoration(labelText: "Sibling Separation"),
                //     onChanged: (text) {
                //       builder.siblingSeparation = int.tryParse(text) ?? 100;
                //       this.setState(() {});
                //     },
                //   ),
                // ),
                // Container(
                //   width: 100,
                //   child: TextFormField(
                //     initialValue: builder.levelSeparation.toString(),
                //     decoration: InputDecoration(labelText: "Level Separation"),
                //     onChanged: (text) {
                //       builder.levelSeparation = int.tryParse(text) ?? 100;
                //       this.setState(() {});
                //     },
                //   ),
                // ),
                // Container(
                //   width: 100,
                //   child: TextFormField(
                //     initialValue: builder.subtreeSeparation.toString(),
                //     decoration: InputDecoration(labelText: "Subtree separation"),
                //     onChanged: (text) {
                //       builder.subtreeSeparation = int.tryParse(text) ?? 100;
                //       this.setState(() {});
                //     },
                //   ),
                // ),
                // Container(
                //   width: 100,
                //   child: TextFormField(
                //     initialValue: builder.orientation.toString(),
                //     decoration: InputDecoration(labelText: "Orientation"),
                //     onChanged: (text) {
                //       builder.orientation = int.tryParse(text) ?? 100;
                //       this.setState(() {});
                //     },
                //   ),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     final node12 = Node.Id(r.nextInt(100));
                //     var edge = graph.getNodeAtPosition(r.nextInt(graph.nodeCount()));
                //     print(edge);
                //     graph.addEdge(edge, node12);
                //     setState(() {});
                //   },
                //   child: Text("Add"),
                // )
              ],
            ),
            Expanded(
              child: InteractiveViewer(
                  constrained: false,
                  boundaryMargin: EdgeInsets.all(100),
                  minScale: 0.01,
                  maxScale: 5.6,

                  child: GraphView(
                    graph: graph,
                    algorithm: FruchtermanReingoldAlgorithm(),  //BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),    SugiyamaAlgorithm(builder),
                    paint: Paint()
                      ..color = Colors.green
                      ..strokeWidth = 1
                      ..style = PaintingStyle.stroke,
                    builder: (Node node) {
                      // I can decide what widget should be shown here based on the id
                      var a = node.key!.value as int; // as int
                      //return rectangleWidget(a);
                      var obj = smth[a-1];
                      if (['Sequential', 'Parallel', 'Scheme', 'Condition'].contains(obj.type) && obj.children.contains(a)) {
                          return rectangleWidgetBoldBorder(obj);
                        }
                      else {
                        return rectangleWidget(obj);
                      }
                    },
                  )),
            ),
          ],
        ));
  }

  //Random r = Random();

  Widget rectangleWidget(var a) { //int a
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(color: Colors.black, spreadRadius: 1), //BoxShadow(color: Colors.blue[100], spreadRadius: 1), менять радиус для рекурсии
            ],
          ),
          child: Text('${a.toString()}')), //прописать Node
    );
  }

  Widget rectangleWidgetBoldBorder(var a) { //int a
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(color: Colors.black, spreadRadius: 5), //BoxShadow(color: Colors.blue[100], spreadRadius: 1), менять радиус для рекурсии
            ],
          ),
          child: Text('${a.toString()}')), //прописать Node
    );
  }

  Widget circleWidget(var a) { //int a
    return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
            //borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(color: Colors.black, spreadRadius: 10), //BoxShadow(color: Colors.blue[100], spreadRadius: 1),
            ],
          ),
          child: Text('${a.toString()}')); //прописать Node
  }

  final Graph graph = Graph()..isTree = false; //true для walker
  //BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  //SugiyamaConfiguration builder = SugiyamaConfiguration();

  @override
  void initState() {

    for (int i = 0; i < smth.length; i++) {
      if (['Sequential', 'Parallel', 'Scheme', 'Condition'].contains(smth[i].type)) {
        for (var child in smth[i].children) {
          if (smth[i].id != child){
            graph.addEdge(Node.Id(smth[i].id), Node.Id(child));
          }
        }
      }
    }


    // final node1 = Node.Id(1);
    // final node2 = Node.Id(2);
    // final node3 = Node.Id(3);
    // final node4 = Node.Id(4);
    // final node5 = Node.Id(5);
    // final node6 = Node.Id(6);
    // final node8 = Node.Id(7);
    // final node7 = Node.Id(8);
    // final node9 = Node.Id(9);
    // final node10 = Node.Id(10);
    // final node11 = Node.Id(11);
    // final node12 = Node.Id(12);
    //
    // graph.addEdge(node1, node2);
    // graph.addEdge(node1, node3, paint: Paint()..color = Colors.red);
    // graph.addEdge(node1, node4, paint: Paint()..color = Colors.blue);
    // graph.addEdge(node2, node5);
    // graph.addEdge(node2, node6);
    // graph.addEdge(node6, node7, paint: Paint()..color = Colors.red);
    // graph.addEdge(node6, node8, paint: Paint()..color = Colors.red);
    // graph.addEdge(node4, node9);
    // graph.addEdge(node4, node10, paint: Paint()..color = Colors.black);
    // graph.addEdge(node4, node11, paint: Paint()..color = Colors.red);
    // graph.addEdge(node11, node12);


    // builder
    //   ..siblingSeparation = (100) //неадекватно, надо как-то в проге менять
    //   ..levelSeparation = (250)
    //   ..subtreeSeparation = (100)
    //   ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);

    // builder
    //   ..levelSeparation = (250)
    //   ..nodeSeparation = (100)
    //   ..iterations = (4)
    //   ..orientation = (SugiyamaConfiguration.ORIENTATION_TOP_BOTTOM);
  }
}