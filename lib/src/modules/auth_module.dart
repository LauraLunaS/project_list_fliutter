import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:project_list_fliutter/src/modules/auth/domain/repositories/login_repository.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/repositories/register_repository.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/usecases/login_use_case.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/usecases/register_use_case.dart';
import 'package:project_list_fliutter/src/modules/auth/external/datasources/http/login_datasource_external.dart';
import 'package:project_list_fliutter/src/modules/auth/external/datasources/http/register_datasource_external.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/datasources/login_datasource.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/datasources/register_datasource.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/repositories/login_repository.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/repositories/register_repository.dart';
import 'package:project_list_fliutter/src/modules/auth/presenter/pages/sign_in.dart';
import 'package:project_list_fliutter/src/modules/auth/presenter/pages/sign_up.dart';
import 'package:project_list_fliutter/src/modules/auth/presenter/stores/sign_in_store.dart';
import 'package:project_list_fliutter/src/modules/auth/presenter/stores/sign_up_store.dart';
import 'package:project_list_fliutter/src/modules/tasks_module.dart';

class AuthModule extends Module {
  @override
  void binds(i) {
    i.add(http.Client.new);

    //datasource

    i.add<ILoginDatasource>(LoginDatasourceExternal.new);
    i.add<IRegisterDatasource>(RegisterDatasourceExternal.new);

    //repository

    i.add<IRegisterRepository>(RegisterRepositoryImpl.new);
    i.add<ILoginRepository>(LoginRepositoryImpl.new);

    //use-case

    i.add<RegisterUseCase>(RegisterUseCase.new);
    i.add<LoginUseCase>(LoginUseCase.new);

    //store

    i.addSingleton<SignUpStore>(SignUpStore.new);
    i.addSingleton<FormStore>(FormStore.new);
  }

  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (context) => const SignInPage());
    r.child('/sign_in', child: (context) => const SignInPage());
    r.child('/sign_up', child: (context) => const SignUpPage());
    r.module('/tasks/', module: TaskModule());
  }
}
