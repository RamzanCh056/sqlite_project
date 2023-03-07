import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../common/common_text_field.dart';
import '../sql/sql healper.dart';


class EvaluationRecordAdd extends StatefulWidget {
  const EvaluationRecordAdd({Key? key}) : super(key: key);

  @override
  State<EvaluationRecordAdd> createState() => _EvaluationRecordAddState();
}

class _EvaluationRecordAddState extends State<EvaluationRecordAdd> {
  // All journals
  List<Map<String, dynamic>> _journals = [];
  GlobalKey<FormState> key = GlobalKey<FormState>();

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }

  final TextEditingController _courseName = TextEditingController();
  final TextEditingController _assessmentType = TextEditingController();
  final TextEditingController _dateTime = TextEditingController();
  final TextEditingController _difficultyLevel = TextEditingController();
  final TextEditingController _notes = TextEditingController();
  DateTime? fDate;

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


// Insert a new journal to the database
  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _courseName.text, _assessmentType.text , fDate!.millisecondsSinceEpoch,_difficultyLevel.text,_notes.text
    );
    _refreshJournals();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully add  evaluation!'),
    ));
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id,  _courseName.text, _assessmentType.text , fDate!.millisecondsSinceEpoch ,_difficultyLevel.text,_notes.text  );
    _refreshJournals();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add edit evaluation'),
      ),
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Form(
            key: key,
            child: Column(children: [
              CommonTextFieldWithTitle('Course Name', 'Enter course name',_courseName ,
                      (val) {
                    if (val!.isEmpty) {
                      return 'This is required field';
                    }
                  }),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  showDialogForlevel();
                },
                child: CommonTextFieldWithTitle(

                    'Difficulty Level', 'Enter level',_difficultyLevel ,
                        enabled: false,
                        suffixIcon: Icon(Icons.arrow_drop_down_rounded),
                        (val) {
                      if (val!.isEmpty) {
                        return 'This is required field';
                      }
                    }),
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  showDialogForAssesment();
                },
                child: CommonTextFieldWithTitle(

                    'Assessment Type', 'Enter type',_assessmentType ,
                    enabled: false,
                    suffixIcon: Icon(Icons.arrow_drop_down_rounded),
                        (val) {
                      if (val!.isEmpty) {
                        return 'This is required field';
                      }
                    }),
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  selectDate(context,0);
                },
                child: CommonTextFieldWithTitle(

                    'Date Time', 'Enter',_dateTime ,
                    enabled: false,
                    suffixIcon: Icon(Icons.arrow_drop_down_rounded),
                        (val) {
                      if (val!.isEmpty) {
                        return 'This is required field';
                      }
                    }),
              ),
              SizedBox(height: 15,),
              CommonTextFieldWithTitle('Notes', 'Enter Notes',_notes ,
                      (val) {
                    if (val!.isEmpty) {
                      return 'This is required field';
                    }
                  }),
              SizedBox(height: 15,),
              buttonWidget()

            ],),
          ),
        ),
      )
      // _isLoading
      //     ? const Center(
      //   child: CircularProgressIndicator(),
      // )
      //     : ListView.builder(
      //     itemCount: _journals.length,
      //     itemBuilder: (context, index) => Card(
      //       color: Colors.orange[200],
      //       margin: const EdgeInsets.all(15),
      //       child:  Slidable(
      //         key: const ValueKey(0),
      //         endActionPane: ActionPane(
      //           motion: const ScrollMotion(),
      //           extentRatio: 0.13,
      //           children: [
      //             SlidableAction(
      //               onPressed:
      //                   (BuildContext context) {
      //                 setState(() {
      //                   _deleteItem(_journals[index]['id']);
      //                 });
      //                 print(index);
      //               },
      //               borderRadius:
      //               BorderRadius.circular(
      //                   12),
      //               backgroundColor:
      //               const Color(0xFFFD4F87),
      //               foregroundColor:
      //               Colors.white,
      //               padding:
      //               const EdgeInsets.only(
      //                   right: 10,
      //                   top: 10,
      //                   left: 10),
      //               icon: Icons.delete,
      //             ),
      //           ],
      //         ),
      //
      //         // The child of the Slidable is what the user sees when the
      //         // component is not dragged.
      //         child:   Container(
      //           width: double.infinity,
      //           //margin: EdgeInsets.all(10),
      //           child: Padding(
      //             padding:  EdgeInsets.all(5.0),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text("Course Name : ${_journals[index]['courseName']}" ),
      //                 SizedBox(
      //                   height: 10,
      //                 ),
      //                 Text('Difficulty Level: ${_journals[index]['level']}'),
      //                 SizedBox(
      //                   height: 10,
      //                 ),
      //                 Text("Assesment Type : ${_journals[index]['assessmentType']}"),
      //                 SizedBox(
      //                   height: 10,
      //                 ),
      //                 Text("dateTime : ${_journals[index]['datetime']}"),
      //                 SizedBox(
      //                   height: 10,
      //                 ),
      //
      //
      //                 Text("Notes : ${_journals[index]['notes']}"),
      //                 SizedBox(
      //                   height: 10,
      //                 ),
      //                 ElevatedButton(
      //                     onPressed: () {
      //                       _showForm(_journals[index]['id']);
      //                     }, child: const Text("Edit Record"))
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     )
      // ),
      // floatingActionButton: FloatingActionButton(
      //
      //   child: const Icon(Icons.add),
      //   onPressed: () => _showForm(null),
      // ),
    );
  }
  selectDate(BuildContext context, int index) async {
    DateTime? selectDate;
    await DatePicker.showDateTimePicker(context,
        showTitleActions: true, onChanged: (date) {}, onConfirm: (date) {
          selectDate = date;
        }, currentTime: DateTime.now());
    if (selectDate != null) {
      setState(() {
        if (index == 0) {
          _dateTime.text = DateFormat('yyyy-MM-dd – kk:mm a').format(selectDate!);
          fDate = selectDate;
          // eta.text =
          //     '${selectDate!.day}/${selectDate!.month}/${selectDate!.year}';

        }

      });
    }
  }
  showDialogForAssesment() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            titlePadding: EdgeInsets.zero,
            title: titleForDialog(context, 'Select Assessment'),
            content: Container(
              height: 200,
              width: 300,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                assesment[index],
                                maxLines: 2,
                                style: TextStyle(fontSize: 13),
                              )),
                        ],
                      ),
                      height: 40,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _assessmentType.text = assesment[index];
                      setState(() {});
                    },
                  );
                },
                itemCount: assesment.length,
                shrinkWrap: true,
              ),
            ),
          );
        });
  }
  Widget titleForDialog(BuildContext context, String title) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Center(
        child: Text(title,
            style:
            const TextStyle(color: Colors.white, fontSize: 17, height: 1.55),
            textAlign: TextAlign.center),
      ),
    );
  }
  showDialogForlevel() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            titlePadding: EdgeInsets.zero,
            title: titleForDialog(context, 'Select Assessment'),
            content: Container(
              height: 200,
              width: 300,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                levels[index],
                                maxLines: 2,
                                style: TextStyle(fontSize: 13),
                              )),
                        ],
                      ),
                      height: 40,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _difficultyLevel.text = levels[index];
                      setState(() {});
                    },
                  );
                },
                itemCount: levels.length,
                shrinkWrap: true,
              ),
            ),
          );
        });
  }
  Widget buttonWidget() {
    return ButtonTheme(
      height: 47,
      minWidth: MediaQuery.of(context).size.width,
      child: MaterialButton(
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onPressed: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          if (key.currentState!.validate()) {
            _addItem();
          }
        },
        child: Text(
            'Add',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }
}