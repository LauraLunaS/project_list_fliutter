import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_list_fliutter/src/modules/task/infra/comm_packages/proto/pb/tasks.pb.dart';
import 'package:project_list_fliutter/src/modules/task/infra/adapters/task_adapter.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';

void main() {
  group('TaskAdapter', () {
    test('deve decodificar corretamente o proto User', () {
      final task = Task()
        ..id = '1'
        ..userId = '1'
        ..task = 'tarefa';
      
      final encodedUser = task.writeToBuffer();

      final decodedUser = TaskAdapter.decodeProto(encodedUser);

      expect(decodedUser, isNotNull);
      expect(decodedUser?.id, '1');
      expect(decodedUser?.userId, '1');
      expect(decodedUser?.task, 'tarefa');
    });

    test('deve retornar null se encodedUserProto for null', () {
      final result = TaskAdapter.decodeProto(null);
      expect(result, isNull);
    });

    test('deve lançar InfraError ,se a decodificação falhar', () {
      final invalidEncodedUser = Uint8List.fromList([]);

      expect(() => TaskAdapter.decodeProto(invalidEncodedUser), throwsA(isA<InfraError>()));
    });
  });
}
