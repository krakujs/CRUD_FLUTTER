import 'package:assignment1/firebase/auth/user.dart';
import 'package:assignment1/pages/loginPage.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String email = "";
  String password = "";
  String confirmPassword = "";

  void handleSubmit() async {
    bool isFormCorrect = _validateForm(email, password, confirmPassword);

    if (!isFormCorrect) {
      return;
    }

    try {
      UserAuth user = UserAuth();
      bool isSignedUp = await user.signUp(
        email,
        password,
      );

      if (!isSignedUp) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something went wrong')));
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User Created Successfully')));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) {
          return const Signup();
        },
      ));
      return;
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));

      return;
    }
  }

  final _emailTEC = TextEditingController();
  final _passwordTEC = TextEditingController();
  final _confirmPassword = TextEditingController();
  bool _pisObscure = true;
  bool _cpisObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListView(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 18),
                  child: TextField(
                    autocorrect: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter  Email',
                      prefixIcon: Icon(Icons.email),
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white70,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.black26, width: 2),
                      ),
                      labelText: 'Email',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                    controller: _emailTEC,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 18),
                  child: TextField(
                    autocorrect: true,
                    obscureText: _pisObscure,
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      prefixIcon: const Icon(Icons.password),
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white70,
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.black26, width: 2),
                      ),
                      labelText: 'Password',
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _pisObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _pisObscure = !_pisObscure;
                          });
                        },
                      ),
                    ),
                    controller: _passwordTEC,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 18),
                  child: TextField(
                    autocorrect: true,
                    obscureText: _cpisObscure,
                    decoration: InputDecoration(
                      hintText: 'Enter Confirm Password',
                      prefixIcon: const Icon(Icons.password),
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white70,
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.black26, width: 2),
                      ),
                      labelText: 'Confirm Password',
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _cpisObscure
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _cpisObscure = !_cpisObscure;
                          });
                        },
                      ),
                    ),
                    controller: _confirmPassword,
                  ),
                ),
                const SizedBox(
                  height: 15,
                  child: Divider(
                    color: Colors.black87,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Container(
                    constraints:
                        const BoxConstraints.expand(height: 45.0, width: 100.0),
                    child: ElevatedButton(
                        onPressed: () {
                          email = _emailTEC.text;
                          password = _passwordTEC.text;
                          confirmPassword = _confirmPassword.text;
                          handleSubmit();
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.orange)),
                        child: const Text('Register')),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already has a account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const loginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.black),
                        )),
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

bool _validateForm(
  String email,
  String password,
  String confirmPassword,
) {
  String error = "";
  RegExp emailRe =
      RegExp(r"^[a-zA-Z][a-zA-Z0-9._+]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");

  if (!emailRe.hasMatch(email)) {
    error = 'Invalid Email';
  } else if (password.length < 4) {
    error = "Password length too short";
  } else if (password.compareTo(confirmPassword) != 0) {
    error = "Passwords doesn't match";
  }

  if (error.compareTo("") != 0) {
    return false;
  }

  return true;
}
