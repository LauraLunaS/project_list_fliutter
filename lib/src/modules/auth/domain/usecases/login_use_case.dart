import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/comm_packages/proto/user.pb.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/repositories/login_repository.dart';

class LoginUseCase {
  final ILoginRepository repository;

  LoginUseCase(this.repository);

  Future<User?> execute(String username, String password) async {
    try {
      final (user, error) = await repository.login(username, password);
      if (error != null) {
        throw error;
      }
      if (user == null) {
        throw const CredentialsError('Invalid response from the server');
      }
      return user;
    } catch (e) {
      throw AuthError('Unexpected error during login: ${e.toString()}');
    }
  }
}
