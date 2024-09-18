import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:project_list_fliutter/src/modules/task/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/task/infra/comm_packages/proto/pb/tasks.pb.dart';
import 'package:project_list_fliutter/src/modules/task/infra/repositories/get_task_repository.dart';
import 'package:project_list_fliutter/src/modules/task/infra/datasources/get_all_tasks_datasource.dart';

import 'get_task_repository_test.mocks.dart';

@GenerateMocks([IGetAllTasksDatasource])

void main() {
  late GetTaskRepositoryImpl repository;
  late MockIGetAllTasksDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockIGetAllTasksDatasource();
    repository = GetTaskRepositoryImpl(mockDatasource);
  });

  test('recuperar lista de tasks realizado com sucesso', () async {
    final task = Task();
    
    when(mockDatasource.getAllTasks(task.userId))
      .thenAnswer((_) async => ([task]));

    final result = await repository.getTasks(task.userId);

    expect(result, isA<List<Task>>());

    
  });

  //posso receber aqui uma lista vazia ou um GetTaskError
  test('Erro ao recuperar lista de tasks', () async {
    final task = Task();
    const error = GetTaskError('Invalid');

    when(mockDatasource.getAllTasks(task.userId))
      .thenAnswer((_) async => ([]));

    final result = await repository.getTasks(task.userId);
    expect(result, []);
    
  });
}
