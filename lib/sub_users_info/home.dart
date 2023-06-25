import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:todo/sub_users_info/newUser.dart';

class home extends StatefulWidget {
  // const home({super.key});
  var currentUserId;
  var name;
  home({required this.currentUserId, required this.name});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final pobketb = PocketBase('http://10.0.2.2:8090');

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
  var locked = [];

  // bool isLocked = false;

  // var c;
  // var isLocked;

  var owner_of_task;

  TextEditingController up1 = TextEditingController();
  Future getTask(String fk1) async {
    final pb = PocketBase('http://10.0.2.2:8090');
    final result = await pb.collection('Tasks').getList();

    for (var i in result.items) {
      var TaskName = i.getStringValue('TaskName');
      var TaskD = i.getStringValue('TaskDescription');
      var fk = i.getStringValue('fk_id');
      var islok = i.getBoolValue('locked');

      var id = i.id;
      if (Tnames.contains(TaskName) == false && fk1 == fk) {
        Tnames.add(TaskName);
        Tdesc.add(TaskD);
        // if()
        tId.add(id);
        fD.add(fk);
        locked.add(islok);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTask(widget.currentUserId);
  }

  @override
  Widget build(BuildContext context) {
    // if (truely) {
    //   isLocked = !isLocked;
    // }
    return Scaffold(
      body: Center(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: FutureBuilder(
              future: pobketb.collection('Tasks').getList(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Text('Loading....');
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    return ListView.builder(
                      itemCount: Tnames.length,
                      itemBuilder: (context, index) {
                        // return
                        return ListTile(
                          leading: CircleAvatar(child: Text('$index')),
                          title: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                            builder: (context, setState) {
                                          return AlertDialog(
                                              insetPadding: EdgeInsets.all(10),
                                              //  padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                                              actions: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  height: 300,
                                                  width: double.infinity,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Clicked
                                                          ? ListTile(
                                                              title: Text(
                                                                  Tnames[
                                                                      index]),
                                                              subtitle: Text(
                                                                Tdesc[index],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                              trailing:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    Clicked =
                                                                        false;
                                                                    notClick =
                                                                        true;
                                                                  });
                                                                },
                                                                child: Icon(
                                                                  Icons.edit,
                                                                  color: Colors
                                                                      .green,
                                                                ),
                                                              ),
                                                            )
                                                          : Column(
                                                              children: [
                                                                Text(
                                                                  Tnames[index],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                TextField(
                                                                  controller:
                                                                      up,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    label: Text(
                                                                        Tdesc[
                                                                            index]),
                                                                  ),
                                                                ),
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () async {
                                                                      final body = <
                                                                          String,
                                                                          dynamic>{
                                                                        "TaskName":
                                                                            Tnames[index],
                                                                        "TaskDescription":
                                                                            up.text,
                                                                        "fk_id":
                                                                            widget.currentUserId
                                                                      };

                                                                      final record = await pobketb
                                                                          .collection(
                                                                              'Tasks')
                                                                          .update(
                                                                              tId[index],
                                                                              body: body);
                                                                      // final updating = await pobketb.(Tasks[index], up.text, fks[index], ids[index]).then((value) => getPost());
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                                          return newUser(
                                                                            CurrentUserID:
                                                                                widget.currentUserId,
                                                                            Name:
                                                                                widget.name,
                                                                          );
                                                                        },
                                                                      ));
                                                                      up.text =
                                                                          '';
                                                                    },
                                                                    child: Text(
                                                                        'submit'))
                                                              ],
                                                            ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      // Text(

                                                      // )
                                                    ],
                                                  ),
                                                )
                                              ]);
                                        }));
                                // showDialog(context: context, builder: builder)
                              },
                              child: Text(
                                Tnames[index],
                                style: TextStyle(
                                    decoration: locked[index]
                                        ? TextDecoration.lineThrough
                                        : null),
                              )),
                          trailing: GestureDetector(
                            onTap: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) => StatefulBuilder(
                                          builder: (context, setState) {
                                        // var isLock;
                                        // bool isLock = false;
                                        return AlertDialog(
                                            // Dialog(

                                            insetPadding: EdgeInsets.all(30),
                                            actions: [
                                              Center(
                                                  child: Text(
                                                Tnames[index],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    decoration: locked[index]
                                                        ? TextDecoration
                                                            .lineThrough
                                                        : null),

                                                // textDirection: TextDirection.l,
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
                                                    onTap: () async {
                                                      // print('im deleting');
                                                      await pobketb
                                                          .collection('Tasks')
                                                          .delete(tId[index]);
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                        builder: (context) {
                                                          return newUser(
                                                            CurrentUserID: widget
                                                                .currentUserId,
                                                            Name: widget.name,
                                                          );
                                                        },
                                                      ));
                                                    },
                                                    child: Icon(
                                                      Icons
                                                          .remove_circle_outline_outlined,
                                                      size: 20,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      var n = await pobketb
                                                          .collection('Tasks')
                                                          .getOne(tId[index]);
                                                      print(n.getBoolValue(
                                                          'locked'));
                                                      var me = n.getBoolValue(
                                                          'locked');

                                                      final body =
                                                          <String, dynamic>{
                                                        "TaskName":
                                                            Tnames[index],
                                                        "TaskDescription":
                                                            Tdesc[index],
                                                        "fk_id": widget
                                                            .currentUserId,
                                                        "locked": !me
                                                      };

                                                      final record =
                                                          await pobketb
                                                              .collection(
                                                                  'Tasks')
                                                              .update(
                                                                  tId[index],
                                                                  body: body);
                                                      // final updating = await pobketb.(Tasks[index], up.text, fks[index], ids[index]).then((value) => getPost());
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                        builder: (context) {
                                                          return newUser(
                                                            CurrentUserID: widget
                                                                .currentUserId,
                                                            Name: widget.name,
                                                          );
                                                        },
                                                      ));
                                                      // print(isLocked);
                                                      // print(locked[index]);
                                                      // isLocked = !isLocked;
                                                      // print(isLocked);
                                                      // print(
                                                      //     'this option if lock');
                                                    },
                                                    child: locked[index]
                                                        ? Icon(
                                                            Icons.lock,
                                                            size: 20,
                                                            color: Colors.teal,
                                                          )
                                                        : Icon(
                                                            Icons
                                                                .lock_open_rounded,
                                                            size: 20,
                                                            color: Colors.teal,
                                                          ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      // print(locked[index]);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Icon(
                                                      Icons.back_hand,
                                                      size: 20,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ]);
                                      }));
                              // print(c);
                              // print(isLocked);
                            },
                            // print(tId[index]);
                            // await pobketb
                            //     .collection('Tasks')
                            //     .delete(tId[index]);
                            // print(isLocked)

                            child: Icon(
                              Icons.remove_circle_outline,
                              color: Colors.red,
                            ),
                          ),
                        );
                      },
                    );
                }
              },
            )),
      ),
    );
  }
}
// trailing: GestureDetector(
//   onTap: () {
//     showDialog(
//         context: context,
//         builder: (context) => StatefulBuilder(
//                 builder: (context, setState) {
//               return AlertDialog(
//                   // Dialog(

//                   insetPadding:
//                       EdgeInsets.all(30),
//                   actions: [
//                     Center(
//                         child: Text(
//                       Tnames[index],
//                       style:
//                           TextStyle(fontSize: 20),
//                     )),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment:
//                           MainAxisAlignment
//                               .spaceEvenly,
//                       children: [
//                         GestureDetector(
//                           onTap: () async {
//                             // print(
//                             //     'Dont touch me');
//                           },
//                           child: Icon(
//                             Icons
//                                 .remove_circle_outline_outlined,
//                             size: 20,
//                             color: Colors.red,
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pop(
//                                 context);
//                           },
//                           child: Icon(
//                             Icons.back_hand,
//                             size: 20,
//                             color: Colors.green,
//                           ),
//                         ),
//                       ],
//                     )
//                   ]);
//             }));
//   },
//   child: GestureDetector(
//     onTap: () async {
//       await pobketb
//           .collection('Tasks')
//           .delete(tId[index]);
//     },
//     child: Icon(
//       Icons.remove_circle_outline,
//       color: Colors.red,
//     ),
//   ),
// ),
// );
// });
// }
// },
//               ))),
//     );
//   }
// }
