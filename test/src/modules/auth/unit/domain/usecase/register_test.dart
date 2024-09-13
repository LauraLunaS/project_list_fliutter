import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/comm_packages/proto/user.pb.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/repositories/register_repository.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/usecases/register_use_case.dart';

import 'register_test.mocks.dart';

@GenerateMocks([IRegisterRepository])
void main() {
  late IRegisterRepository registerRepository;
  late RegisterUseCase registerUseCase;

  setUp(() {
    registerRepository = MockIRegisterRepository();
    registerUseCase = RegisterUseCase(registerRepository);
  });

  test('Autenticação com sucesso', () async {

    final user = User();
    
    when(registerRepository.register(user.name, user.password))
        .thenAnswer((_) async => (true, null));

    final (result, registerError) = await registerUseCase.execute(user.name, user.password);

    expect(registerError, null);  // nao deve haver erro
    expect(result, true);   // o resultado deve conter um objeto User
    expect(result, true);        // o resultado deve ser o mesmo User retornado
  });


  test('Erro de autenticação', () async {
    final user = User(); 
    const error = AuthError('Invalid response from the server');

    when(registerRepository.register(user.name, user.password))
        .thenAnswer((_) async => (true, error));

    final (result, loginError) = await registerUseCase.execute(user.name, user.password);

    //loginErro não é nulo
    expect(loginError, isNotNull);

    // garante que o erro retornado seja exatamente o credentialsError
    expect(loginError, error);

    //confirma que o result é null
    expect(result, true);
  });
}
