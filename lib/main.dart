import 'package:flutter/material.dart';
import 'package:weather_appp/additional_information.dart';
import 'package:weather_appp/current_weather.dart';
import 'package:weather_appp/weather_api_client.dart';
import 'package:weather_appp/weather_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;

  Future<void> getData() async {
    data = await client.getCurrentWeather("Switzerland");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFf9f9f9),
        appBar: AppBar(
          /*actions: [
            IconButton(onPressed: (){
              showSearch(context: context, delegate:  CustomSearchDelegate(),);
            },
              icon:const Icon(Icons.search) ,
            )
          ],*/
          backgroundColor: Color(0xFFf9f9f9),
          elevation: 0.0,
          title: Text(
            "Weather App",
            style: TextStyle(color: Colors.black87),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
            color: Colors.black87,
          ),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  currentWeather(Icons.wb_sunny_rounded, "${data!.temp}",
                      "${data!.cityName}"),
                  SizedBox(
                    height: 60.0,
                  ),
                  Text(
                    "Additional Information",
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Color(0xdd212121),
                        fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  SizedBox(
                    height: 20.0,
                  ),
                  additionalInformation("${data!.wind}", "${data!.humidity}",
                      "${data!.pressure}", "${data!.feels_like}"),
                ],
              );
            } else if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container();
          },
        ));
  }
}

/*class  CustomSearchDelegate extends SearchDelegate{
  List<String> searchTerms = [
    'Kanpur',
    'Lucknow',
    'Ghaziabad',
  ];
  @override
  List<Widget> buildActions(BuildContext context){
    return[
      IconButton(icon: const Icon(Icons.clear),
      onPressed: (){
        query = '';
      },)
    ];
  }
  @override
  Widget buidLeading(BuildContext context){
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: (){
        close(context,null);
      },
    );
  }
  @override
  Widget buildResults(BuildContext context){
    List<String> matchQuery = [];
    for (var city in searchTerms){
      if(city.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(city);
      }
    }
    return ListView.builder(itemCount: matchQuery.length,
    itemBuilder: (context,index){
      var result = matchQuery[index];
      return ListTile(
        title: Text(result),
      );
    },);
  }
  @override
  Widget buildSuggestions(BuildContext context){
    List<String> matchQuery = [];
    for (var city in searchTerms){
      if(city.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(city);
      }
  }
    return ListView.builder(itemCount: matchQuery.length,
      itemBuilder: (context,index){
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },);
}
}*/