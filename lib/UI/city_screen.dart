import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
 

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body:Container(
         decoration: BoxDecoration(
           image: DecorationImage(
             image: AssetImage('assets/backgroundw.jpg'),
             fit: BoxFit.cover,
           ),
         ),
        // constraints: BoxConstraints.expand(),
         child: SafeArea(
           child: Column(
             children: [
               Align(
                 alignment: Alignment.topLeft,
                 child: TextButton(onPressed: (){
                   Navigator.pop(context);
                 },
                  child: Icon(
                  Icons.arrow_back_ios_sharp,
                  size: 25,
                  color:Colors.white,
                  )
                  ),
               ),
               Container(
                 padding: EdgeInsets.all(20),
                 child:TextField(
                   style: TextStyle(
                     color: Colors.black,
                   ),
                   decoration: InputDecoration(
                     filled:true,
                     hintText: 'Enter city name',
                     fillColor:Colors.white,
                     icon: Icon(
                       Icons.location_city_sharp,
                       color: Colors.white,                         
                       ),
                       hintStyle: TextStyle(
                         color: Colors.grey,
                       ),
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.all(Radius.circular(30),
                         ),
                         borderSide: BorderSide.none,
                       )
                   ),
                   onChanged: (v){
                     cityName=v;
                   },
                 ),
               ),
               TextButton(onPressed: (){
                 Navigator.pop(context,cityName);
               
               }, child: Text('weather data',
               style: TextStyle(
                 fontSize: 40,
                 fontWeight: FontWeight.bold
               ),),
               )
               ],
           ),),
       ),
    );
  }
}