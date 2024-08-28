import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/repositories/login_repository.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/adapters/auth_adapter.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/comm_packages/proto/user.pb.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/datasources/login_datasource.dart';

class LoginRepositoryImpl implements ILoginRepository {
  final ILoginDatasource datasource;

  LoginRepositoryImpl(this.datasource);

  @override
  Future<(User?, CredentialsError?)> login(String username, String password) async {
    try {
      final userProto = await datasource.login(username, password);
      if (userProto is User) {
         final userModel = AuthAdapter.decodeProto((userProto as User).writeToBuffer());
        return (userModel, null);
      } else {
        throw CredentialsError('Invalid response type');
      }
    } catch (e) {
      throw Error();
    }
  }

}
