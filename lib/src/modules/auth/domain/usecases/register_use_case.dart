import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/repositories/register_repository.dart'; 

class RegisterUseCase {
  final IRegisterRepository repository;

  RegisterUseCase(this.repository);

  Future<(bool?, CredentialsError?)> execute(String username, String password) async {
    try {
      final (success, error) = await repository.register(username, password);
      return (success, error);
      
    } on ExternalError catch (e) {
      return (null, CredentialsError('Failed to register: ${e.message}', e.stackTrace));

    } catch (e, stackTrace) {
      return (null, CredentialsError('Unexpected error during registration', stackTrace));
    }
  }
}
