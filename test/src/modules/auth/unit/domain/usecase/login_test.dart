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
    
    when(loginRepository.login(user.name, user.password))
        .thenAnswer((_) async => (user, null));

    final (loginError, result) = await loginUseCase.execute(user.name, user.password);

    expect(loginError, isNull);  // nao deve haver erro
    expect(result, isNotNull);   // o resultado deve conter um objeto User
    expect(result, user);        // o resultado deve ser o mesmo User retornado
  });


  test('Erro de credenciais', () async {
    final user = User(); 
    const error = CredentialsError('Invalid response from the server');

    when(loginRepository.login(user.name, user.password))
        .thenAnswer((_) async => (null, error));

    final (loginError, result) = await loginUseCase.execute(user.name, user.password);

    //loginErro não é nulo
    expect(loginError, isNotNull);

    // garante que o erro retornado seja exatamente o credentialsError
    expect(loginError, error);

    //confirma que o result é null
    expect(result, isNull);
  });
}
