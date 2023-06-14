import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)?.settings.arguments as Map;
    //print(data);

    //set background
    String image = data['isDayTime'] ? 'day.png' : 'night.png';
    Color bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$image'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.grey[800],
                        ),
                        onPressed: () async {
                          dynamic result =
                              await Navigator.pushNamed(context, '/location');
                          setState(() {
                            data = {
                              'time': result['time'],
                              'location': result['location'],
                              'flag': result['flag'],
                              'isDayTime': true,
                            };
                          });
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.edit_location,
                            ),
                            Text('Edit Location'),
                          ],
                        ),
                      ),
                    ),
                    //
                    const SizedBox(height: 20),
                    //
                    Text(
                      data['location'],
                      style: const TextStyle(
                        fontSize: 28,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(242, 223, 223, 223),
                      ),
                    ),
                    //
                    const SizedBox(height: 20),
                    //
                    Text(
                      data['time'],
                      style: const TextStyle(
                        fontSize: 66,
                        color: Color.fromARGB(242, 223, 223, 223),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
