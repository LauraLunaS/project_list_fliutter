import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nock/nock.dart';
import 'package:project_list_fliutter/src/modules/auth/external/datasources/server_routes.dart';
import 'package:project_list_fliutter/src/modules/task/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/task/external/datasources/http/get_tasks_datasources.dart';
import 'package:project_list_fliutter/src/modules/task/infra/comm_packages/proto/pb/tasks.pb.dart';

import 'get_task_datasource_test.mocks.dart';

@GenerateMocks([GetTaskDatasourceExternal]) 

void main() {
  late MockGetTaskDatasourceExternal getTaskDatasourceExternal;

  setUpAll(() {
    nock.init();
  });

  setUp(() {
    getTaskDatasourceExternal = MockGetTaskDatasourceExternal(http.Client());
    nock.cleanAll();
  });

  dynamic interceptorSectorNames(int statusCode, String body) {
    final interceptor = nock(serverAdrees).get('/get_tasks')
      ..reply(
        statusCode,
        'body',
      );
    return interceptor;
  }

  test('Erro 400', () async {
    interceptorSectorNames(400, 'body');

    final task = Task();

    when(getTaskDatasourceExternal.getAllTasks(task.userId))
        .thenThrow(ExternalError('Invalid credentials'));

    try {
      await getTaskDatasourceExternal.getAllTasks(task.userId);
    } catch (e) {
      expect(e, isA<ExternalError>());
    }
  });

  test('Sucesso', () async {
    interceptorSectorNames(200, 'body');

    final task = Task();

    when(getTaskDatasourceExternal.getAllTasks(task.userId))
        .thenAnswer((_) async => ([task]));

    final result = await getTaskDatasourceExternal.getAllTasks(task.userId);
    expect(result, isA<List<Task>>());
    
  });
}
