import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:project_list_fliutter/src/modules/task/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/task/infra/comm_packages/proto/pb/tasks.pb.dart';
import 'package:project_list_fliutter/src/modules/task/domain/repositories/get_task_repository.dart';
import 'package:project_list_fliutter/src/modules/task/domain/usecases/get_task_use_case.dart';

import 'get_task_test.mocks.dart';

@GenerateMocks([IGetTaskRepository])

void main() {
  late IGetTaskRepository getTaskRepository;
  late GetTaskUseCase getTaskUseCase;

  setUp(() {
    getTaskRepository = MockIGetTaskRepository();
    getTaskUseCase = GetTaskUseCase(getTaskRepository);
  });

  test('Tarefas buscadas com sucesso', () async {
    final task = Task();

    when(getTaskRepository.getTasks(task.userId))
      .thenAnswer((_) async => ([task]));
    
    final result = await getTaskUseCase.getTasks(task.userId);

    // Valida que o resultado é uma lista não nula e contém a tarefa esperada
    expect(result, isNotNull);
    expect(result, isA<List<Task>>());
    expect(result.length, equals(1)); // Verifica se há apenas um item na lista
    expect(result.first, equals(task)); // Verifica se o primeiro item da lista é o task mockado
  });

  // test('Erro ao buscar tarefas', () async {
  //   final task = Task();
  //   const error = GetTaskError('Invalid response from the server');

  //   when(getTaskRepository.getTasks(task.userId))
  //     .thenAnswer((_) async => ([task]));
    
  //   final result = await getTaskUseCase.getTasks(task.userId);

  //   //verfica se é null 
  //   expect(result, isEmpty);

  // });

}