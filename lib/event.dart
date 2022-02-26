class Event {
  final int? id;
  final String? name;
  final String? event;

  Event({
    this.id,
    this.name,
    this.event,
  });

  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'name':name,
      'event':event,
    };
  }

}
