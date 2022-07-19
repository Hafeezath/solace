import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';

import '../theme.dart';
import '../widgets/glowing_action_button.dart';
import 'consultation.dart';
class Log extends StatefulWidget {
  const Log({Key? key}) : super(key: key);

  @override
  State<Log> createState() => _LogState();
}

class _LogState extends State<Log> {
  late Query _ref;
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('insertdata');
  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance.ref().child('insertdata').orderByChild('First Name');
  }

  @override
  Widget _buildContactItem({Map? insert}) {
    return Container(margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      height: 100,
      color: Colors.white,
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 6),
                  Text('Name: '),
                  Text(
                    insert!['First Name'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),



                  const SizedBox(width: 6 ),
                  Text(
                    insert!['Last Name'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),



                  const SizedBox(width: 6),
                  Text('Gender: '),
                  Text(
                    insert['Gender'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text('Age: '),
                  Text(
                    insert['Age'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(width: 6),
                  Text('Reason: '),
                  Text(
                    insert['Reason'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(width: 6),
                  Text('Desc: '),
                  Text(
                    insert['Description'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],),
            ),

          ],

        ),
      ),

    );

  }



  @override
  Widget build(BuildContext context) {


    //btmnavbar

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [

            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: double.infinity,


                child: FirebaseAnimatedList(
                  scrollDirection: Axis.vertical,
                  query: _ref,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                    Map? contact = snapshot.value as Map?;
                    print(_ref);
                    print(contact!['First Name']);
                    return _buildContactItem(insert: contact);
                  },
                ),


              ),
            ),
            GlowingActionButton(
              color: AppColors.secondary,
              icon: CupertinoIcons.add,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Consult(),
                  ),
                );
              },
            ),

          ],
        ),
      ),

    );

  }
}