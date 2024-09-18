import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:project_list_fliutter/src/modules/task/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/task/infra/comm_packages/proto/pb/tasks.pb.dart';
import 'package:project_list_fliutter/src/modules/task/infra/repositories/post_task_repository.dart';
import 'package:project_list_fliutter/src/modules/task/infra/datasources/save_task_datasource.dart';

import 'post_task_repository_test.mocks.dart';

@GenerateMocks([ISaveTaskDatasource])

void main() {
  late PostTaskRepositoryImpl repository;
  late MockISaveTaskDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockISaveTaskDatasource();
    repository = PostTaskRepositoryImpl(mockDatasource);
  });

  test('adicionar task', () async {
    final task = Task(id: '1', task: 'tasa', userId: '2'); 
    final taskEncoded = Uint8List(0); 
    const erro = CreateTaskError('Invalid');

    when(mockDatasource.saveTask(taskEncoded))
        .thenAnswer((_) async => (true, null)); 

    final (result, error) = await repository.addTask(task, task.userId);

    expect(result, true);
  });

  test('Erro ao recuperar lista de tasks', () async {
    final task = Task();
    
  });
}
