import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

import '../sql/sql healper.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Map<String, dynamic>> _journals = [];
  List<Map<String, dynamic>> counts = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
   _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
      average;
      averagesecond;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
    averageFunction();
    setState(() {
      average;
      averagesecond;
    });
    print("average hai ==${average}");
  }
  var average;
  var averagesecond;
   int? levels;
   var name =[];

averageFunction(){
  Future.delayed(const Duration(seconds: 3), () {
   setState(() {
     average;
     averagesecond;
   });
  });



}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('DashBoard'),
          ),
          body: SingleChildScrollView(
            child: RefreshIndicator(
              onRefresh: ()async{
                setState(() {
                  average;
                  averagesecond;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),

                   Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Average Evaluations for next 7 days is ${average ==null? "calculating":average.toString()}", style: TextStyle(fontSize: 16),),
                  ),
                  const SizedBox(height: 10,),
                  _isLoading
                      ?  const Center(
                    child: CircularProgressIndicator(),
                  )
                      : ListView.builder(
                    shrinkWrap: true,
                      itemCount: _journals.length,
                      itemBuilder: (context, index) {
                        averageFunction();
                        var dat = DateFormat('yyyy-MM-dd').format(
                            DateTime.fromMillisecondsSinceEpoch(int.parse(
                                _journals[index]['datetime'].toString(),
                            ) )
                        ),


                            dateForCheck = Jiffy(dat , "yyyy-MM-dd" ).fromNow();
                        print('date check=${dateForCheck}');
                        dateForCheck.toString().contains("in 7 days") || dateForCheck.toString().contains("month ago") ? Container():

                        average = int.parse(_journals[index]['level']) / _journals[index]['level'].length;
                      return
                        dateForCheck.toString().contains("in 7 days") || dateForCheck.toString().contains("month ago") ? Container():

                        GestureDetector(onTap: (){

                          print('date check=${_journals[index]['level'].length.toString()}');
                          //averageFunction();
                        },
                          child: Card(
                            color: Colors.teal[200],
                            margin: const EdgeInsets.all(15),
                            child:  Container(
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

                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }



                  ),
                   Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Evaluations average 14 days is ${averagesecond ==null ? "cal" :averagesecond.toString()}", style: TextStyle(fontSize: 16),),

                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: _journals.length,
                      itemBuilder: (context, index) {
                        var dat = DateFormat('yyyy-MM-dd').format(
                            DateTime.fromMillisecondsSinceEpoch(int.parse(
                              _journals[index]['datetime'].toString(),
                            ) )
                        ),

                            dateForCheck = Jiffy(dat , "yyyy-MM-dd" ).fromNow();
                        print('date check=$dateForCheck');
                        dateForCheck.toString().contains("days ago") || dateForCheck.toString().contains("hours ago") ? Container():
                        averagesecond = int.parse(_journals[index]['level']) / _journals[index]['level'].length;
                        return
                          dateForCheck.toString().contains("days ago") || dateForCheck.toString().contains("hours ago") ? Container():

                          GestureDetector(onTap: (){
                            averageFunction();
                          },
                            child: Card(
                              color: Colors.teal[200],
                              margin: const EdgeInsets.all(15),
                              child:  Container(
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

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                      }



                  ),
                ],
              ),
            ),
          )),
    );
  }
}
