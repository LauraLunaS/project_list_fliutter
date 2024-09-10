import 'package:mobx/mobx.dart';
import 'package:project_list_fliutter/src/modules/task/domain/usecases/add_task_use_case.dart';
import 'package:project_list_fliutter/src/modules/task/domain/usecases/get_task_use_case.dart';
import 'package:project_list_fliutter/src/modules/task/domain/usecases/io_counter_use_case.dart';
import 'package:project_list_fliutter/src/modules/task/external/datasources/socket/socket_cliente.dart';
import 'package:project_list_fliutter/src/modules/task/infra/comm_packages/proto/pb/tasks.pb.dart';

part 'task_store.g.dart';

class TaskStore = ITaskStore with _$TaskStore;

abstract class ITaskStore with Store {
  final AddTaskUseCase addTaskUseCase;
  final GetTaskUseCase getTaskUseCase;
  final IIoCounterUsecase _counterServerUseCase;
  final SocketClient _socketClient;

  String? userId;

  ITaskStore(
    this.addTaskUseCase,
    this.getTaskUseCase,
    this._counterServerUseCase,
    this._socketClient,
  ) {
    _socketClient.onSocketConnect((_) {
      listenerSocket(listenerSocket);
    });

    _socketClient.onSocketError((error) {});

    _socketClient.onSocketDisconnect((_) {});
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

  void listenerSocket(data) {
    _counterServerUseCase.responseCounterUpdate(
      (data) {
        taskCounter = int.parse(data);
      },
    );
  }

  @action
  Future<void> requestTaskCounterUpdate(String userId) async {
    try {
      _counterServerUseCase.requestCounterUpdate2(userId);
    } catch (e) {
      errorMessage = 'Falha ao atualizar o contador de tarefas';
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
