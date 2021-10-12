//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/ExtraWeather.dart';

import 'Network.dart';
import 'WeatherModel.dart';
import 'bloc/WeatherBloc.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.blue),


        ),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xff00A1FF),
          body: BlocProvider(
            create: (BuildContext context) => WeatherBloc(Network()),
            child: SearchPage(),
          ),
        )
    );
  }
}




class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    var cityController = TextEditingController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[






        BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state){
            print(state);
            if(state is WeatherIsNotSearched)
              return GlowContainer(
                padding: EdgeInsets.only(left: 32, right: 32,top: 200,bottom: 200),
                glowColor: Color(0xff00A1FF).withOpacity(0.5),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
                color: Color(0xff00A1FF),
                child: Column(
                  children: <Widget>[
                    Text("Search Weather", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500, color: Colors.white70),),
                    SizedBox(height: 24,),
                    TextFormField(
                      controller: cityController,

                      decoration: InputDecoration(

                        prefixIcon: Icon(Icons.search, color: Colors.white70,),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Colors.white70,
                                style: BorderStyle.solid
                            )
                        ),

                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Colors.blue,
                                style: BorderStyle.solid
                            )
                        ),

                        hintText: "Enter a city name...",
                        hintStyle: TextStyle(color: Colors.white70),

                      ),
                      style: TextStyle(color: Colors.white70),

                    ),

                    SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: FlatButton(
                        shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        onPressed: (){
                          weatherBloc.add(FetchWeather(cityController.text));
                        },
                        color: Colors.blueGrey,
                        child: Text("Search", style: TextStyle(color: Colors.white70, fontSize: 16),),

                      ),
                    )

                  ],
                ),
              );
            else if(state is WeatherIsLoading)
              return Center(child : CircularProgressIndicator());
            else if(state is WeatherIsLoaded)
              return ShowWeather(state.getWeather, cityController.text);
            else
              return Text("Error",style: TextStyle(color: Colors.white),);
          },
        )

      ],
    );
  }
}

class ShowWeather extends StatelessWidget {
  WeatherModel weather;
  final city;

  ShowWeather(this.weather, this.city);

  @override
  Widget build(BuildContext context) {

    return GlowContainer(
        padding: EdgeInsets.only(left: 32, right: 32,),
        glowColor: Color(0xff00A1FF).withOpacity(0.5),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
        color: Color(0xff00A1FF),
        child: Column(
          children: <Widget>[
            Container(
              child: Text(city,style: TextStyle(
                fontSize: 25,
              ),),
            ),

            Container(
              child: Stack(
                children: [

                  Image(image: AssetImage(weather.getMain),
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    bottom:0,
                    right: 0,
                    left: 0,
                    child: Center(
                      child: Column(
                        children: [
                          GlowText(
                            weather.getTemp.round().toString()+"°C",
                            style: TextStyle(
                              height: 0.1,
                              fontSize: 60,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(weather.getDescription,
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          Text(DateFormat.yMd().format(DateTime.now()),
                          style:TextStyle(
                          fontSize: 18,
                          )
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),

            ),
           Divider(
             color: Colors.white,
           ),
           SizedBox(
             height: 10,
           ),
           ExtraWeather(weather),
           /* Text(city,style: TextStyle(color: Colors.white70, fontSize: 30, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),

            Text(weather.getTemp.round().toString()+"C",style: TextStyle(color: Colors.white70, fontSize: 50),),
            Text("Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(weather.getMinTemp.round().toString()+"C",style: TextStyle(color: Colors.white70, fontSize: 30),),
                    Text("Min Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(weather.getMaxTemp.round().toString()+"C",style: TextStyle(color: Colors.white70, fontSize: 30),),
                    Text("Max Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),
                  ],
                ),
              ],
            ),*/
            SizedBox(
              height: 20,
            ),

            Container(
              width: double.infinity,
              height: 50,
              child: FlatButton(
                shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                onPressed: (){
                  BlocProvider.of<WeatherBloc>(context).add(ResetWeather());
                },
                color: Colors.blueGrey,
                child: Text("Search", style: TextStyle(color: Colors.white70, fontSize: 16),),

              ),
            )
          ],
        )
    );
  }
}

