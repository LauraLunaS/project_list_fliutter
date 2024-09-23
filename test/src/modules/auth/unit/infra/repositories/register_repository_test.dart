import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/comm_packages/proto/user.pb.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/repositories/register_repository.dart';

import 'register_repository_test.mocks.dart';

@GenerateMocks([RegisterRepositoryImpl])

void main() {
  late RegisterRepositoryImpl repository;
  late MockIRegisterDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockIRegisterDatasource();
    repository = RegisterRepositoryImpl(mockDatasource);
  });

  test('Autenticação realizada com sucesso', () async {
    final user = User();

    when(repository.register(user.name, user.password))
      .thenAnswer((_) async => (true, null));

    final (result, erro) = await repository.register(user.name, user.password);
    
    expect(result, true);
    expect(erro, null);
  });

  test('Erro de autenticação', () async {
    final user = User();
    const error = CredentialsError('Invalid response from the server');

    when(repository.register(user.name, user.password))
      .thenAnswer((_) async => (false, error));

    final (result, erro) = await repository.register(user.name, user.password);

    expect(erro, null);
  });
}
