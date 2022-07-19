import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../app.dart';
import 'home_screen.dart';

class SignUpScreenProf extends StatefulWidget {
  static Route get route => MaterialPageRoute(
    builder: (context) => const SignUpScreenProf(),
  );
  const SignUpScreenProf({Key? key}) : super(key: key);
  static const String id = 'signupprof';
  @override
  State<SignUpScreenProf> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreenProf> {
  String dropdownvalue = 'Male';
// List of items in our dropdown menu
  var items = [
    'Male',
    'Female',
    'Prefer not to say',
  ];
  var AM = false;
  var ED = false;
  var MS = false;
  var SFA = false;
  var conv = false;
  final auth = firebase.FirebaseAuth.instance;
  final functions = FirebaseFunctions.instance;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nameControllersecond = TextEditingController();
  final umob = TextEditingController();
  final nationality = TextEditingController();
  final cname = TextEditingController();
  final hobbies = TextEditingController();
  final _profilePictureController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final cmob =  TextEditingController();
  final reason =  TextEditingController();
  final descp =  TextEditingController();

  final _emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  bool _loading = false;

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      try {
        // Authenticate with Firebase
        final creds =
        await firebase.FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        final user = creds.user;
        if (user == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User is empty')),
          );
          return;
        }

        // Set Firebase display name and profile picture
        List<Future<void>> futures = [
          creds.user!.updateDisplayName(_nameController.text),
          if (_profilePictureController.text.isNotEmpty)
            creds.user!.updatePhotoURL(_profilePictureController.text)
        ];

        await Future.wait(futures);

        // Create Stream user and get token using Firebase Functions
        final callable = functions.httpsCallable('createStreamUserAndGetToken');
        final results = await callable();

        // Connect user to Stream and set user data
        final client = StreamChatCore.of(context).client;
        await client.connectUser(
          User(
            id: creds.user!.uid,
            name: _nameController.text,
            image: _profilePictureController.text,

          ),
          results.data,
        );

        // Navigate to home screen
        await Navigator.of(context).pushReplacement(HomeScreen.route);
      } on firebase.FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Auth error')),
        );
      } catch (e, st) {
        logger.e('Sign up error', e, st);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occured')),
        );
      }
      setState(() {
        _loading = false;
      });
    }
  }

  String? _nameInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cannot be empty';
    }
    return null;
  }

  String? _emailInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cannot be empty';
    }
    if (!_emailRegex.hasMatch(value)) {
      return 'Not a valid email';
    }
    return null;
  }

  String? _passwordInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cannot be empty';
    }
    if (value.length <= 6) {
      return 'Password needs to be longer than 6 characters';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _profilePictureController.dispose();
    _nameController.dispose();
    _nameControllersecond.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SOLACE'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: (_loading)
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 24, bottom: 24),
                  child: Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 26, fontWeight: FontWeight.w800),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _nameController,
                    validator: _nameInputValidator,
                    decoration: InputDecoration(hintText: 'First name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    keyboardType: TextInputType.name,
                    autofillHints: const [
                      AutofillHints.name,
                      AutofillHints.username
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _nameControllersecond,
                    validator: _nameInputValidator,
                    decoration:  InputDecoration(
                      hintText: 'Second name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    keyboardType: TextInputType.name,
                    autofillHints: const [
                      AutofillHints.name,
                      AutofillHints.username
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: umob,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      //prefixIcon: const Icon(Icons.phone),
                      hintText: 'Enter your mobile number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: TextFormField(
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

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                          child: DropdownButton(
                            // Initial Value
                            value: dropdownvalue,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: nationality,
                    maxLines: 1,
                    decoration: InputDecoration(
                      // prefixIcon: const Icon(Icons.flag),
                      hintText: 'Nationality',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: cname,
                    maxLines: 1,
                    decoration: InputDecoration(
                      //  prefixIcon: const Icon(Icons.lock),
                      hintText: 'Enter your employer name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: cname,
                    maxLines: 1,
                    decoration: InputDecoration(
                      //  prefixIcon: const Icon(Icons.lock),
                      hintText: 'Enter your area of expertise',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _profilePictureController,
                    decoration:
                    const InputDecoration(hintText: 'picture URL'),
                    keyboardType: TextInputType.url,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _emailController,
                    validator: _emailInputValidator,
                    decoration: const InputDecoration(hintText: 'email'),
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _passwordController,
                    validator: _passwordInputValidator,
                    decoration: const InputDecoration(
                      hintText: 'password',
                    ),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: _signUp,
                    child: const Text('Sign up'),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',
                        style: Theme.of(context).textTheme.subtitle2),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Sign in'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
