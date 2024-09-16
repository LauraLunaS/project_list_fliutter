import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:nock/nock.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/auth/external/datasources/http/login_datasource_external.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/comm_packages/proto/user.pb.dart';
import 'package:project_list_fliutter/src/modules/auth/external/datasources/server_routes.dart';

@GenerateMocks([LoginDatasourceExternal])
void main() {
  late LoginDatasourceExternal loginDatasourceExternal;

  setUpAll(() {
    nock.init();
  });

  setUp(() {
    loginDatasourceExternal = LoginDatasourceExternal(http.Client());
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

  test('Erro 400', () async {
    interceptorSectorNames(400, 'body');

    final user = User();

    try {
      await loginDatasourceExternal.login(user.name, user.password);
    } catch (e) {
      expect(e, isA<CredentialsError>);
    }
  });

  test('Sucesso', () async {
    interceptorSectorNames(200, true);

    final user = User();

    final result = await loginDatasourceExternal.login(user.name, user.password);

    // expect(true, null); 
    expect(result, true); 
    // expect(result, true);
    
  });
}
