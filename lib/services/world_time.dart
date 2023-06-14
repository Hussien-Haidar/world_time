import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for the UI
  late String time; //the time in that location
  String flag; //url to an assset flag icon
  String url; //location url for api endpoint
  late bool isDaytime; //true or false if daytime or not

  WorldTime({required this.url, required this.location, required this.flag});

  Future<void> getTime() async {
    try {
      // make the request
      String ur = ('https://worldtimeapi.org/api/timezone/$url');
      final response = await http.get(Uri.parse(ur));
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //print(datetime);
      //print(offset);

      //create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      //print(now);

      time = DateFormat.jm().format(now); //set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true: false; //(?true : false is not neccesary)

    } catch (e) {
      //print('Caught error: $e');
      time = 'Could not get time data';
    }
  }
}
