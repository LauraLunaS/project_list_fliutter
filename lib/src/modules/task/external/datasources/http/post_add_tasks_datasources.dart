import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:project_list_fliutter/src/modules/task/domain/errors/error_datasource.dart';
import 'package:project_list_fliutter/src/modules/task/external/datasources/server_routes.dart';
import 'package:project_list_fliutter/src/modules/task/infra/datasources/save_task_datasource.dart';

class PostAddTasksDatasource implements ISaveTaskDatasource {
  final http.Client client;

  PostAddTasksDatasource(this.client);

  @override
  Future<bool?> saveTask(Uint8List taskEncoded) async {
    try {
      final res = await client.post(
        Uri.parse(addTaskRoute),
        body: taskEncoded,
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        throw ExternalError('Failed to add task: Status code ${res.statusCode}');
      }
    } catch (e) {
      throw ExternalError('Error connecting to the server: $e');
    }
  }
}
