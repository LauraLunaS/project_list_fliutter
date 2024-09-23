import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nock/nock.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/auth/external/datasources/http/register_datasource_external.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/comm_packages/proto/user.pb.dart';
import 'package:project_list_fliutter/src/modules/auth/external/datasources/server_routes.dart';

import 'register_datasource_test.mocks.dart';

@GenerateMocks([RegisterDatasourceExternal])
void main() {
  late MockRegisterDatasourceExternal registerDatasourceExternal;

  setUpAll(() {
    nock.init();
  });

  setUp(() {
    registerDatasourceExternal = MockRegisterDatasourceExternal(http.Client());
    nock.cleanAll();
  });

  dynamic interceptorSectorNames(int statusCode, dynamic body) {
    final interceptor = nock(serverAdrees).post('/sign_up_user')
      ..reply(
        statusCode,
        body,
      );
    return interceptor;
  }

  test('Sucesso', () async {
    interceptorSectorNames(200, 'Register successful');

    final user = User();

    when(registerDatasourceExternal.register(user.name, user.password))
        .thenAnswer((_) async => (true, null)); 

    final (result, error) = await registerDatasourceExternal.register(user.name, user.password);

    expect(result, true);
    expect(error, null);  
  });

   test('Erro 400', () async {
    interceptorSectorNames(400, 'Invalid credentials');

    final user = User();

    when(registerDatasourceExternal.register(user.name, user.password))
        .thenThrow(CredentialsError('Invalid credentials'));

    try {
      await registerDatasourceExternal.register(user.name, user.password);
    } catch (e) {
      expect(e, isA<CredentialsError>());
    }
  });

}
