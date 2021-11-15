import 'package:flutter/material.dart';
import '../DummyData.dart';
import './ShoppingItem.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final places = List.from(Data.shoppingList);
  final key = GlobalKey<AnimatedListState>();
  final items = List.from(Data.shoppingList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('Hello'),
          Expanded(
            child: AnimatedList(
              key: key,
              initialItemCount: items.length,
              itemBuilder: (context, index, animation) =>  buildItem(items[index], index, animation),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: buildButton(),
          ),
        ],
      ),
    );
  }

  Widget buildButton() => SizedBox(
        height: 40,
        width: 100,
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Add Item'),
          style: ElevatedButton.styleFrom(primary: Colors.black),
        ),
      );

  Widget buildItem(item, int index, Animation<double> animation) =>
      ShoppingItem(
        item: item,
        animation: animation,
        onClicked:() => removeItem(index),
      );

  void insertItem(int index, ShoppingItem item) {
    items.insert(index, item);
    key.currentState!.insertItem(index);
  }

  void removeItem(int index) {
    final item = items.removeAt(index);

    key.currentState!.removeItem(
      index,
          (context, animation) => buildItem(item, index, animation),
    );
  }
}
