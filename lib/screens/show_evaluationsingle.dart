import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Evaluation extends StatefulWidget {
   Evaluation(this.courseName, this.difficultyLevel, this.assesmentType,this.dateTime, this.notes,{Key? key}) : super(key: key);
  String courseName;
  String difficultyLevel;
  String assesmentType;
  String dateTime;
  String notes;
  @override
  State<Evaluation> createState() => _EvaluationState();
}

class _EvaluationState extends State<Evaluation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseName),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(children: [
          Container(
             color: Colors.greenAccent[200],
            width: double.infinity,
            //margin: EdgeInsets.all(10),
            child: Padding(
              padding:  const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text('Difficulty Level: ${widget.difficultyLevel}'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Assessment Type : ${widget.assesmentType}"),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Date Time ${ DateFormat('yyyy-MM-dd – kk:mm a')
                      .format(DateTime
                      .fromMillisecondsSinceEpoch(
                      int.parse(
                          widget.dateTime
                      ) ))}"
                  ),
                  const SizedBox(
                    height: 10,
                  ),


                  Text("Notes : ${widget.notes}"),
                  const SizedBox(
                    height: 10,
                  ),

                ],
              ),
            ),
          ),
        ],),
      ),
    );
  }
}
