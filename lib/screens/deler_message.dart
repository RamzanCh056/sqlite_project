import 'package:flutter/material.dart';

class DelarMessage extends StatefulWidget {
  const DelarMessage({Key? key}) : super(key: key);

  @override
  State<DelarMessage> createState() => _DelarMessageState();
}

class _DelarMessageState extends State<DelarMessage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    height: MediaQuery
                        .of(context)
                        .size
                        .width * 0.4,
                    alignment: Alignment.center,
                    decoration:
                    BoxDecoration(border: Border.all(color: Colors.black,)),
                    child: const Text(
                        "Dealer Message!!\nWe will have an evaluation of <subject name>, on <date and time>, with the difficulty of <difficulty> on a scale of 1 to 5.\n\nNotes for this review: <notes>"),),
                  const SizedBox(height: 10,),
                  InkWell(
                      onTap: (){
                      },
                      child: const Icon(Icons.share))
                ],
              ),
            ),
          )
        ),
        );
  }
}
