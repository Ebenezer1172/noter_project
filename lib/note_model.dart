
class Note {
  String title;
  String description;
  String id;
  DateTime createdTime;
  bool isDone;
  bool isFavourite;
  String email;
  Note(this.title, this.description, this.id, this.createdTime, 
  this.isDone,this.isFavourite,this.email,  );
  
  Note fromJson(Map<String, dynamic> json) => Note(
        json['title'],
        json['description'],
        json['id'],
        json['createdTime'],
        json['isDone'],
        json['isFavourite'],
        json['email'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'id': id,
        'createdTime': createdTime,
        'isDone': isDone,
        'isFavourite': isFavourite,
        'email':email,
      };
}