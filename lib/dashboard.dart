import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> items = ['Item 1', 'Item 2', 'Item 3']; // Initial list of items

  // Method to add an item to the list
  void addItem() {
    setState(() {
      items.add('New Item ${items.length + 1}');
    });
  }

  // Method to remove an item from the list
  void removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                removeItem(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addItem,
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
