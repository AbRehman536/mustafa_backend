import 'package:flutter/material.dart';
import 'package:mustafa_backend/models/priority.dart';
import 'package:mustafa_backend/models/task.dart';
import 'package:mustafa_backend/services/priority.dart';
import 'package:mustafa_backend/services/task.dart';
import 'package:mustafa_backend/views/priotrity/create_priority.dart';
import 'package:mustafa_backend/views/priotrity/update_priority.dart';
import 'package:mustafa_backend/views/tasks/create_task.dart';
import 'package:mustafa_backend/views/tasks/get_all_favorite.dart';
import 'package:mustafa_backend/views/tasks/get_incompleted_task.dart';
import 'package:mustafa_backend/views/tasks/update_task.dart';
import 'package:provider/provider.dart';


class GetPriorityTask extends StatelessWidget {
  final PriorityModel model;
  const GetPriorityTask({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${model.name} Priority Task"),
      ),
      body: StreamProvider.value(
        value: TaskServices().getTaskByPriorityID(model.docId.toString()),
        initialData: [TaskModel()],
        builder: (context, child){
          List<TaskModel> taskList = context.watch<List<TaskModel>>();
          return ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(taskList[index].title.toString()),
                subtitle: Text(taskList[index].description.toString()),
                trailing: Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateTask(model: taskList[index])));
                    }, icon: Icon(Icons.edit)),
                    IconButton(onPressed: ()async{
                      try{
                        await PriorityServices().deletePriority(taskList[index].docId.toString())
                            .then((value){
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("Delete Successfully")));
                        });
                      }catch(e){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }, icon: Icon(Icons.delete, color: Colors.red,)),
                  ],
                ),
              );
            },);
        },
      ),
    );
  }
}
