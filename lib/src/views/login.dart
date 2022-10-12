import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FToast? fToast;

  AuthBloc? _authBloc;
  final TextEditingController username =
      TextEditingController(text: "rachman.latif@gmail.com");
  final TextEditingController password = TextEditingController(text: "testing");
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                "My APPS",
                style: TextStyle(
                    color: Color(0xff247881),
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              Image.asset("assets/images/ImageLogin.png"),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Container(
                      height: 66,
                      // width: 322,
                      padding: EdgeInsets.only(left: 10, top: 10),
                      decoration: BoxDecoration(
                          color: Color(0xff247881).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Username",
                            style: TextStyle(color: Color(0xff006778)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 20,
                            child: TextFormField(
                              controller: username,
                              style: TextStyle(fontSize: 15),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 66,
                      // width: 322,
                      padding: EdgeInsets.only(left: 10, top: 10),
                      decoration: BoxDecoration(
                          color: Color(0xff247881).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Password",
                            style: TextStyle(color: Color(0xff006778)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 20,
                            child: TextFormField(
                              controller: password,
                              obscureText: false,
                              style: TextStyle(fontSize: 15),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 45),
                    BlocListener<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthLoading) {
                          const Center(
                              child: CircularProgressIndicator(
                            color: Colors.blue,
                          ));
                        } else if (state is AuthSuccessful) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                              (Route<dynamic> route) => false);
                          //show alert success
                          print("success");
                        } else if (state is AuthError) {
                          //show alert error
                          print("fail");
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 65,
                        child: ElevatedButton(
                          onPressed: () {
                            if (username.text.isEmpty) {
                              showToast("Username cant Empty");
                            } else if (password.text.isEmpty) {
                              showToast("Password cant Empty");
                            }
                            _authBloc!.add(LoginEvent(
                                email: username.text, password: password.text));
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xff247881)),
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
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

  showToast(String msg) {
    Widget toast = Container(
      width: 350,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Color(0xffB22727),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning,
            color: Color(
              0xffffffff,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            msg,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );

    // Custom Toast Position
    fToast!.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: 400.0,
            left: 5.0,
            right: 5.0,
          );
        });
  }
}
