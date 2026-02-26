import 'package:flutter/material.dart';
import 'package:mustafa_backend/models/user.dart';
import 'package:mustafa_backend/services/auth.dart';
import 'package:mustafa_backend/services/user.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
      ),
      body: Column(children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
              hint: Text("Email")
          ),
        ),
        isLoading ? Center(child: CircularProgressIndicator(),)
            :ElevatedButton(onPressed: ()async{
          try{isLoading = true;
          setState(() {});
          await AuthServices().resetPassword(
              email: emailController.text,)
              .then((val){
              isLoading = false;
              setState(() {});
              showDialog(context: context, builder: (BuildContext context) {
                return AlertDialog(
                  content: Text("Link Send Successfully"),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }, child: Text("Okay"))
                  ],
                );
              }, );
            });


          }catch(e){
            isLoading = false;
            setState(() {});
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }
        }, child: Text("Send Link"))
      ],),
    );
  }
}
