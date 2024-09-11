import 'package:mobx/mobx.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/usecases/login_use_case.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/comm_packages/proto/user.pb.dart';

part 'sign_in_store.g.dart';

class FormStore = IFormStore with _$FormStore;

abstract class IFormStore with Store {
  final LoginUseCase loginUseCase;

  IFormStore(this.loginUseCase);

  String username = '';

  String password = '';

  @observable
  bool isLoading = false;

  @observable
  bool isLogged = false;

  @observable
  String errorMessage = '';

  @observable
  bool navigatePage = false;

  @observable
  User? loggedUser;

  @action
  void linkToPage() {
    navigatePage = true;
  }

  @action
  void setUsername(String value) {
    username = value;
    clearErrorMessage();  
  }

  @action
  void setPassword(String value) {
    password = value;
    clearErrorMessage();  
  }

  @computed
  bool get isValid => password.isNotEmpty && username.isNotEmpty;

  @action
  void clearErrorMessage() {
    errorMessage = '';  
  }

  @action
  Future<void> doLogin() async {
    if (username.isEmpty || password.isEmpty) {
      errorMessage = 'Please fill in all fields correctly';
      return;
    }

    isLoading = true;
    clearErrorMessage();

    try {
      final (error, user) = await loginUseCase.execute(username, password); 

      if (error != null) {
        errorMessage = error.message; 
        return;
      }

      if (user != null) {
        loggedUser = user;
        isLogged = true;
      } else {
        errorMessage = 'User not found';
      }
    } catch (e) {
      errorMessage = 'Unexpected error: ${e.toString()}';
    } finally {
      isLoading = false;
    }
  }

}
