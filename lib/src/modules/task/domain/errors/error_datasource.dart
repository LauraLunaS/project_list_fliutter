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

class ExternalError extends TasksError {
  const ExternalError(super.message, [super.stackTrace]);
}

class GetTaskError extends TasksError {
  const GetTaskError(super.message, [super.stackTrace]);
}

class CreateTaskError extends TasksError {
  const CreateTaskError(super.message, [super.stackTrace]);
}

// class RemoveTaskError extends TasksError {
//   const RemoveTaskError(super.message, [super.stackTrace]);
// }

