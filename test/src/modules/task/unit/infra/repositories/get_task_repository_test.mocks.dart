// Mocks generated by Mockito 5.4.4 from annotations
// in project_list_fliutter/test/src/modules/task/unit/infra/repositories/get_task_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:project_list_fliutter/src/modules/task/infra/comm_packages/proto/pb/tasks.pb.dart'
    as _i5;
import 'package:project_list_fliutter/src/modules/task/infra/datasources/get_all_tasks_datasource.dart'
    as _i2;
import 'package:project_list_fliutter/src/modules/task/infra/repositories/get_task_repository.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeIGetAllTasksDatasource_0 extends _i1.SmartFake
    implements _i2.IGetAllTasksDatasource {
  _FakeIGetAllTasksDatasource_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetTaskRepositoryImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTaskRepositoryImpl extends _i1.Mock
    implements _i3.GetTaskRepositoryImpl {
  MockGetTaskRepositoryImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.IGetAllTasksDatasource get datasource => (super.noSuchMethod(
        Invocation.getter(#datasource),
        returnValue: _FakeIGetAllTasksDatasource_0(
          this,
          Invocation.getter(#datasource),
        ),
      ) as _i2.IGetAllTasksDatasource);

  @override
  _i4.Future<List<_i5.Task?>> getTasks(String? userId) => (super.noSuchMethod(
        Invocation.method(
          #getTasks,
          [userId],
        ),
        returnValue: _i4.Future<List<_i5.Task?>>.value(<_i5.Task?>[]),
      ) as _i4.Future<List<_i5.Task?>>);
}

/// A class which mocks [IGetAllTasksDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockIGetAllTasksDatasource extends _i1.Mock
    implements _i2.IGetAllTasksDatasource {
  MockIGetAllTasksDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i5.Task?>> getAllTasks(String? userId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllTasks,
          [userId],
        ),
        returnValue: _i4.Future<List<_i5.Task?>>.value(<_i5.Task?>[]),
      ) as _i4.Future<List<_i5.Task?>>);
}
