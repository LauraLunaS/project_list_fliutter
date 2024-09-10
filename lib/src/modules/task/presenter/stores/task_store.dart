import 'package:mobx/mobx.dart';
import 'package:project_list_fliutter/src/modules/task/domain/repositories/io_counter_repository.dart';
import 'package:project_list_fliutter/src/modules/task/domain/usecases/add_task_use_case.dart';
import 'package:project_list_fliutter/src/modules/task/domain/usecases/get_task_use_case.dart';
import 'package:project_list_fliutter/src/modules/task/external/datasources/socket/socket_cliente.dart';
import 'package:project_list_fliutter/src/modules/task/infra/comm_packages/proto/pb/tasks.pb.dart';

part 'task_store.g.dart';

class TaskStore = _TaskStore with _$TaskStore;

abstract class _TaskStore with Store {
  final AddTaskUseCase addTaskUseCase;
  final GetTaskUseCase getTaskUseCase;
  final ICounterServerRepository _counterServerUseCase;
  final SocketClient _socketClient;

  String? userId;

  _TaskStore(
    this.addTaskUseCase,
    this.getTaskUseCase,
    this._counterServerUseCase,
    this._socketClient,
  ) {
    _socketClient.onSocketConnect((_) {
      print("Connected to socket server");
      listenerSocket();
      initializeUserId();
    });

    _socketClient.onSocketError((error) {
      print("Socket error: $error");
    });

    _socketClient.onSocketDisconnect((_) {
      print("Disconnected from socket server");
    });
  }

  @action
  void initializeUserId() {
    if (userId != null) {
      requestTaskCounterUpdate(userId!);
    } else {
      print(userId);
    }
  }

  @observable
  List<Task> tasks = ObservableList<Task>();

  final actualTask = Task();

  @observable
  bool identifyServerOutState = false;

  @observable
  String newTask = '';

  @observable
  String errorMessage = '';

  @observable
  bool isLoading = false;

  @observable
  int taskCounter = 0;

  @action
  void setNewTask(String value) {
    newTask = value;
  }

  void listenerSocket() {
    _socketClient.receiveAdapterMessage('update_response', (data) {
      print("Recebendo dados: $data");
      return int.parse(data);
    }, (count) {
      runInAction(() {
        taskCounter = count;
      });
      print("Contador de tasks atualizado via socket: $count");
    });
  }

  @action
  Future<void> requestTaskCounterUpdate(String userId) async {
    try {
      print('Sending request for task counter update for user: $userId');
      _socketClient.sendMessage('request_counter_update', userId);
    } catch (e) {
      runInAction(() {
        errorMessage = 'Falha ao atualizar o contador de tarefas';
      });
      print("Erro: $e");
    }
  }

  @action
  Future<bool> addTask(String task, String userId) async {
    actualTask.task = task;

    if (newTask.isNotEmpty) {
      try {
        final task = await addTaskUseCase.addTask(actualTask, userId);
        tasks.add(actualTask);
        newTask = '';
        await requestTaskCounterUpdate(userId);
        if (task.$2 != null) {
          return true;
        }
      } catch (e) {
        errorMessage = 'Failed to add tasks';
      }
    }
    return false;
  }

  @action
  Future<void> loadTaskHistory(String userId) async {
    isLoading = true;
    try {
      List<Task> taskList = await getTaskUseCase.getTasks(userId);
      tasks = ObservableList.of(taskList);
    } catch (e) {
      errorMessage = 'Failed to load tasks';
    } finally {
      isLoading = false;
    }
  }
}
