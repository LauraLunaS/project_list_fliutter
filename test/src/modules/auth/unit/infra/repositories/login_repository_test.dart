import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/comm_packages/proto/user.pb.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/repositories/login_repository.dart';

import 'login_repository_test.mocks.dart';

@GenerateMocks([LoginRepositoryImpl])

void main() {
  late LoginRepositoryImpl repository;
  late MockILoginDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockILoginDatasource();
    repository = LoginRepositoryImpl(mockDatasource);
  });

  test('Login com sucesso', () async {
    final user = User();
    const error = CredentialsError('Ivalid');
    
    when(repository.login(user.name, user.password))
        .thenAnswer((_) async => (user, error));

    final (result, erro) = await repository.login(user.name, user.password);
      
    expect(result, user);
    expect(erro, error);
  });

  test('Erro de credenciais', () async {
    final user = User(); 
    const error = CredentialsError('Invalid response from the server');

    when(repository.login(user.name, user.password))
        .thenAnswer((_) async => (null, error));

    final (result, loginError) = await repository.login(user.name, user.password);

    expect(result, null);
    expect(loginError, error);
  
  });
}
