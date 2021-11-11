import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';
import 'package:untitled2/controllers/task_controller.dart';
import 'package:untitled2/models/task.dart';
import 'package:untitled2/ui/theme.dart';
import 'package:untitled2/ui/widget/button.dart';
import 'package:untitled2/ui/widget/input_filed.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController =Get.put(TaskController());
  final TextEditingController _titleContrller = TextEditingController();
  final TextEditingController _noteContrller = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = '9:30 PM';
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedrepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  List<Color> circleAvatarColor =
  [
    bluishClr,
    pinkClr,
    yellowClr,

  ];
  int _SelectedColor = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      appBar: _appBar(context: context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AddTask',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              MyInputField(
                title: 'Title',
                hint: 'Enter your title',
                controller: _titleContrller,
              ),
              MyInputField(
                title: 'Note',
                hint: 'Enter your note',
                controller: _noteContrller,
              ),
              MyInputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                controller: TextEditingController(),
                widget: IconButton(
                  onPressed: () {
                    _getDateFromUser();
                  },
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: 'Start Time',
                      hint: _startTime,
                      controller: TextEditingController(),
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: Icon(
                          Icons.watch_later_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: MyInputField(
                      title: 'End Time',
                      hint: _endTime,
                      controller: TextEditingController(),
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                        icon: Icon(
                          Icons.watch_later_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MyInputField(title: 'Remind',
                hint: '$_selectedRemind minutes early',
                widget: DropdownButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined, color: Colors.grey,),
                    iconSize: 32,
                    elevation: 4,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                    underline: Container(height: 0,),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRemind = int.parse(newValue!);
                      });
                    },
                    items: remindList.map<DropdownMenuItem<String>>((
                        int value) {
                      return DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text(value.toString()));
                    }).toList()

                ),),
              MyInputField(
                title: 'Repeat', hint: _selectedrepeat, widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down_outlined, color: Colors.grey,),
                  iconSize: 32,
                  elevation: 4,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 14),
                  underline: Container(height: 0,),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedrepeat = newValue!;
                    });
                  },
                  items: repeatList.map<DropdownMenuItem<String>>((
                      String value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value.toString()));
                  }).toList()

              ),),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,

                children:
                [
                  _ColorPallete(),

                  MyButton(label: 'create Task', onTap: () => _validateData()),


                ],
              )

            ],
          ),
        ),
      ),
    );
  }

  _appBar({required BuildContext context}) {
    return AppBar(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: Get.isDarkMode ? Colors.white : Theme
              .of(context)
              .primaryColor,
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage('images/profile.png'),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2121));
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    }
  }

  _getTimeFromUser({required bool isStartTime}) async
  {
    var pickerTime = await _showTimePicker();
    String _formatedTime = pickerTime.format(context);
    if (pickerTime == null) {
      print('cancled');
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        context: context, initialEntryMode: TimePickerEntryMode.input,
        initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(':')[0]),
          minute: int.parse(_startTime.split(':')[1].split(' ')[0]),
        ));
  }

  _ColorPallete() =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Text('Color', style: Theme
              .of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 14, fontWeight: FontWeight.bold),),
          Wrap(

            children: List<Widget>.generate(
                3,
                    (int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _SelectedColor = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 5, top: 5,),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: circleAvatarColor[index],
                        child: _SelectedColor == index
                            ? const Icon(
                          Icons.done, color: Colors.white, size: 16,)
                            : Container(),
                      ),
                    ),
                  );
                }
            ),

          ),
        ],
      );
  _addTaskToDb()async
  {
 int value =   await _taskController.addTask(task:Task(
      color: _SelectedColor,
      title: _titleContrller.text,
      date: DateFormat.yMd().format(_selectedDate),
      endTime: _endTime,
      note: _noteContrller.text,
      remind: _selectedRemind,
      repeat: _selectedrepeat,
      startTime: _startTime,
      isCompleted: 0,

    ));
 print('MY ID IS $value');


  }

  _validateData()
  {
    if(_titleContrller.text.isNotEmpty&&_noteContrller.text.isNotEmpty)
      {
        _addTaskToDb();
        Get.back();
      }else if(_titleContrller.text.isEmpty || _noteContrller.text.isEmpty)
        {
          Get.snackbar('required', 'all fields are required !',
            margin: EdgeInsets.all(20),
            colorText: Colors.black,

            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: yellowClr,
            icon: Icon(Icons.warning_amber_rounded,color: Colors.black,),
          );

        }
  }
}
