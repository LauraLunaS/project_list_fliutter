import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/repositories/register_repository.dart'; 

abstract class IRegisterUser {
   Future<(bool?, AuthError?)> execute(String username, String password);
}

class RegisterUseCase implements IRegisterUser {
  final IRegisterRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<(bool?, AuthError?)> execute(String username, String password) async {
    try {
      final (success, error) = await repository.register(username, password);
      return (success, error);
      
    } on ExternalError catch (e) {
      return (null, AuthError('Failed to register: ${e.message}', e.stackTrace));

    } catch (e, stackTrace) {
      return (null, AuthError('Unexpected error during registration', stackTrace));
    }
  }
  

}
