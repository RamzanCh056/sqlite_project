import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pdf_project/screens/show_evaluationsingle.dart';
import 'package:pdf_project/screens/update%20evaluation.dart';
import 'package:share_plus/share_plus.dart';

import '../sql/sql healper.dart';


class Evaluations extends StatefulWidget {
  const Evaluations({Key? key}) : super(key: key);

  @override
  State<Evaluations> createState() => _EvaluationsState();
}

class _EvaluationsState extends State<Evaluations> {
  // All journals
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a evaluation!'),
    ));
    _refreshJournals();
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }


  List <String>assesment = [
    'frequency',
    'mini-test',
    'project',
    'defense',
  ];
  List <String>levels = [
    '1',
    '2',
    '3',
    '4',
    '5',
  ];

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evaluation'),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
              : ListView.builder(
          itemCount: _journals.length,
          itemBuilder: (context, index) {
            var dat = DateFormat('yyyy-MM-dd – kk:mm a').format(
                DateTime.fromMillisecondsSinceEpoch(int.parse(
                  _journals[index]['datetime'].toString(),
                ) )
            ),

                dateForCheck = Jiffy(dat , "yyyy-MM-dd – kk:mm a" ).fromNow();
            print('date check=$dateForCheck');
            return Card(
              color: Colors.orange[200],
              margin: const EdgeInsets.all(15),
              child:  GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Evaluation(
                      _journals[index]['courseName'],_journals[index]['level'],
                      _journals[index]['assessmentType'],_journals[index]['datetime'],_journals[index]['notes']


                  )));
                },
                child: Slidable(
                  key: const ValueKey(0),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.13,
                    children: [
                      SlidableAction(
                        onPressed:
                            (BuildContext context) {
                          setState(() {
                            dateForCheck.toString().contains("minute ago")|| dateForCheck.toString().contains("few seconds ago")
                                ||dateForCheck.toString().contains("an hour ago")||dateForCheck.toString().contains("minutes ago")||dateForCheck.toString().contains("minutes") ?
                            _deleteItem(_journals[index]['id'])
                                : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('You cannot  delete old evaluations.'),
                            ));
                          });
                          print(index);
                        },
                        borderRadius:
                        BorderRadius.circular(
                            12),
                        backgroundColor:
                        const Color(0xFFFD4F87),
                        foregroundColor:
                        Colors.white,
                        padding:
                        const EdgeInsets.only(
                            right: 10,
                            top: 10,
                            left: 10),
                        icon: Icons.delete,
                      ),
                    ],
                  ),

                  // The child of the Slidable is what the user sees when the
                  // component is not dragged.
                  child:   Container(
                    width: double.infinity,
                    //margin: EdgeInsets.all(10),
                    child: Padding(
                      padding:  const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Course Name : ${_journals[index]['courseName']}" ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('Difficulty Level: ${_journals[index]['level']}'),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("Assesment Type : ${_journals[index]['assessmentType']}"),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("Date Time ${ DateFormat('yyyy-MM-dd – kk:mm a')
                              .format(DateTime
                              .fromMillisecondsSinceEpoch(
                              int.parse(
                                  _journals[index]['datetime']
                              ) ))}"
                          ),
                          const SizedBox(
                            height: 10,
                          ),


                          Text("Notes : ${_journals[index]['notes']}"),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            ElevatedButton(
                                onPressed: () {
                                  dateForCheck.toString().contains("minute ago")|| dateForCheck.toString().contains("a few seconds ago")||
                                      dateForCheck.toString().contains("an hour ago")||dateForCheck.toString().contains("minutes ago") ||dateForCheck.toString().contains("minutes")?
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EvaluationUpdate(
                                      _journals[index]['id'],  _journals[index]['courseName'],_journals[index]['level'],
                                      _journals[index]['assessmentType'],_journals[index]['datetime'],_journals[index]['notes']


                                  )
                                  )
                                  ):
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text('You cannot edit old evaluations.'),
                                  ));
                                  // _showForm(_journals[index]['id']);
                                }, child: const Text("Edit Record")),
                            const SizedBox(width: 10,),
                            ElevatedButton(
                                onPressed: () {
                                  Share.share('${_journals[index]['courseName']},'
                                      ' ${_journals[index]['level']},'
                                      '${_journals[index]['assessmentType']}'
                                      ',${_journals[index]['datetime']},${_journals[index]['notes']}');
                                  // sharedata('dsds');
                                }, child: const Text("Share Record"))



                          ],)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );

          }
      ),
    );
  }



}