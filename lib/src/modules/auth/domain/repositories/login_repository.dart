import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/comm_packages/proto/user.pb.dart';

abstract class ILoginRepository {
  Future <(User?, CredentialsError?)> login(String username, String password);  
}
