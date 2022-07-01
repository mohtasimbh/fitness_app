import 'dart:convert';

import 'package:fitness_api/details_page.dart';
import 'package:fitness_api/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json";
  List<Exercises> allData = [];
  late Exercises exercises;
  fatchData() async {
    var responce = await http.get(Uri.parse(url));
    print("Status code is ${responce.statusCode}");

    if (responce.statusCode == 200) {
      final item = jsonDecode(responce.body);
      for (var data in item["exercises"]) {
        exercises = Exercises(
          id: data["id"],
          title: data["title"],
          thumbnail: data["thumbnail"],
          seconds: data["seconds"],
          gif: data["gif"],
        );
        setState(() {
          allData.add(exercises);
        });
      }
    }
  }

  @override
  void initState() {
    fatchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: allData.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailsPage(
                    exercises: allData[index],
                  )));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  height: 150,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        Image.network(
                          "${allData[index].gif}",
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              height: 65,
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "${allData[index].title}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800),
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                    Colors.black12,
                                    Colors.black54,
                                    Colors.black87,
                                    Colors.black
                                  ])),
                            ))
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
