import 'package:http/http.dart' as http;
import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/comm_packages/proto/user.pb.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/adapters/auth_adapter.dart';
import 'package:project_list_fliutter/src/modules/auth/external/datasources/server_routes.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/datasources/register_datasource.dart';

class RegisterDatasourceExternal implements IRegisterDatasource {
  final http.Client client;

  RegisterDatasourceExternal(this.client);

  @override
  Future<(bool?, CredentialsError?)> register(String username, String password) async {
    try {
      final userProto = User()
        ..name = username
        ..password = password;

      final uri = Uri.parse(signOUUserRoute);

      final response = await client.post(
        uri,
        body: AuthAdapter.encodeProto(userProto),
      );

      // !!! qtd de else
      if (response.statusCode == 200) {
        final responseBodyString = String.fromCharCodes(response.bodyBytes);
        if (responseBodyString == 'Registration successful') {
          return (true, null); 
        } else {
          return (false, CredentialsError('Registration failed: $responseBodyString'));
        }
      } else {
        return (false, CredentialsError('Failed to register. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      return (false, CredentialsError('Failed to register: ${e.toString()}'));
    }
  }
}

