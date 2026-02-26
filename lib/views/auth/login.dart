import 'package:flutter/material.dart';
import 'package:mustafa_backend/models/user.dart';
import 'package:mustafa_backend/services/auth.dart';
import 'package:mustafa_backend/services/user.dart';
import 'package:mustafa_backend/views/auth/register.dart';
import 'package:mustafa_backend/views/auth/reset_password.dart';
import 'package:mustafa_backend/views/tasks/get_all_task.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
              hint: Text("Email")
          ),
        ),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
              hint: Text("Password")
          ),
        ),
        isLoading ? Center(child: CircularProgressIndicator(),)
            :ElevatedButton(onPressed: ()async{
          try{
            isLoading = true;
          setState(() {});
          await AuthServices().loginUser(
            email: emailController.text,
            password: passwordController.text,)
              .then((val){
                if(val.emailVerified == true){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> GetAllTask()));
                }else{
                  isLoading = false;
                  setState(() {});
                  showDialog(context: context, builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text("Kindly Verify Your Email"),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("Okay"))
                      ],
                    );
                  }, );

                }
           });


          }catch(e){
            isLoading = false;
            setState(() {});
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }
        }, child: Text("Login")),
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Register()));
        }, child: Text("Register")),
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetPassword()));
        }, child: Text("Reset Password")),
      ],),
    );
  }
}
