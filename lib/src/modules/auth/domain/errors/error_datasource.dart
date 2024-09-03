abstract class IAuthError {
  String get message;
  StackTrace? get stackTrace;
}

class AuthError implements IAuthError {
  @override
  final String message;
  @override
  final StackTrace? stackTrace;

  const AuthError(this.message, [this.stackTrace]);
}

// erro de camadas

class DomainError extends AuthError {
  const DomainError(super.message, [super.stackTrace]);
}

class ExternalError extends AuthError {
  const ExternalError(super.message, [super.stackTrace]);
}

class InfraError extends AuthError {
  const InfraError(super.message, [super.stackTrace]);
}

// erro de processo 

class CredentialsError extends AuthError {
  const CredentialsError(super.message, [super.stackTrace]);
}