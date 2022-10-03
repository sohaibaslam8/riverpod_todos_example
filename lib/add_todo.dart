import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todos_example/todo.dart';
import 'package:riverpod_todos_example/todo_view.dart';

TextEditingController mycontroller = TextEditingController();

class AddTodo extends ConsumerWidget {
  const AddTodo({super.key});
  @override
  Widget build(BuildContext context, ref) {
    // List<Todo> todos = ref.watch(todosProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Add Todo')),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 48),
        child: Column(
          children: [
            // Text Field...
            TextField(
              controller: mycontroller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Add Todo',
                hintText: 'Add Todo',
              ),
            ),
            // Sized Box...
            const SizedBox(height: 24),
            // Button...
            ElevatedButton(
              onPressed: () {
                int length = ref.watch(todosProvider).length;
                Todo todo = Todo(
                    id: length.toString(),
                    description: mycontroller.text,
                    completed: true);
                ref.read(todosProvider.notifier).addTodo(todo);
                mycontroller.clear();
                Navigator.pop(context);
              },
              child: const Text('Add Todo'),
            )
          ],
        ),
      ),
    );
  }
}
