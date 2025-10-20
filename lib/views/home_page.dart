import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weatherapp/bloc/weather_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(WeatherFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 44, 41, 41),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(221, 44, 41, 41),
        title: Text(
          "MY Weather",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsGeometry.only(left: 20),
            child: IconButton(
              onPressed: () {
                context.read<WeatherBloc>().add(WeatherFetched());
              },
              icon: Icon(CupertinoIcons.refresh, color: Colors.white, size: 40),
            ),
          ),
        ],
      ),
      body: BlocConsumer<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is WeatherSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("weather is loaded succresfully")),
            );
          }
        },
        builder: (context, state) {
          if (state is WeatherSuccess) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        "${state.watherModel.name}",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "(${state.watherModel.coord?.lat},${state.watherModel.coord?.lon}) ${state.watherModel.sys?.country}",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(221, 46, 23, 9),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.deepOrangeAccent,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.cloud_fill,
                              color: Colors.white,
                              size: 60,
                            ),
                            Text(
                              "${state.watherModel.main!.temp!.toInt() - 273} °C",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                            Text(
                              "${state.watherModel.weather?[0].description}",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Center(
                      child: Text(
                        "Temperature",
                        style: GoogleFonts.piazzolla(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset("assets/tmp.svg", height: 50),
                            Text(
                              "${state.watherModel.main!.feelsLike!.toInt() - 273} °C",
                              style: GoogleFonts.labrada(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Feels Like",
                              style: GoogleFonts.labrada(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SvgPicture.asset("assets/tmp.svg", height: 50),
                            Text(
                              "${state.watherModel.main!.tempMax!.toInt() - 273} °C",
                              style: GoogleFonts.labrada(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Max Temp",
                              style: GoogleFonts.labrada(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SvgPicture.asset("assets/tmp.svg", height: 50),
                            Text(
                              "${state.watherModel.main!.tempMin!.toInt() - 273} °C",
                              style: GoogleFonts.labrada(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Min temp",
                              style: GoogleFonts.labrada(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Center(
                      child: Text(
                        "Additional Information",
                        style: GoogleFonts.piazzolla(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(
                              CupertinoIcons.eye_fill,
                              color: Colors.white,
                              size: 45,
                            ),
                            Text(
                              "${state.watherModel.visibility! / 1000} Km",
                              style: GoogleFonts.labrada(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              CupertinoIcons.wind,
                              color: Colors.white,
                              size: 45,
                            ),
                            Text(
                              "${state.watherModel.wind?.speed} KPH",
                              style: GoogleFonts.labrada(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              CupertinoIcons.compass_fill,
                              color: Colors.white,
                              size: 45,
                            ),
                            Text(
                              "${state.watherModel.wind?.deg} °",
                              style: GoogleFonts.labrada(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(
                              CupertinoIcons.cloud_sun_bolt_fill,
                              color: Colors.white,
                              size: 45,
                            ),
                            Text(
                              "${state.watherModel.main?.pressure} Pa",
                              style: GoogleFonts.labrada(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SvgPicture.asset(
                              "assets/water.svg",
                              height: 50,
                              color: Colors.white,
                            ),
                            Text(
                              "${state.watherModel.main?.humidity} %",
                              style: GoogleFonts.labrada(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is WeatherError) {
            return Center(child: Text(state.error));
          } else {
            return Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
        },
      ),
    );
  }
}
