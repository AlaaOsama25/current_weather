import 'package:current_weather/model/models.dart';
import 'package:current_weather/network/modelsapi.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyHomePage> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();





   Future<WeatherResponse>? _response;

 // @override
  //  void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _response = DataService().getWeather(city);
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather '),
        backgroundColor: Colors.red.shade300,
      ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/pink sky_bta3t lol.jpg'),
              fit: BoxFit.cover
            )
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextFormField(
              controller: _cityTextController,
              decoration: InputDecoration(labelText: 'Search City',
              border: OutlineInputBorder()
              ),
              textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),



          ),
      ),
      ElevatedButton(
            onPressed: () {
              setState(() {
                _response = DataService().getWeather(_cityTextController.text);
              });
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red.shade300
            ),
            child: Text('Search')),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                (_response==null)? Text('no data yet') : buildfuturebuilder(),
              ],
            )
    ]),
        ));
  }

  FutureBuilder<WeatherResponse> buildfuturebuilder () {
    return FutureBuilder<WeatherResponse>(
      future: _response,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return
            Column(
              children: [

                Image.network(snapshot.data!.iconUrl),
                Text(
                  '${snapshot.data!.tempInfo.temperature}°',
                  style: TextStyle(fontSize: 60,color: Colors.white),
                ),
                SizedBox(height: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    Text(snapshot.data!.cityName.toUpperCase(),
                      style: TextStyle(fontSize: 20,color: Colors.white),
                    ),
                    Text(snapshot.data!.weatherInfo.description.toUpperCase(),
                      style: TextStyle(fontSize: 20,color: Colors.white),
                    ),
                  ],
                ),

              ],
            );
        }
        else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}