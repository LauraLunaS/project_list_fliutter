import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/comm_packages/proto/user.pb.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/repositories/login_repository.dart';

abstract class ILoginRecovery {
  Future<(CredentialsError?, User?)> execute(String username, String password);
}

class LoginUseCase implements ILoginRecovery {
  final ILoginRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<(CredentialsError?, User?)> execute(String username, String password) async {
    try {
      final (user, error) = await repository.login(username, password);
      if (error != null) {
        return (error, null);  
      }
      if (user == null) {
        return (const CredentialsError('Invalid response from the server'), null);  
      }
      return (null, user);  
    } catch (e) {
      throw AuthError('Unexpected error during login: ${e.toString()}');
    }
  }
}
