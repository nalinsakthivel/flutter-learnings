import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  LoginForm createState() => LoginForm();
}

class LoginForm extends State<MyApp> {
  final _formState = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isHidden = true;
  dynamic _isNameValid;
  dynamic _isPasswordValid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue,
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset('images/Logo.png'),
            Container(
                color: Colors.white,
                child: Padding(
                    padding: EdgeInsetsDirectional.all(20.0),
                    child: SingleChildScrollView(
                        child: Column(
                      children: <Widget>[
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text('Login',
                              style: TextStyle(
                                  fontSize: 30.0, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start),
                        ),
                        TextFormField(
                          controller: nameController,
                          keyboardAppearance: Brightness.dark,
                          decoration: InputDecoration(
                            errorText: _isNameValid,
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.blueGrey,
                              style: BorderStyle.solid,
                            )),
                            hintText: 'Enter Your Name',
                          ),
                          validator: (value) => _isNameValid,
                          onChanged: _isValidName,
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: _isHidden,
                              validator: (value) => _isPasswordValid,
                              onChanged: _isValidPassword,
                              decoration: InputDecoration(
                                errorText: _isPasswordValid,
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.blueGrey,
                                  style: BorderStyle.solid,
                                )),
                                hintText: 'Enter Password',
                                suffix: InkWell(
                                  onTap: _togglePasswordView,
                                  child: Icon(
                                    _isHidden
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                            onPressed: _printValues,
                            style: ButtonStyle(
                                fixedSize:
                                    MaterialStatePropertyAll(Size(100, 50))),
                            child: Text('Submit'))
                      ],
                    ))))
          ],
        )));
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _isValidName(name) {
    if (name.isEmpty) {
      setState(() {
        _isNameValid = 'Please enter name';
      });
    } else {
      setState(() {
        _isNameValid = null;
      });
    }
  }

  void _isValidPassword(password) {
    if (password.isEmpty) {
      setState(() {
        _isPasswordValid = 'Please enter password';
      });
    } else if (password.length >= 8) {
      setState(() {
        _isPasswordValid =
            "Password should be less than or equal to 8 characters";
      });
    } else {
      setState(() {
        _isPasswordValid = null;
      });
    }
  }

  void _printValues() {
    var name = nameController.text;
    var password = passwordController.text;
    if (_formState.currentState!.validate()) {
      print('Name ${name}');
      print('Password ${password}');
    }
  }
}
