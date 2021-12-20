import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

import 'classes.dart';
import 'main.dart';

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
            Expanded(
              child: InteractiveViewer(
                  constrained: false,
                  boundaryMargin: EdgeInsets.all(100),
                  minScale: 0.01,
                  maxScale: 5.6,

                  child: GraphView(
                    graph: graph,
                    // algorithm: FruchtermanReingoldAlgorithm(),
                    // algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
                    algorithm: SugiyamaAlgorithm(builder2),
                    paint: Paint()
                      ..color = Colors.green
                      ..strokeWidth = 1
                      ..style = PaintingStyle.stroke,
                    builder: (Node node) {
                      // I can decide what widget should be shown here based on the id
                      var a = node.key!.value as int;
                      return nodeWidget(smth[a]);
                      // if ([Func, Sequential, Parallel, Scheme, Condition].contains(obj.runtimeType) && obj.complex) {}
                    },
                  )),
            ),
          ],
        ));
  }

  //Random r = Random();

  Widget nodeWidget(FPTLNode a) { //int a
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: a.type == 'Ref' ? BoxShape.circle : BoxShape.rectangle,
            border: Border.all(
              color: a.complex ? Colors.red : Colors.black,
              width: 1,
            ),
            borderRadius: a.type == 'Ref' ? null : BorderRadius.circular(4),
          ),
          child: Text(a.str)), //прописать Node
    );
  }

  final Graph graph = Graph()..isTree = false; //true для walker
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  SugiyamaConfiguration builder2 = SugiyamaConfiguration();

  @override
  void initState() {
    super.initState();

    for (var element in smth) {
      for (var child in element.children??[]) {
        if (element.id == child) {
          continue;
        } else /*if (element.id < child)*/ {
          graph.addEdge(Node.Id(element.id), Node.Id(child));
        } /*else {
          var node = FPTLNode({"id":child,"type":"Ref"});
          node.complex = smth[child].complex;
          smth.add(node);
          graph.addEdge(Node.Id(element.id), Node.Id(smth.length - 1));
        }*/
      }
    }


    // builder
    //   ..siblingSeparation = (100) //неадекватно, надо как-то в проге менять
    //   ..levelSeparation = (250)
    //   ..subtreeSeparation = (100)
    //   ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);

    builder2
      ..levelSeparation = (50)
      ..nodeSeparation = (50)
      ..iterations = (4)
      ..orientation = (SugiyamaConfiguration.ORIENTATION_TOP_BOTTOM);
  }
}