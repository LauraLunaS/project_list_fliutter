import 'dart:typed_data';
import 'package:project_list_fliutter/src/modules/auth/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/auth/infra/comm_packages/proto/user.pb.dart';

class AuthAdapter {
  static User? decodeProto(Uint8List? encodedUserProto) {
    try {
      if (encodedUserProto != null) {
        return User.fromBuffer(encodedUserProto);
      }
      return null;  
    } catch (e) {
      throw Error();
    }
  }

  static Uint8List encodeProto(User userModel) {
    try {
      return userModel.writeToBuffer();
    } catch (e) {
      throw const InfraError('Erro de Infraestrutura');
    }
  }
}