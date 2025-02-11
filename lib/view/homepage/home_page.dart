import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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

List<Map<String, dynamic>> items = [];
  // create new item
  final Box shopping_box = Hive.box("shopping_box");
  Future<void> createItem(Map<String, dynamic> item) async {
    await shopping_box.add(item);


       
  }

  void refresh(){
    final data =  shopping_box.keys.map((key){
      final value = shopping_box.get(key);
      return {
        "key": key,
        "name": value["name"],
        "quantity": value["quantity"]};
    }).toList();
    setState(() {
      items = data.reversed.toList();
    });
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

      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (_, index) {
            final item = items[index];
            return ListTile(
              title: Text(item["name"]),
              subtitle: Text(item["quantity"].toString()),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => showmethod(context, item["key"]),
              ),
            );
          }),
    );
  }
}
