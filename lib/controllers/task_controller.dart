import 'package:get/get.dart';
import 'package:untitled2/db/db_helper.dart';
import 'package:untitled2/models/task.dart';

class TaskController extends GetxController
{
  @override
  void onReady(){
    super.onReady();
  }
  var taskList= <Task>[].obs;
  Future<int> addTask({ Task? task})async
  {
    return await DbHelper.insert(task);

  }
   void getTasks()async
  {
    List<Map<String,dynamic>> tasks =await DbHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());

  }
  void delete(Task task){
  DbHelper.delete(task);
  getTasks();


  }
  void markTaskCompleted(int id)async
  {
   await  DbHelper.update(id);
   getTasks();
  }
  void markTaskUncompleted(int id)async
  {
    await  DbHelper.updateUnMarked(id);
    getTasks();
  }
}