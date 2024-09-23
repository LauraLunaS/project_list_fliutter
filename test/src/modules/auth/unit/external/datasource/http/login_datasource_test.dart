import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nock/nock.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/auth/external/datasources/http/login_datasource_external.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/comm_packages/proto/user.pb.dart';
import 'package:project_list_fliutter/src/modules/auth/external/datasources/server_routes.dart';

import 'login_datasource_test.mocks.dart';  

@GenerateMocks([LoginDatasourceExternal])  
void main() {
  late MockLoginDatasourceExternal mockLoginDatasourceExternal;  

  setUpAll(() {
    nock.init();  
  });

  setUp(() {
    mockLoginDatasourceExternal = MockLoginDatasourceExternal(http.Client());
    nock.cleanAll();  
  });

  dynamic interceptorSectorNames(int statusCode, dynamic body) {
    final interceptor = nock(serverAdrees).post('/login')
      ..reply(
        statusCode,
        body,
      );
    return interceptor;
  }

  test('Erro 400', () async {
    interceptorSectorNames(400, 'Invalid credentials');

    final user = User();

    when(mockLoginDatasourceExternal.login(user.name, user.password))
        .thenThrow(CredentialsError('Invalid credentials'));

    try {
      await mockLoginDatasourceExternal.login(user.name, user.password);
    } catch (e) {
      expect(e, isA<CredentialsError>());
    }
  });

  test('Sucesso', () async {
    interceptorSectorNames(200, 'Login successful');

    final user = User();

    when(mockLoginDatasourceExternal.login(user.name, user.password))
        .thenAnswer((_) async => (user, null)); 

    final (result, error) = await mockLoginDatasourceExternal.login(user.name, user.password);

    expect(result, isA<User?>());
    expect(error, null);  
  });
}
