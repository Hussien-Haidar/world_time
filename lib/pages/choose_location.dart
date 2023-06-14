import 'package:flutter/material.dart';
import '../services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  @override
  Widget build(BuildContext context) {

    List<WorldTime> locations = [
      WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
      WorldTime(url: 'Europe/Athens', location: 'Athens', flag: 'greece.png'),
      WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
      WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
      WorldTime(url: 'Asia/Lebanon', location: 'Beirut', flag: 'lebanon.jpg'),
      WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
      WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
      WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
      WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
    ];

    void updateTime(index) async {
      WorldTime instance = locations[index];
      await instance.getTime();
      // navigate to home screen
      
      // ignore: use_build_context_synchronously
      Navigator.pop(context, {
        'location': instance.location,
        'time': instance.time,
        'flag': instance.flag,
        'isDayTime': instance.isDaytime,
      });
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Choose a Location'),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        elevation: 0,
      ),
      // ignore: prefer_const_constructors
      body: SafeArea(
        child: Scrollbar(
          child: ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      //print(locations[i].location);
                      updateTime(i);
                    },
                    title: Text(
                      locations[i].location,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/${locations[i].flag}'),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
