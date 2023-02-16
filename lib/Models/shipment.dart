class ShipmentModel {


String? activity;
String?    from;
String?     to;
DateTime?   date;



ShipmentModel({
 
 this.activity,
 this.from,
 this.to,

});
 

ShipmentModel.fromMap(Map<String,dynamic> map) {

activity = map['activity'];
from = map['from'];
to = map['to'];
date = map['date'].toDate();


}

Map<String,dynamic> toMap() {

  return{
   
   'activity' : activity,
   'from' : from,
   'to' : to,
   'date' : date,
   
 
    
  };

}



}
