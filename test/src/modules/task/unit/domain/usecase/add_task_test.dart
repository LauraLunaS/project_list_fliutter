import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:project_list_fliutter/src/modules/task/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/task/infra/comm_packages/proto/pb/tasks.pb.dart';
import 'package:project_list_fliutter/src/modules/task/domain/repositories/post_task_repository.dart';
import 'package:project_list_fliutter/src/modules/task/domain/usecases/add_task_use_case.dart';

import 'add_task_test.mocks.dart';

@GenerateMocks([IPostTaskRepository])

void main() {
  late IPostTaskRepository postTaskRepository;
  late AddTaskUseCase addTaskUseCase;

  setUp(() {
    postTaskRepository = MockIPostTaskRepository();
    addTaskUseCase = AddTaskUseCase(postTaskRepository);
  });

  test('Tarefa adicionada com sucesso', () async {
    final task = Task();

    when(postTaskRepository.addTask(task, task.userId))
      .thenAnswer((_) async => (true, null));
    
    final (result, createTaskError) = await addTaskUseCase.addTask(task, task.userId);

    expect(createTaskError, null);
    expect(result, true);
  });

  test('Erro ao adicionar tarefa', () async {
    final task = Task();
    const error = CreateTaskError('Invalid response from the server');

    when(postTaskRepository.addTask(task, task.userId))
      .thenAnswer((_) async => (true, error));
    
    final (result, createTaskError) = await addTaskUseCase.addTask(task, task.userId);

    expect(createTaskError, isNotNull);
    expect(createTaskError, error);
    expect(result, true);
  });

}