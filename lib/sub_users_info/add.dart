import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:todo/sub_users_info/newUser.dart';

class addClass extends StatefulWidget {
  // const addClass({super.key});
  var CurrentUserId;
  var name;
  addClass({required this.CurrentUserId, required this.name});

  @override
  State<addClass> createState() => _addClassState();
}

class _addClassState extends State<addClass> {
  final pb = PocketBase('http://10.0.2.2:8090');
  TextEditingController taskName = TextEditingController();
  TextEditingController taskDescription = TextEditingController();
  var taskdescription;
  @override
  Widget build(BuildContext context) {
    return Form(
        child: ListView(
      children: [
        SizedBox(
          height: 50,
        ),
        Container(
          padding: EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 10),
          child: TextFormField(
            // controller: money,
            controller: taskName,
            onChanged: (value) {
              // input = value;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.transparent, width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 0)),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 21),
                filled: true,
                fillColor: Color(0xffEBEBEB),
                // fillColor: Color(0xffD9D9D9),
                hintText: 'Task Name',
                hintStyle: TextStyle(
                    // color: Color(0xff3F3C3C),
                    fontSize: 17,
                    fontWeight: FontWeight.w600)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          // padding: EdgeInsets.all(20),
          padding: EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 10),
          child: TextFormField(
            maxLines: 12,
            // controller: money,
            controller: taskDescription,
            onChanged: (value) {
              // input = value;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.transparent, width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 0)),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 21),
                filled: true,
                fillColor: Color(0xffEBEBEB),
                // fillColor: Color(0xffD9D9D9),
                hintText: 'Task Description',
                hintStyle: TextStyle(
                    // color: Color(0xff3F3C3C),
                    fontSize: 17,
                    fontWeight: FontWeight.w600)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: double.infinity,
            // width: 10,
            height: 55,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff1D1CE5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(52), // <-- Radius
                  ),
                ),
                onPressed: () async {
                  final body = <String, dynamic>{
                    "TaskName": taskName.text,
                    "TaskDescription": taskDescription.text,
                    "fk_id": widget.CurrentUserId
                  };
                  final record =
                      await pb.collection('Tasks').create(body: body);
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return newUser(
                          CurrentUserID: widget.CurrentUserId,
                          Name: widget.name);
                    },
                  ));
                },
                child: Text(
                  'Add ',
                  style: TextStyle(fontSize: 23, letterSpacing: 2),
                )),
          ),
        ),
      ],
    ));
  }
}
