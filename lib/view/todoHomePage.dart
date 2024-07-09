import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/model/todoModel.dart';
import 'package:todo_app/service/todoServices.dart';

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  late Future<List<Task>> futureTasks;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    futureTasks = apiService.getTasks();
  }

  void refreshTasks() {
    setState(() {
      futureTasks = apiService.getTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: FutureBuilder<List<Task>>(
        future: futureTasks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tasks found'));
          } else {
            return ListView(
              children: snapshot.data!.map((task) {
                return ListTile(
                  title: Text(task.title),
                  subtitle:
                      Text('Status: ${task.status}\nDue Date: ${task.dueDate}'),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          final updatedTask = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TaskFormPage(task: task)),
                          );
                          if (updatedTask != null) {
                            refreshTasks();
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await apiService.deleteTask(task.id);
                          refreshTasks();
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskFormPage(task: null)),
          );
          if (newTask != null) {
            refreshTasks();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskFormPage extends StatefulWidget {
  final Task? task;

  TaskFormPage({required this.task});

  @override
  _TaskFormPageState createState() => _TaskFormPageState();
}

class _TaskFormPageState extends State<TaskFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String description;
  late String status;
  late String dueDate;

  final ApiService apiService = ApiService();
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      title = widget.task!.title;
      description = widget.task!.description;
      status = widget.task!.status;
      _controller.text = dueDate = widget.task!.dueDate;
    } else {
      title = '';
      description = '';
      status = 'pending';
      _controller.text =
          dueDate = DateTime.now().toLocal().toIso8601String().split('T')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task != null ? 'Edit Task' : 'Create Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: title,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  title = value!;
                },
              ),
              TextFormField(
                initialValue: description,
                maxLines: null,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  description = value!;
                },
              ),
              DropdownButtonFormField<String>(
                value: status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: ['pending', 'in-progress', 'completed']
                    .map((status) =>
                        DropdownMenuItem(value: status, child: Text(status)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    status = value!;
                  });
                },
              ),
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Due Date'),
                onTap: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    log(pickedDate.toLocal().toIso8601String().split('T')[0]);
                    setState(() {
                      dueDate = _controller.text =
                          pickedDate.toLocal().toIso8601String().split('T')[0];
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a due date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Task newTask = Task(
                      id: widget.task?.id ?? 0,
                      title: title,
                      description: description,
                      status: status,
                      dueDate: dueDate,
                    );
                    if (widget.task == null) {
                      await apiService.createTask(newTask);
                    } else {
                      await apiService.updateTask(widget.task!.id, newTask);
                    }
                    Navigator.pop(context, newTask);
                  }
                },
                child:
                    Text(widget.task != null ? 'Update Task' : 'Create Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
