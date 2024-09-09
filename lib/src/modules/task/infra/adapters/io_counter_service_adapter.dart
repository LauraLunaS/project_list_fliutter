import 'dart:typed_data';
import 'package:project_list_fliutter/src/modules/task/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/task/infra/comm_packages/proto/pb/tasks.pb.dart';

class ServiceStatusAdapter {
  static Tasks decodeProto(Uint8List encodeListServiceStatusProto) {
    try {
      final serviceStatus =
          Tasks.fromBuffer(encodeListServiceStatusProto);
      return serviceStatus;
    } catch (e) {
      throw InfraError("Error decoding service status: $e");
    }
  }
}
