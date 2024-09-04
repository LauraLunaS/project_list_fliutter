import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:project_list_fliutter/src/modules/task/presenter/stores/task_store.dart';
import 'package:window_manager/window_manager.dart';

class TaskPage extends StatefulWidget {
  final String? userId;
  const TaskPage({super.key, this.userId});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> with WindowListener {
  late final TaskStore taskStore;
  final TextEditingController _controller = TextEditingController();
  String? userId;

  @override
  void initState() {
    super.initState();
    taskStore = context.read<TaskStore>();
    userId = Modular.args.data?['userId'] as String?;
    if (userId != null) {
      taskStore.loadTaskHistory(userId!);
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Task List', style: TextStyle(fontWeight: FontWeight.w800),),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                child: Observer(
                  builder: (_) {
                    _controller.text = taskStore.newTask;
                    return TextField(
                      controller: _controller,
                      onChanged: taskStore.setNewTask,
                      decoration: const InputDecoration(
                        labelText: 'Enter a task',
                        labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      style: const TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),  
              Observer(
                builder: (_) => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    shape: const CircleBorder(),
                    backgroundColor: Color.fromARGB(255, 0, 104, 64), 
                  ),
                  onPressed: () async {
                    if (taskStore.newTask.isNotEmpty) {
                      await taskStore.addTask(taskStore.newTask, userId!);
                    }
                  },
                  child: const Text('+', style: TextStyle(fontSize: 25, color: Colors.white)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
          child: Observer(
            builder: (_) {
              if (taskStore.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (taskStore.errorMessage.isNotEmpty) {
                return Center(
                  child: Text(
                    taskStore.errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }
              return ListView.builder(
                itemCount: taskStore.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskStore.tasks[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(118, 34, 156, 255),
                      borderRadius: BorderRadius.circular(8.0), 
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTile(
                      title: Text(
                        task.task,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),

        ],
      ),
    ),
  );
}

}
