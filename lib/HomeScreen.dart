import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shipment_tracking/Models/shipment.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

@override
State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
@override
Widget build(BuildContext context) {
var width = MediaQuery.of(context).size.width;
return Scaffold(
appBar: AppBar(
title: const Text('DTDC', style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic,
fontWeight: FontWeight.bold),),
),
body: Column(
children: [
SizedBox(height: width/20,),
Padding(
padding:  EdgeInsets.only( left: width/20),
child: Align(
alignment: Alignment.topLeft,
child: Text('Receiver Name: name' , style: TextStyle( color: Colors.black, fontSize: width/28),)),
),
SizedBox(height: width/20,),
Container(
height: width/8, width: width/1.05, color: Colors.blue,
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Padding(
padding:  EdgeInsets.only(left: width/20),
child: Text('Shipment Tracking History' , style: TextStyle(  decoration: TextDecoration.underline,
color: Colors.white, fontSize: width/28),),
),
Padding(
padding:  EdgeInsets.only(right: width/40),
child: CircleAvatar( 
backgroundColor: Colors.white,
child:  Icon(Icons.add, color: Colors.blue, size: width/10,),),
)  
],),
),
SizedBox(height: width/20,),
symbols(width, Icons.check_box, Icons.add_box, 'Pick Up', 'Booked & Dispatch'),
SizedBox(height: width/50,),
symbols(width, Icons.bus_alert, Icons.location_on, 'In Transit', 'At Destinat5ion'),
SizedBox(height: width/50,),
symbols(width, Icons.car_crash, Icons.circle, 'Out for Delivery', 'Delivered'),
SizedBox(height: width/20,),
Container(
height: width/10, width: width/1.05, color: Colors.blue,
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
children: [
Text('Date' , style: TextStyle( color: Colors.white, fontSize: width/28),),
Text('Activity' , style: TextStyle( color: Colors.white, fontSize: width/28),),
Text('From' , style: TextStyle( color: Colors.white, fontSize: width/28),),
Text('To' , style: TextStyle( color: Colors.white, fontSize: width/28),),
],),
),
Expanded(
child: StreamBuilder<Object>(
stream:  FirebaseFirestore.instance.collection('shipments').doc('12345')
.collection('12345').orderBy('orderBy').snapshots(),
builder: (context, snapshot) {
if (!snapshot.hasData) {
return const Text('Data not found');
} else {
QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;
return     ListView.builder(
itemCount: dataSnapshot.docs.length,
itemBuilder: (BuildContext context, int index) {
ShipmentModel shipmentModel = ShipmentModel.fromMap(dataSnapshot.docs[index].data() as
Map<String , dynamic>);
return 
Padding(
padding:  EdgeInsets.symmetric(vertical: width/20),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
children: [
Text('${shipmentModel.date!.day.toString()}-'
'${shipmentModel.date!.month.toString().padLeft(2, '0')}-'
'${shipmentModel.date!.year.toString().padLeft(2, '0')}',
style: TextStyle(fontSize: width/40),
),
Row(
children: [
Icon(
shipmentModel.activity == 'Delivered' ?
Icons.circle : 
shipmentModel.activity == 'Out For Delivery' ?
Icons.car_crash: Icons.check_box),
SizedBox(width: width/100,),
SizedBox(
width: width/6,
child: Text(shipmentModel.activity.toString(), style: TextStyle(fontSize: width/35),)),
],
),
SizedBox( width: width/6,
child: Text(shipmentModel.from.toString(),  style: TextStyle(fontSize: width/35),)),
shipmentModel.to == null ?
const Icon(Icons.car_crash):
SizedBox( width: width/10,
child: Text(shipmentModel.to.toString(),  style: TextStyle(fontSize: width/35),)),
],
),
);
},
);
}
}
),
),
],
),
);
}
}
Widget symbols( width, icon1, icon2, text1, text2, ) {
return Padding(
padding:  EdgeInsets.only(left: width/20),
child:   Row(children: [
Container( height: width/10, width: width/2.3,
decoration: BoxDecoration(color: Colors.blue,
borderRadius: BorderRadius.circular(20),
),
child: Row( 
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon((icon1)),
SizedBox(width: width/50,),
Text(text1, style: TextStyle(color: Colors.white, fontSize: width/28),)
],),
),
SizedBox(width: width/50,),
Container( height: width/10, width: width/2.3,
decoration: BoxDecoration(color: Colors.blue,
borderRadius: BorderRadius.circular(20),
),
child: Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon((icon2)),
SizedBox(width: width/50,),
Text(text2, style: TextStyle(color: Colors.white, fontSize: width/28),)
],),
)
],),
);
}