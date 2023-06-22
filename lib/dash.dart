// import 'dart:html';

// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:todo/pocketbase.dart';
import 'package:pocketbase/pocketbase.dart';

class dash extends StatefulWidget {
  // const dash({super.key});
  var CurrentUserID;
  dash({@required this.CurrentUserID});
  // final String CurrentUserID:

  @override
  State<dash> createState() => _dashState();
}

class _dashState extends State<dash> {
  bool isCreated = false;
  pbase pb = pbase();
  final pocketb = PocketBase('http://10.0.2.2:8090');

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

  Future getPost() async {
    final pb = PocketBase('http://10.0.2.2:8090');
    final result = await pb.collection('Tasks').getList();

    for (var i in result.items) {
      var TName = i.getStringValue('TaskName');
      var TDesc = i.getStringValue('TaskDescription');
      var fk = i.getStringValue('fk_id');
      var id = i.id;

      // if (widget.CurrentUserID == fk) {
      if (Tasks.contains(TName) == false && widget.CurrentUserID == fk) {
        Tasks.add(TName);
        TaskDes.add(TDesc);
        ids.add(id);
        fks.add(fk);
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
        backgroundColor: Colors.deepPurpleAccent,
        automaticallyImplyLeading: false,
        title: Center(child: Text('Your Tasks Panel')),
      ),
      body: Center(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: isCreated
                  ? ListView(
                      children: [
                        Form(
                            child: Column(
                          children: [
                            TextFormField(
                              controller: TaskName,
                              decoration:
                                  InputDecoration(label: Text('Task_Name')),
                            ),
                            TextFormField(
                              controller: TaskDesc,
                              decoration: InputDecoration(
                                label: Text("Define Your Task"),
                              ),
                            )
                          ],
                        )),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isCreated = false;
                              });

                              final createNew = await pb.registerTask(
                                  TaskName.text,
                                  TaskDesc.text,
                                  widget.CurrentUserID);

                              getPost();

                              createNew;
                            },
                            child: const Text("Done"),
                          ),
                        ),
                      ],
                    )
                  : FutureBuilder(
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
                                    leading:
                                        CircleAvatar(child: Text('$index')),
                                    title: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            tappedID = ids[index];
                                            fkID = fks[index];
                                          });
                                          showDialog(
                                              context: context,
                                              builder:
                                                  (context) =>
                                                      StatefulBuilder(builder:
                                                          (context, setState) {
                                                        return AlertDialog(
                                                            // Dialog(

                                                            insetPadding:
                                                                EdgeInsets.all(
                                                                    30),
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
                                                                        SizedBox(
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        Text(
                                                                          "${Tasks[index]}",
                                                                          style:
                                                                              TextStyle(fontSize: 20),
                                                                        ),
                                                                        Divider(),
                                                                        SizedBox(
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 10, right: 10),
                                                                            child: Clicked
                                                                                ? ListTile(
                                                                                    title: Text(
                                                                                      TaskDes[index],
                                                                                      style: TextStyle(fontSize: 20),
                                                                                    ),
                                                                                    trailing: GestureDetector(
                                                                                      onTap: () {
                                                                                        setState(() {
                                                                                          Clicked = false;
                                                                                          notClick = true;
                                                                                        });
                                                                                      },
                                                                                      child: Icon(
                                                                                        Icons.edit,
                                                                                        color: Colors.green,
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : Column(
                                                                                    children: [
                                                                                      TextField(
                                                                                        controller: up,
                                                                                        decoration: InputDecoration(
                                                                                          label: Text(TaskDes[index]),
                                                                                        ),
                                                                                      ),
                                                                                      ElevatedButton(
                                                                                          onPressed: () async {
                                                                                            final updating = await pb.updating(Tasks[index], up.text, fks[index], ids[index]).then((value) => getPost());
                                                                                            Navigator.push(context, MaterialPageRoute(
                                                                                              builder: (context) {
                                                                                                return dash(CurrentUserID: widget.CurrentUserID);
                                                                                              },
                                                                                            ));
                                                                                          },
                                                                                          child: Text('submit'))
                                                                                    ],
                                                                                  )),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                      ]))
                                                            ]);
                                                      }));
                                        },
                                        child: Text(Tasks[index])),
                                    trailing: GestureDetector(
                                      onTap: () async {},
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  StatefulBuilder(builder:
                                                      (context, setState) {
                                                    return AlertDialog(
                                                        // Dialog(

                                                        insetPadding:
                                                            EdgeInsets.all(30),
                                                        actions: [
                                                          Center(
                                                              child: Text(
                                                            Tasks[index],
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          )),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  pb.deleting(
                                                                      ids[index]);
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                                      return dash(
                                                                          CurrentUserID:
                                                                              widget.CurrentUserID);
                                                                    },
                                                                  ));
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .remove_circle_outline_outlined,
                                                                  size: 20,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .back_hand,
                                                                  size: 20,
                                                                  color: Colors
                                                                      .green,
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ]);
                                                  }));
                                        },
                                        child: Icon(
                                          Icons.remove_circle_outline,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ));
                              },
                            );
                        }
                      },
                    ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isCreated = !isCreated;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
