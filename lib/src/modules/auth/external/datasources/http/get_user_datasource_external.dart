import 'package:http/http.dart' as http;
import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/comm_packages/proto/user.pb.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/adapters/auth_adapter.dart';
import 'package:project_list_fliutter/src/modules/auth/external/datasources/server_routes.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/datasources/get_user_datasource.dart';


class GetUserDatasourceExternal implements IGetUserDatasource {
    final http.Client client;

    GetUserDatasourceExternal(this.client);

    @override
    Future<User?> getCurrentUser() async {
      try {
        final uri = Uri.parse(signOUUserRoute);
        final response = await client.get(uri);

        if (response.statusCode == 200) {
          final userProto = response.bodyBytes;
          return AuthAdapter.decodeProto(userProto);
        } else if (response.statusCode == 204) {
          throw const ExternalError('O servidor atendeu à solicitação com êxito e não há conteúdo adicional a ser enviado na resposta.');
        } else {
          throw const ExternalError('Falha ao obter o usuário atual.');
        }
      } catch (e) {
        throw const ExternalError('Não foi possível obter o usuário atual.');
      }
    }

}