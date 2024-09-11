
import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';

abstract class IRegisterDatasource {
  Future<(bool?, CredentialsError?)> register(String username, String password);
}
