import 'package:solace/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_database/firebase_database.dart';
import 'log.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:solace/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: const Consult()));
}



class Consult extends StatefulWidget {
  const Consult({Key? key}) : super(key: key);


  @override
  State<Consult> createState() => _ConsultState();
}

class _ConsultState extends State<Consult> {


  FirebaseDatabase database = FirebaseDatabase.instance;
  late DatabaseReference ref;
  late TextEditingController fname, lname;
  void initState() {
    super.initState();
    fname = TextEditingController();
    lname = TextEditingController();
    //umob = TextEditingController();
    age = TextEditingController();
    gender = TextEditingController();
    date =  TextEditingController();
    start =  TextEditingController();
    end =  TextEditingController();
    //nationality = TextEditingController();
    //hobbies = TextEditingController();
    //areas_of_int = TextEditingController();
    //cname = TextEditingController();
    //cmob = TextEditingController();
    res = TextEditingController();
    descp = TextEditingController();
    ref = FirebaseDatabase.instance.reference().child('insertdata');
  }

  // Initial Selected Value
  String dropdownvalue = 'Male';

  // List of items in our dropdown menu
  var items = [
    'Male',
    'Female',
    'Prefer not to say',
  ];
  final _formKey = GlobalKey<FormState>();
  //var SFA = false;
  //var conv = false;

  //var AM = false;
  //var ED = false;
  //var MS = false;

  //final TextEditingController _emailController = TextEditingController();
  //final TextEditingController _passwordController = TextEditingController();

  //var umob = new TextEditingController();
  var age = new TextEditingController();
  var gender = new TextEditingController();
  //var nationality = new TextEditingController();
  //var hobbies = new TextEditingController();
  //var areas_of_int = new TextEditingController();
  //var cname = new TextEditingController();
  //var cmob = new TextEditingController();
  var res = new TextEditingController();
  var descp = new TextEditingController();
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var date = new TextEditingController();
  var start = new TextEditingController();
  var end = new TextEditingController();
  var rememberValue = false;
  bool _value = false;
  bool isChecked = false;
  final databaseReference = FirebaseDatabase.instance.reference();

  //dropdowntest
  String dropdownValue = 'Tom Cruise';
  late final VoidCallback? onPressed;

  // To show Selected Item in Text.
  String holder = '';

  /*List<String> actorsName = [
    'Robert Downey, Jr.',
    'Tom Cruise',
    'Leonardo DiCaprio',
    'Will Smith',
    'Tom Hanks'
  ];

  void getDropDownItem() {
    setState(() {
      holder = dropdownValue;
    });
  }*/

  //dropdowntest
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        //backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                OutlinedButton(

                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  HomeScreenProf(),
                      ),
                    );
                  },
                  child: Text(
                    'Back',
                    style: TextStyle(

                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.teal[500],
                    ),
                  ),
                ),
                const Text(
                  'Consultation Record',

                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,

                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: fname,
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: 'First name',
                                // prefixIcon: const Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: lname,
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: 'Last name',
                                // prefixIcon: const Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: TextFormField(
                                controller: age,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'Age',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Please enter your age';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: gender,
                              maxLines: 1,
                              decoration: InputDecoration(
                                // prefixIcon: const Icon(Icons.flag),
                                hintText: 'Gender',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),


                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: res,

                        maxLines: 1,
                        decoration: InputDecoration(
                          // prefixIcon: const Icon(Icons.lock),
                          hintText: 'Reason for consultation',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: descp,
                        minLines: 2,
                        maxLines: 10,
                        decoration: InputDecoration(
                          // prefixIcon: const Icon(Icons.lock),
                          hintText: 'Description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          insert();

                          //Navigator.pushReplacement(context,
                            //MaterialPageRoute(
                           //   builder: (context) => const Log(),),);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                        ),
                        child: const Text(
                          'Add',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

  }

  void insert() {
    String firstname = fname.text;
    String secondname = lname.text;
    //String user_mobile = umob.text;
    String age = this.age.text;
    String gender = this.gender.text;
    // String date = this.date.text;
    //  String start = this.start.text;
    //  String end = this.end.text;
    //String email = _emailController.text;
    //String n = nationality.text;
    //String h = hobbies.text;
// area of int
    //bool areaofint1 = SFA;
    // bool areofint2 = conv;
    //String carename = cname.text;
    //String caremob = cmob.text;
// reason for joining
    String res = this.res.text;
    String des = descp.text;

    Map<String, String> insertdata = {
      'First Name': firstname,
      'Last Name': secondname,
      //'User Mobile': user_mobile,
      'Age': age,
      'Gender': gender,
      //   'Date': date,
      //   'Start Time': start,
      //    'End Time': end,
      //'Email': email,
      //'Nationality': n,
      //'Hobbies': h,
      //'Caretaker Name': carename,
      //'Caretaker Mobile Number': caremob,
      'Reason': res,
      'Description': des,
    };
    ref.push().set(insertdata);
  }
}