import 'package:flutter/material.dart';
import 'package:mustafa_backend/models/task.dart';
import 'package:mustafa_backend/services/task.dart';
import 'package:mustafa_backend/views/tasks/create_task.dart';
import 'package:mustafa_backend/views/tasks/update_task.dart';
import 'package:provider/provider.dart';

class GetInCompletedTask extends StatelessWidget {
  const GetInCompletedTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get InCompleted Task"),
      ),
      body: StreamProvider.value(
        value: TaskServices().getInCompletedTask(),
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
                    Checkbox(
                        value: taskList[index].isCompleted,
                        onChanged: (val)async{
                          try{
                            await TaskServices().markAsCompletedTask(
                                taskList[index], val!)
                                .then((value){
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text("Task Updated")));
                            });
                          }catch(e){
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(e.toString())));
                          }
                        }),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateTask(model: taskList[index])));
                    }, icon: Icon(Icons.edit)),
                    IconButton(onPressed: ()async{
                      try{
                        await TaskServices().deleteTask(taskList[index].docId.toString())
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
