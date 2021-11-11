import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';
import 'package:untitled2/controllers/task_controller.dart';
import 'package:untitled2/models/task.dart';
import 'package:untitled2/services/notification_services.dart';
import 'package:untitled2/services/theme_services.dart';
import 'package:untitled2/ui/add_taskpage.dart';
import 'package:untitled2/ui/theme.dart';
import 'package:untitled2/ui/widget/button.dart';
import 'package:untitled2/ui/widget/task_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifyHelper;
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _appBar(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          SizedBox(
            height: 10,
          ),
          _showTasks(),
        ],
      ),
    );
  }

  _addDateBar() => Container(
        padding: const EdgeInsets.only(top: 20, left: 5),
        child: DatePicker(
          DateTime.now(),
          initialSelectedDate: DateTime.now(),
          height: 100,
          width: 80,
          selectionColor: Theme.of(context).primaryColor,
          dateTextStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w600),
          dayTextStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w600),
          monthTextStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
          selectedTextColor: Colors.white,
          onDateChange: (date) {
            _selectedDate = date;
            _taskController.getTasks();
          },
        ),
      );

  _addTaskBar() => Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${DateFormat.yMMMMd().format(DateTime.now())}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.grey[400])),
                Text('Today', style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
            Spacer(),
            MyButton(
                label: '+ Add Task',
                onTap: () async {
                  await Get.to(() => const AddTaskPage());
                  _taskController.getTasks();
                }),
          ],
        ),
      );

  _appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          notifyHelper.initializeNotification();
          notifyHelper.displayNotification(
            title: 'Theme Changed',
            body:
                Get.isDarkMode ? 'Activated light Mode' : 'Activated Dark Mode',
          );
          // notifyHelper.scheduledNotification();
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
          size: 25,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('images/profile.png'),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  _showBottomSheet({required context, required Task task}) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 4),
      color: Get.isDarkMode ? darkGreyClr : Colors.white,
      height: MediaQuery.of(context).size.height * 0.32,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
            ),
          ),
          Spacer(),
          task.isCompleted == 1
              ? _BottomSheetButton(
            context: context,
            lable: 'Task Uncompleted',
            onTap: () {
              _taskController.markTaskUncompleted(task.id!);

              Get.back();
            },
            clr: bluishClr,
          )
              : _BottomSheetButton(
                  context: context,
                  lable: 'Task Completed',
                  onTap: () {
                    _taskController.markTaskCompleted(task.id!);

                    Get.back();
                  },
                  clr: bluishClr,
                ),
          SizedBox(
            height: 10,
          ),
          _BottomSheetButton(
            context: context,
            lable: 'Delete Task',
            onTap: () {
              _taskController.delete(task);

              Get.back();
            },
            clr: pinkClr,
          ),

          _BottomSheetButton(
            context: context,
            lable: 'close',
            onTap: () {
              Get.back();
            },
            isClose: true,
            clr: Colors.white,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    ));
  }

  _BottomSheetButton(
      {required String lable,
      required Function() onTap,
      required Color clr,
      bool isClose = false,
      required context}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
            child: Text(
          lable,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color:isClose? Get.isDarkMode? Colors.white:Colors.black:Colors.white ,
                fontSize: 16,
            fontWeight: FontWeight.bold,
              ),
        )),
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        decoration: BoxDecoration(
            color: isClose == true ? Colors.transparent  : clr,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 2,
              color: isClose == true ? Get.isDarkMode? Colors.grey[600]!:Colors.grey[300]!: clr,
            )),
        width: MediaQuery.of(context).size.width * 0.9,
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (_, index) {
            Task task =_taskController.taskList[index];
            if(task.repeat =='Daily')
            {
              DateTime date =DateFormat.jm().parse(task.startTime.toString());
              var myTime =DateFormat("HH:mm").format(date);
              notifyHelper.scheduledNotification(
                  int.parse(myTime.toString().split(':')[0]),
                  int.parse(myTime.toString().split(':')[1]),
                  task

              );
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(
                                context: context,
                                task:task);
                          },
                          child: TaskTile(
                            task,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );

            }
            if(task.date == DateFormat.yMd().format(_selectedDate))
              {

                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(
                                  context: context,
                                  task:task);
                            },
                            child: TaskTile(
                              task,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );

              }else
                {
                  return Container();
                }

          }
        );
      }),
    );
  }
}
