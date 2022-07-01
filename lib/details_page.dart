import 'package:fitness_api/model.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key? key, this.exercises}) : super(key: key);

  Exercises? exercises;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  double second = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.network(
            "${widget.exercises!.thumbnail}",
            fit: BoxFit.fill,
          ),
          Text(
            "${widget.exercises!.title}",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w800),
          ),
          Text(
            "${widget.exercises!.id}",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 250,
          ),
          SleekCircularSlider(
            innerWidget: (value) {
              return Container(
                alignment: Alignment.center,
                child: Text("${second.toStringAsFixed(0)} Sec"),
              );
            },
            appearance: CircularSliderAppearance(
                customWidths: CustomSliderWidths(progressBarWidth: 15),
                customColors: CustomSliderColors(
                  progressBarColor: Colors.orange,
                )),
            min: 3,
            max: 100,
            initialValue: second,
            onChange: (value) {
              setState(() {
                second = value;
              });
            },
          ),
          MaterialButton(
            color: Colors.orange,
            onPressed: () {},
            child: Text("Start"),
          )
        ],
      ),
    );
  }
}
