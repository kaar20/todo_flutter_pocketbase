import 'package:flutter/material.dart';
import 'package:todo/pocketbase.dart';
import 'package:pocketbase/pocketbase.dart';

class shaqale extends StatefulWidget {
  // const dash({super.key});
  var CurrentUserID;
  shaqale({@required this.CurrentUserID});
  // final String CurrentUserID:

  @override
  State<shaqale> createState() => _shaqale();
}

class _shaqale extends State<shaqale> {
  bool isCreated = false;
  pbase pb = pbase();
  final pocketb = PocketBase('http://10.0.2.2:8090');
  // final pocketb = PocketBase('http://127.0.0.1:8090');

  TextEditingController TaskName = TextEditingController();
  TextEditingController TaskDesc = TextEditingController();
  TextEditingController up = TextEditingController();
  var Tasks = [];
  var TaskDes = [];
  var ids = [];
  var fks = [];
  bool Clicked = true;
  bool notClick = false;
  var tappedID;
  var fkID;

  var locked = [];

  Future getPost() async {
    final pb = PocketBase('http://10.0.2.2:8090');
    final result = await pb.collection('Tasks').getList();

    for (var i in result.items) {
      var TName = i.getStringValue('TaskName');
      var TDesc = i.getStringValue('TaskDescription');
      var fk = i.getStringValue('fk_id');
      var id = i.id;
      bool isLock = i.getBoolValue('locked');

      // if (widget.CurrentUserID == fk) {
      if (Tasks.contains(TName) == false && widget.CurrentUserID == fk) {
        Tasks.add(TName);
        TaskDes.add(TDesc);
        ids.add(id);
        fks.add(fk);
        locked.add(isLock);
        // }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Icon(
              Icons.arrow_back,
            )),
        backgroundColor: Colors.deepPurpleAccent,
        automaticallyImplyLeading: false,
        title: Text('Your Tasks Panel'),
      ),
      body: Center(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: FutureBuilder(
                future: pocketb.collection('Tasks').getList(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Text('Loading....');
                    default:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      return ListView.builder(
                        itemCount: Tasks.length,
                        itemBuilder: (context, index) {
                          // return
                          return ListTile(
                              leading: CircleAvatar(child: Text('$index')),
                              title: locked[index]
                                  ? ListTile(
                                      title: Text(Tasks[index],
                                          style: TextStyle(
                                              fontSize: 20,
                                              decoration: locked[index]
                                                  ? TextDecoration.lineThrough
                                                  : null)),
                                      trailing: Icon(
                                        Icons.timer_off_outlined,
                                        size: 20,
                                        color: Colors.red,
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder:
                                                (context) =>
                                                    StatefulBuilder(builder:
                                                        (context, setState) {
                                                      return AlertDialog(
                                                          insetPadding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          //  padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                                                          actions: [
                                                            Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                height: 300,
                                                                width: double
                                                                    .infinity,
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      ListTile(
                                                                        title: Text(
                                                                            Tasks[index]),
                                                                        subtitle:
                                                                            Text(
                                                                          TaskDes[
                                                                              index],
                                                                          style:
                                                                              TextStyle(fontSize: 18),
                                                                        ),
                                                                      )
                                                                    ]))
                                                          ]);
                                                    }));
                                      },
                                      child: Text(
                                        Tasks[index],
                                        style: TextStyle(fontSize: 18),
                                      )));
                        },
                      );
                  }
                },
              ))),
    );
  }
}
