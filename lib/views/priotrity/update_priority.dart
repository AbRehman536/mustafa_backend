import 'package:flutter/material.dart';
import 'package:mustafa_backend/models/priority.dart';
import 'package:mustafa_backend/models/task.dart';
import 'package:mustafa_backend/services/priority.dart';
import 'package:mustafa_backend/services/task.dart';

class UpdatePriority extends StatefulWidget {
  final PriorityModel model;
  const UpdatePriority({super.key, required this.model});

  @override
  State<UpdatePriority> createState() => _UpdatePriorityState();
}

class _UpdatePriorityState extends State<UpdatePriority> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  void initState(){
    super.initState();
    nameController = TextEditingController(
        text: widget.model.name.toString()
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Priority Task"),
      ),
      body: Column(
        children: [
          TextField(controller: nameController,),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
            try{
              isLoading = true;
              setState(() {});
              await PriorityServices().updatePriority(
                  PriorityModel(
                      docId: widget.model.docId.toString(),
                     name: nameController.text,
                      createdAt: DateTime.now().millisecondsSinceEpoch
                  )
              ).then((value){
                isLoading = false;
                setState(() {});
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Update Successfully"),
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
          }, child: Text("Update Priority Task"))
        ],
      ),
    );
  }
}
