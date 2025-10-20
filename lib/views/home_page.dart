import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/reposotory/wather_remote.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final weatherRemote = WatherRemote();
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
            fontSize: 10,
          ),
        ),
        actions: [Padding(padding: EdgeInsetsGeometry.only(left: 20))],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            weatherRemote.fetchData();
          },
          child: Text("get data"),
        ),
      ),
    );
  }
}
