import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nock/nock.dart';
import 'package:project_list_fliutter/src/modules/auth/external/datasources/server_routes.dart';
import 'package:project_list_fliutter/src/modules/task/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/task/external/datasources/http/post_add_tasks_datasources.dart';
import 'package:project_list_fliutter/src/modules/task/infra/comm_packages/proto/pb/tasks.pb.dart';

import 'post_task_datasource_test.mocks.dart';


@GenerateMocks([PostAddTasksDatasource]) 
void main() {
  late MockPostAddTasksDatasource addTaskDatasourceExternal;

  setUpAll(() {
    nock.init();
  });

  setUp(() {
    addTaskDatasourceExternal = MockPostAddTasksDatasource();
    nock.cleanAll();
  });

  dynamic interceptorSectorNames(int statusCode, String body) {
    final interceptor = nock(serverAdrees).post('/add_task')
      ..reply(
        statusCode,
        'body',
      );
    return interceptor;
  }

  test('Erro 400', () async {
    interceptorSectorNames(400, 'body');

    final task = Task();
    final taskEncoded = Uint8List(0); 

    when(addTaskDatasourceExternal.saveTask(any))
      .thenThrow(const ExternalError('erro'));

    try {
      await addTaskDatasourceExternal.saveTask(taskEncoded);
    } catch (e) {
      expect(e, isA<ExternalError>());
    }
  });


  test('Sucesso', () async {
    interceptorSectorNames(200, 'body');

  final task = Task();
  final taskEncoded = Uint8List(0);

  when(addTaskDatasourceExternal.saveTask(any))
    .thenAnswer((_) async => (true, null)); 

  final (result, erro) = await addTaskDatasourceExternal.saveTask(taskEncoded);
  expect(result, true);
});

}
