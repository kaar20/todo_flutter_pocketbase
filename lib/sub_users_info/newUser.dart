import 'package:flutter/material.dart';
import 'package:todo/dash.dart';
import 'package:todo/pocketbase.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:todo/sub_users_info/add.dart';
import 'package:todo/sub_users_info/home.dart';

class newUser extends StatefulWidget {
  var fromID;

  var CurrentUserID;
  var Name;
  newUser(
      {@required this.CurrentUserID,
      required this.Name,
      @required this.fromID});

  @override
  State<newUser> createState() => _newUser();
}

class _newUser extends State<newUser> {
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
  var currentIndex = 0;

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
  // var cur

  @override
  void initState() {
    super.initState();
    getPost();
  }

  @override
  Widget build(BuildContext context) {
    var screens = [
      home(currentUserId: widget.CurrentUserID, name: widget.Name),
      addClass(
        CurrentUserId: widget.CurrentUserID,
        name: widget.Name,
      )
    ];
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return dash(CurrentUserID: widget.fromID);
                  },
                ));
              },
              child: Icon(Icons.arrow_back)),
          backgroundColor: Colors.deepPurpleAccent,
          automaticallyImplyLeading: false,
          title: Text('${widget.Name}'),
        ),
        body: screens[currentIndex],
        bottomNavigationBar: Container(
          // color: Color(0xff1D1CE5),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: GNav(
                // backgroundColor: Color(0xff1D1CE5),
                color: Color(0xff1D1CE5),
                activeColor: Colors.white,
                tabBackgroundColor: Color(0xff1D1CE5),
                gap: 10,
                padding: EdgeInsets.all(16),
                onTabChange: (value) {
                  // print(value);
                  setState(() {
                    currentIndex = value;
                  });
                },
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.add_circle_rounded,
                    text: "Add Class",
                  )
                ]),
          ),
        ));
  }
}
