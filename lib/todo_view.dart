import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todos_example/add_todo.dart';
import 'package:riverpod_todos_example/todo.dart';
import 'package:riverpod_todos_example/todo_notifier.dart';

final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});

TextEditingController deleteController = TextEditingController();

class TodoView extends ConsumerWidget {
  const TodoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, ref) {
    List<Todo> todos = ref.watch(todosProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddTodo()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 25),
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // Search Text Field...
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
              ),
              onChanged: (val) {
                debugPrint(val);
                List<Todo> todo =
                    todos.where((e) => e.description.contains(val)).toList();
                debugPrint(todo.length.toString());
                debugPrint(todo[0].toString());
                ref.read(todosProvider.notifier).search(todo);
              },
            ),
          ),
          // Sized Box...
          const SizedBox(height: 15),
          // List View...
          SizedBox(
            height: 380,
            child: ListView(
              children: [
                for (final todo in todos)
                  CheckboxListTile(
                    value: todo.completed,
                    // When tapping on the todo, change its completed status...
                    onChanged: (value) =>
                        ref.read(todosProvider.notifier).toggle(todo.id),
                    title: Text(todo.description),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
            child: TextField(
              controller: deleteController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Delete',
                hintText: 'Delete Todo',
              ),
            ),
          ),
          // Sized Box...
          const SizedBox(height: 24),
          // Button...
          ElevatedButton(
            onPressed: () {
              debugPrint(deleteController.text);
              ref.read(todosProvider.notifier).remove(deleteController.text);
              deleteController.clear();
            },
            child: const Text('Delete Todo'),
          )
        ],
      ),
    );
  }
}
