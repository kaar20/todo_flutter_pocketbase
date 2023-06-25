// import 'dart:html';

import 'package:pocketbase/pocketbase.dart';

class pbase {
  final pb = PocketBase('http://10.0.2.2:8090');
  // final pb = PocketBase('http://127.0.0.1:8090');
  Future Register(String username, String email, String pass, String cf) async {
    final body = <String, dynamic>{
      "username": username,
      "email": email,
      "emailVisibility": true,
      "password": pass,
      "passwordConfirm": cf,
      "name": "test"
    };

    final record = await pb.collection('users').create(body: body);
    return record;
  }

  Future registerTask(String TaskName, String TaskDes, String fk) async {
    final data = <String, String>{
      "TaskName": TaskName,
      "TaskDescription": TaskDes,
      "fk_id": fk,
    };

    final TaskInfo = await pb.collection('Tasks').create(body: data);
    return TaskInfo;
  }

  Future updating(String TN, String TD, String fk, String id) async {
    final body = <String, dynamic>{
      "TaskName": TN,
      "TaskDescription": TD,
      "fk_id": fk
    };

    final record = await pb.collection('Tasks').update(id, body: body);
    return record;
  }

  Future deleting(String id) async {
    // final del_record = await pb.collection('Tasks').delete(id);
    final record = await pb.collection('Tasks').getList();
    for (var i in record.items) {
      var fk_id = i.getStringValue('fk_id');
      if (fk_id == id) {
        // print(id);
        var task_id = i.id;
        final del_record = await pb.collection('Tasks').delete(task_id);
        // print(i.id);

      }
      // print(id);
    }

    final sub_del = await pb.collection('sub_user').delete(id);
    // del_record
  }
}
