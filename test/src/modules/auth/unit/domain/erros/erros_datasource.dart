import 'package:flutter_test/flutter_test.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';

void main() {
  late DomainError domainError;
  late ExternalError externalError;
  late InfraError infraError;
  late AuthError authError;
  late CredentialsError credentialsError;

  test(
    'Deve retornar uma instância de DomainError',
    () {
      domainError = const DomainError('Domain Error');
      expect(domainError, isA<DomainError>());
    },
  );

  test(
    'Deve retornar uma instância de ExternalError',
    () {
      externalError = const ExternalError('External Error');
      expect(externalError, isA<ExternalError>());
    },
  );

  test(
    'Deve retornar uma instância de InfraError',
    () {
      infraError = const InfraError('Infra Error');
      expect(infraError, isA<InfraError>());
    },
  );

  test(
    'Deve retornar uma instância de AuthError',
    () {
      authError = const AuthError('Auth Error');
      expect(authError, isA<AuthError>());
    },
  );

  test(
    'Deve retornar uma instância de InfraError',
    () {
      credentialsError = const CredentialsError('Credentials Error');
      expect(credentialsError, isA<CredentialsError>());
    },
  );
}
