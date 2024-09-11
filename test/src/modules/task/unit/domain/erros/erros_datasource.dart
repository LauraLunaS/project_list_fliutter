import 'package:flutter_test/flutter_test.dart';
import 'package:project_list_fliutter/src/modules/task/domain/errors/error_datasource.dart';

void main() {
  late DomainError domainError;
  late ExternalError externalError;
  late InfraError infraError;
  late CreateTaskError createTaskError;
  late GetTaskError getTaskError;

  test(
    'Deve retornar uma instância de DomainError',
    () {
      domainError = const DomainError('Domain Error');
      expect(domainError, isA<DomainError>());
    },
  );

  test(
    'Deve retornar uma instância de ExternalError',
    () {
      externalError = const ExternalError('External Error');
      expect(externalError, isA<ExternalError>());
    },
  );

  test(
    'Deve retornar uma instância de InfraError',
    () {
      infraError = const InfraError('Infra Error');
      expect(infraError, isA<InfraError>());
    },
  );

  test(
    'Deve retornar uma instância de CreateError',
    () {
      createTaskError = const CreateTaskError('Create Task Error');
      expect(createTaskError, isA<CreateTaskError>());
    },
  );

  test(
    'Deve retornar uma instância de CreateError',
    () {
      getTaskError = const GetTaskError('Get Task Error');
      expect(getTaskError, isA<GetTaskError>());
    },
  );

}
