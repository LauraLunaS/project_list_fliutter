import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:nock/nock.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/auth/external/datasources/http/register_datasource_external.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/comm_packages/proto/user.pb.dart';
import 'package:project_list_fliutter/src/modules/auth/external/datasources/server_routes.dart';

@GenerateMocks([RegisterDatasourceExternal])
void main() {
  late RegisterDatasourceExternal registerDatasourceExternal;

  setUpAll(() {
    nock.init();
  });

  setUp(() {
    registerDatasourceExternal = RegisterDatasourceExternal(http.Client());
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
      await registerDatasourceExternal.register(user.name, user.password);
    } catch (e) {
      expect(e, isA<CredentialsError>);
    }
  });

  test('Sucesso', () async {
    interceptorSectorNames(200, true);

    final user = User();

    final result = await registerDatasourceExternal.register(user.name, user.password);

    // expect(true, null); 
    expect(result, true); 
    // expect(result, true);
    
  });
}
