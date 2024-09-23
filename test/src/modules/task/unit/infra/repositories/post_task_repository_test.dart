import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:project_list_fliutter/src/modules/task/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/task/infra/comm_packages/proto/pb/tasks.pb.dart';
import 'package:project_list_fliutter/src/modules/task/infra/repositories/post_task_repository.dart';

import 'post_task_repository_test.mocks.dart';

@GenerateMocks([PostTaskRepositoryImpl])

void main() {
  late PostTaskRepositoryImpl repository;
  late MockISaveTaskDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockISaveTaskDatasource();
    repository = PostTaskRepositoryImpl(mockDatasource);
  });

  test('sucesso ao adicionar task', () async {
    final task = Task(); 

    when(repository.addTask(task, task.userId))
        .thenAnswer((_) async => (true, null)); 

    final (result, error) = await repository.addTask(task, task.userId);

    expect(result, true);
    expect(error, null);
  });

  test('Erro ao adicionar task', () async {
    final task = Task();
    
    when(repository.addTask(task, task.userId))
        .thenAnswer((_) async => (false, null)); 

    final (result, erro) = await repository.addTask(task, task.userId);

    expect(result, null);
    expect(erro, isA<CreateTaskError>());
  });
}
