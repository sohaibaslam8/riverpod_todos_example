import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todos_example/todo.dart';

class TodosNotifier extends StateNotifier<List<Todo>> {
  // We initialize the list of todos to an empty list
  TodosNotifier()
      : super([
          const Todo(id: '1', description: 'Provider', completed: true),
          const Todo(id: '2', description: 'State Provider', completed: true),
          const Todo(id: '3', description: 'Future Provider', completed: true),
          const Todo(id: '4', description: 'Stream Provider', completed: true),
          const Todo(id: '5', description: 'Stream Provider', completed: true),
        ]);

  // Let's allow the UI to add todos.
  void addTodo(Todo todo) {
    // Since our state is immutable, we are not allowed to do `state.add(todo)`.
    // Instead, we should create a new list of todos which contains the previous
    // items and the new one.
    // Using Dart's spread operator here is helpful!
    state = [...state, todo];
    // No need to call "notifyListeners" or anything similar. Calling "state ="
    // will automatically rebuild the UI when necessary.
  }

  // Let's allow removing todos
  void removeTodo(String todoId) {
    // Again, our state is immutable. So we're making a new list instead of
    // changing the existing list.
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  // Let's mark a todo as completed
  void toggle(String todoId) {
    state = [
      for (final todo in state)
        // we're marking only the matching todo as completed
        if (todo.id == todoId)
          // Once more, since our state is immutable, we need to make a copy
          // of the todo. We're using our `copyWith` method implemented before
          // to help with that.
          todo.copyWith(completed: !todo.completed)
        else
          // other todos are not modified
          todo,
    ];
  }

  // Serach Data...
  void search(List<Todo> todos) {
    state =
        // todos.where((e) => e.description.contains(value)).toList();
        // for (final todo in state)
        //   // we're marking only the matching todo as completed
        //   if (todo.id == todoId)
        //     // Once more, since our state is immutable, we need to make a copy
        //     // of the todo. We're using our `copyWith` method implemented before
        //     // to help with that.
        //  for (final todo in state)
        todos;
    // else
    //   // other todos are not modified
    //   todo,
  }

  void remove(String id) {
    state = [
      for (final todo in state)
        if (todo.id != id) todo,
    ];
  }
}
