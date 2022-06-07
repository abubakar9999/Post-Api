import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../http/custom_http_request.dart';
import '../welcom.dart';
import '../widget/widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  signinInfo() async {
    var map = Map<String, dynamic>();

    map["email"] = emailController.text.toString();
    map["password"] = passwordController.text.toString();

    var respons = await http.post(
        Uri.parse("https://apihomechef.antopolis.xyz/api/admin/sign-in"),
        body: map,
        headers: CustomHttpRequest.defaultHeader);

    print("${respons.body}");

    final data = jsonDecode(respons.body);
    if (respons.statusCode == 200) {
      showInToast("Sign In Successful");
    } else {
      showInToast("Sign In  Faield");
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: 20, left: 20),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: const Center(
                  child: Text(
                "Sign In",
                style: TextStyle(fontSize: 40, color: Color(0xff0d964c)),
              )),
            ),
            Image.asset(
              "assets/auth_img/Signin.png",
              height: 250,
              width: 250,
            ),
            Text(
              "Enter your phone number and password to access your account",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 15,
            ),
            Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(
                                  color: Color(0xff0d964c), width: 1.7)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(
                                  color: Color(0xff0d964c), width: 1.7)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(
                                  color: Color(0xff0d964c), width: 1.7)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(
                                  color: Color(0xff0d964c), width: 1.7)),
                          contentPadding: EdgeInsets.zero,
                          prefixIcon:
                              Icon(Icons.person, color: Color(0xff0d964c)),
                          hintText: 'Enter your Email',
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Color(0xff0d964c)),
                          fillColor: Colors.grey,
                          focusColor: Colors.grey),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: passwordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(
                                  color: Color(0xff0d964c), width: 1.7)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(
                                  color: Color(0xff0d964c), width: 1.7)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(
                                  color: Color(0xff0d964c), width: 1.7)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(
                                  color: Color(0xff0d964c), width: 1.7)),
                          contentPadding: EdgeInsets.zero,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                          prefixIcon:
                              Icon(Icons.lock, color: Color(0xff0d964c)),
                          hintText: 'Enter your password',
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Color(0xff0d964c)),
                          fillColor: Colors.grey,
                          focusColor: Colors.grey),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Password';
                        }
                        return null;
                      },
                    ),
                  ],
                )),
            InkWell(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassword()));
              },
              child: Text(
                "Forget password ?",
                style: TextStyle(fontSize: 16, color: Colors.red.shade500),
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(height: 45),
            SizedBox(
                width: (MediaQuery.of(context).size.width) - 50,
                height: 40,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xff0d964c),
                        onPrimary: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32))),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        signinInfo()
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Welcome()))
                            : showInToast("SomeThing is Worng");
                      }
                    },
                    child: Text(
                      "Sign In",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ))),
          ],
        ),
      ),
    );
  }
}
