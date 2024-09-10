abstract class ITasksError {
  String get message;
  StackTrace? get stackTrace;
}

class TasksError implements ITasksError {
  @override
  final String message;
  @override
  final StackTrace? stackTrace;

  const TasksError(this.message, [this.stackTrace]);
}

class GetTaskError extends TasksError {
  const GetTaskError(super.message, [super.stackTrace]);
}

class CreateTaskError extends TasksError {
  const CreateTaskError(super.message, [super.stackTrace]);
}


class DomainError extends TasksError {
  const DomainError(super.message, [super.stackTrace]);
}

class ExternalError extends TasksError {
  const ExternalError(super.message, [super.stackTrace]);
}

class InfraError extends TasksError {
  const InfraError(super.message, [super.stackTrace]);
}


