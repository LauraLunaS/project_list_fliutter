import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/comm_packages/proto/user.pb.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/repositories/login_repository.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/datasources/login_datasource.dart';

class MockILoginDatasource extends Mock implements ILoginDatasource {}

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
    
    when(mockDatasource.login(user.name, user.password))
        .thenAnswer((_) async => (user, error));

    final result = await mockDatasource.login(user.name, user.password);
      
    expect(result.$1, user); 
  });

  test('Erro de credenciais', () async {
    final user = User(); 
    const error = CredentialsError('Invalid response from the server');

    when(mockDatasource.login(user.name, user.password))
        .thenAnswer((_) async => (null, error));

    final (result, loginError) = await repository.login(user.name, user.password);

    expect(loginError, isNotNull); // loginError não deve ser nulo
    expect(loginError, error);     // o erro retornado deve ser o CredentialsError simulado
    expect(result, isNull);       // o resultado deve ser nulo
  });
}
