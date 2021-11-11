

class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String?startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  Task({
    this.title,
    this.color,
    this.id,
    this.date,
    this.endTime,
    this.isCompleted,
    this.note,
    this.remind,
    this.repeat,
    this.startTime,
  });
  Task.fromJson(Map<String,dynamic>json)
  {
    title= json['title'];
    color= json['color'];
    id= json['id'];
    date= json['date'];
    endTime= json['endTime'];
    isCompleted=json['isCompleted'];
    note=json['note'];
    remind=json['remind'];
    repeat=json['repeat'];
    startTime=json['startTime'];
  }
  Map<String, dynamic> toMap()
  {
    Map<String, dynamic> data=
  {
    'id':id,
    'title':title,
    'color':color,
    'date':date,
    'endTime':endTime,
    'isCompleted':isCompleted,
    'note':note,
    'remind':remind,
    'repeat':repeat,
    'startTime':startTime,
    };
    return data;





  }
}







