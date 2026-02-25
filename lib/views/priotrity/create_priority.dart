import 'package:flutter/material.dart';
import 'package:mustafa_backend/models/priority.dart';
import 'package:mustafa_backend/models/task.dart';
import 'package:mustafa_backend/services/priority.dart';
import 'package:mustafa_backend/services/task.dart';

class CreatePriority extends StatefulWidget {
  const CreatePriority({super.key});

  @override
  State<CreatePriority> createState() => _CreatePriorityState();
}

class _CreatePriorityState extends State<CreatePriority> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Priority Task"),
      ),
      body: Column(
        children: [
          TextField(controller: nameController,),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
            try{
              isLoading = true;
              setState(() {});
              await PriorityServices().createPriority(
                  PriorityModel(
                     name: nameController.text,
                      createdAt: DateTime.now().millisecondsSinceEpoch
                  )
              ).then((value){
                isLoading = false;
                setState(() {});
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Create Successfully"),
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
          }, child: Text("Create Priority Task"))
        ],
      ),
    );
  }
}
