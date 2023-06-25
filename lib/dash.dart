import 'package:flutter/material.dart';
import 'package:todo/pocketbase.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:todo/sub_users_info/newUser.dart';

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
  // final pocketb = PocketBase('http://127.0.0.1:8090');

  TextEditingController TaskName = TextEditingController();
  TextEditingController TaskDesc = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conf = TextEditingController();
  TextEditingController up = TextEditingController();
  var Tasks = [];
  var TaskDes = [];
  var ids = [];
  var fks = [];
  bool Clicked = true;
  bool notClick = false;
  var tappedID;
  var fkID;
// .....................................Tasks
  var taskLength;
  var Tnames = [];
  var Tdesc = [];
  var tId = [];
  var fD = [];

  var owner_of_task;

  TextEditingController up1 = TextEditingController();
  Future getTask(String fk1) async {
    final pb = PocketBase('http://10.0.2.2:8090');
    final result = await pb.collection('Tasks').getList();

    for (var i in result.items) {
      var TaskName = i.getStringValue('TaskName');
      var TaskD = i.getStringValue('TaskDescription');
      var fk = i.getStringValue('fk_id');

      var id = i.id;
      if (Tnames.contains(TaskName) == false && fk1 == fk) {
        Tnames.add(TaskName);
        Tdesc.add(TaskD);
        // if()
        tId.add(id);
        fD.add(fk);
      }
    }
  }

  Future getPost() async {
    final pb = PocketBase('http://10.0.2.2:8090');
    final result = await pb.collection('sub_user').getList();

    for (var i in result.items) {
      var name = i.getStringValue('name');
      // print(TName);
      var email = i.getStringValue('email');
      var fk = i.getStringValue('fk_id');
      // print(fk);
      var id = i.id;

      // if (widget.CurrentUserID == fk) {
      if (Tasks.contains(name) == false && widget.CurrentUserID == fk) {
        Tasks.add(name);
        TaskDes.add(email);
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
    getPost();
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Icon(Icons.arrow_back)),
        backgroundColor: Colors.deepPurpleAccent,
        automaticallyImplyLeading: false,
        title: Text('Available users'),
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
                                  InputDecoration(label: Text('username')),
                            ),
                            TextFormField(
                              controller: TaskDesc,
                              decoration:
                                  InputDecoration(label: Text('E-mail')),
                            ),
                            TextFormField(
                              controller: password,
                              decoration: InputDecoration(
                                label: Text("password"),
                              ),
                            ),
                            TextFormField(
                              controller: conf,
                              decoration: InputDecoration(
                                label: Text("confirm password"),
                              ),
                            )
                          ],
                        )),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isCreated = false;
                                // getPost();
                              });

                              if (TaskName.toString().isNotEmpty &&
                                  password.toString().isNotEmpty) {
                                final body = <String, dynamic>{
                                  "email": TaskDesc.text,
                                  "emailVisibility": true,
                                  "password": password.text,
                                  "passwordConfirm": conf.text,
                                  "name": TaskName.text,
                                  "fk_id": widget.CurrentUserID
                                };

                                final record = await pocketb
                                    .collection('sub_user')
                                    .create(body: body);
                                // getPost();
                                setState(() {
                                  getPost();
                                });

                                // print(widget.cu)
                              }
                              // setState(() {
                              //   getPost();
                              // });
                              getPost();

                              password.text = '';
                              TaskName.text = '';
                              TaskDesc.text = '';
                              up.text = '';
                              conf.text = '';
                              // print(getPost());
                              // print(widget.CurrentUserID);
                            },

                            // getPost();

                            // createNew;
                            // },
                            child: const Text("Add user"),
                          ),
                        ),
                      ],
                    )
                  : FutureBuilder(
                      future: pocketb.collection('sub_user').getList(),
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
                                        child: Text(Tasks[index]),
                                        onTap: () {
                                          setState(() {
                                            tappedID = ids[index];
                                            fkID = fks[index];
                                            // print(tappedID);
                                            // if (Tdesc.length == 0) {
                                            // getTask(tappedID);
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return newUser(
                                                    fromID:
                                                        widget.CurrentUserID,
                                                    CurrentUserID: tappedID,
                                                    Name: Tasks[index]);
                                              },
                                            ));
                                            // print(owner_of_task);
                                            // }
                                          });
                                        }),
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
                                                                onTap:
                                                                    () async {
                                                                  await pb.deleting(
                                                                      ids[index]);
                                                                  // getPost();
                                                                  // setState({})

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
                                                                  // getPost();
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
            getPost();
          });
        },
        child: Icon(Icons.add),
      ),
      // ),
    );
  }
}
