import 'package:flutter/material.dart';
import 'package:pdf_project/screens/dashboard.dart';

import 'elevation_record_form.dart';
import 'elevation_record_list.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _curentIndex = 0;
   final List _pages = [Dashboard(), const EvaluationRecordAdd(),  Evaluations()];



  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: _pages[_curentIndex],
      bottomNavigationBar: BottomNavigationBar(

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Evaluations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Evaluation Record',
          ),
        ],
        currentIndex: _curentIndex,
        selectedItemColor: Colors.blue,
        onTap: (index){
          setState(() {
            _curentIndex = index;
          });
        },
      ),
    ));
  }
}
