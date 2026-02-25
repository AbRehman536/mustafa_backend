import 'package:flutter/material.dart';
import 'package:mustafa_backend/models/priority.dart';
import 'package:mustafa_backend/models/task.dart';
import 'package:mustafa_backend/services/priority.dart';
import 'package:mustafa_backend/services/task.dart';
import 'package:mustafa_backend/views/priotrity/create_priority.dart';
import 'package:mustafa_backend/views/priotrity/get_priorities.dart';
import 'package:mustafa_backend/views/priotrity/update_priority.dart';
import 'package:mustafa_backend/views/tasks/create_task.dart';
import 'package:mustafa_backend/views/tasks/get_all_favorite.dart';
import 'package:mustafa_backend/views/tasks/get_incompleted_task.dart';
import 'package:mustafa_backend/views/tasks/update_task.dart';
import 'package:provider/provider.dart';


class GetAllPriorityTask extends StatelessWidget {
  const GetAllPriorityTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Priority Task"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatePriority()));
      },child: Icon(Icons.add),),
      body: StreamProvider.value(
        value: PriorityServices().getAllPriorities(),
        initialData: [PriorityModel()],
        builder: (context, child){
          List<PriorityModel> priorityList = context.watch<List<PriorityModel>>();
          return ListView.builder(
            itemCount: priorityList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(priorityList[index].name.toString()),
                trailing: Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdatePriority(model: priorityList[index])));
                    }, icon: Icon(Icons.edit)),
                    IconButton(onPressed: ()async{
                      try{
                        await PriorityServices().deletePriority(priorityList[index].docId.toString())
                            .then((value){
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("Delete Successfully")));
                        });
                      }catch(e){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }, icon: Icon(Icons.delete, color: Colors.red,)),

                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> GetPriorityTask(model: PriorityModel())));
                    }, icon: Icon(Icons.arrow_forward)),
                  ],
                ),
              );
            },);
        },
      ),
    );
  }
}
