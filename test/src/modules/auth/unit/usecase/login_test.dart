import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/comm_packages/proto/user.pb.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/repositories/login_repository.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/usecases/login_use_case.dart';

import 'login_test.mocks.dart';

@GenerateMocks([ILoginRepository])
void main() {
  late ILoginRepository loginRepository;
  late LoginUseCase loginUseCase;

  setUp(() {
    loginRepository = MockILoginRepository();
    loginUseCase = LoginUseCase(loginRepository);
  });

  test('Login com sucesso', () async {
    final user = User(); 
    const error = CredentialsError('Aaa');
    
    when(loginRepository.login(user.name, user.password))
        .thenAnswer((_) async => ((user, null)));

    final result = await loginUseCase.execute(user.name, user.password);

    expect(error, null);
    expect(result, isNotNull);
    expect(result, user);  
  });

  test('Erro de credenciais', () async {
    final user = User(); 
    const error = CredentialsError('Invalid response from the server');

    when(loginRepository.login(user.name, user.password))
        .thenAnswer((_) async => (null, error));

    final (loginError, result) = await loginUseCase.execute('wrong_username', 'wrong_password');

    expect(loginError, isNotNull);
    expect(loginError, error);
    expect(result, isNull);
  });
}
