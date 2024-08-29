import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/name_provider.dart';
import './model/name_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NameProvider()..loadNames(),
      child: MaterialApp(
        home: NameListScreen(),
      ),
    );
  }
}

class NameListScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Name List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Enter name'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final name = NameModel(name: _nameController.text);
              Provider.of<NameProvider>(context, listen: false).addName(name);
              _nameController.clear();
            },
            child: const Text('Add Name'),
          ),
          Expanded(
            child: Consumer<NameProvider>(
              builder: (context, nameProvider, child) {
                return ListView.builder(
                  itemCount: nameProvider.names.length,
                  itemBuilder: (context, index) {
                    final name = nameProvider.names[index];
                    return ListTile(
                      title: Text(name.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          nameProvider.deleteName(name.id!);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
