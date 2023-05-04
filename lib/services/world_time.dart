import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
class WorldTime{
  String location;
  String time = '';
  String flag;
  String url;
  bool? isDaytime;

  WorldTime({required this.location, required this.flag, required this.url})
  {
    isDaytime = false;
  }

  Future<void> getTime() async {
    try {
      http.Response response = await http.get(
          Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      isDaytime ??= false;
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('Abdullah caught error : $e');
      time = 'Sorry!, Could not get Time data due to some errors';
    }
  }
}

