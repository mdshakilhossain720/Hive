import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nametextEditingController =
      TextEditingController();
  final TextEditingController quantitytextEditingController =
      TextEditingController();

  // create new item
  Future<void> createItem(Map<String, dynamic> item) async {
    final item = Item(
        name: nametextEditingController.text,
        quantity: quantitytextEditingController.text);
    await Hive.box<Item>('items').add(item);
  }

  void showmethod(BuildContext context, int? itemkey) {
    showModalBottomSheet(
        elevation: 0,
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 15,
              right: 15,
              top: 15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: nametextEditingController,
                  decoration: const InputDecoration(hintText: "Name"),
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: quantitytextEditingController,
                  decoration: const InputDecoration(hintText: "Quantity"),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      nametextEditingController.text = "";
                      quantitytextEditingController.text = "";
                      Navigator.pop(context);
                    },
                    child: const Text("create New")),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hive Page"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showmethod(context, null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
