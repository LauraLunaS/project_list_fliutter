import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/comm_packages/proto/user.pb.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/adapters/auth_adapter.dart';
import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';

void main() {
  group('AuthAdapter', () {
    test('deve decodificar corretamente o proto User', () {
      final user = User()
        ..id = '1'
        ..name = 'laura'
        ..password = '123';
      
      final encodedUser = user.writeToBuffer();

      final decodedUser = AuthAdapter.decodeProto(encodedUser);

      expect(decodedUser, isNotNull);
      expect(decodedUser?.id, '1');
      expect(decodedUser?.name, 'laura');
      expect(decodedUser?.password, '123');
    });

    test('deve retornar null se encodedUserProto for null', () {
      final result = AuthAdapter.decodeProto(null);
      expect(result, isNull);
    });

    test('deve lançar InfraError ,se a decodificação falhar', () {
      final invalidEncodedUser = Uint8List.fromList([1, 2, 3, 4]);

      expect(() => AuthAdapter.decodeProto(invalidEncodedUser), throwsA(isA<InfraError>()));
    });
  });
}
