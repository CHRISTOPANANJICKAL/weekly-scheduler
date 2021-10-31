import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheduler/Providers/buttons_provider.dart';
import 'package:scheduler/Screens/SchedulingPage/schedule_tile.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class SchedulingPage extends StatelessWidget {
  const SchedulingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Scheduler"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Set your weekly hours",
                  style: GoogleFonts.breeSerif(fontWeight: FontWeight.bold)),
              SizedBox(height: context.percentHeight*5,),
              ScheduleTile(
                  dataModel: context.watch<ButtonsProvider>().sunday),
              ScheduleTile(
                  dataModel: context.watch<ButtonsProvider>().monday),
              ScheduleTile(
                  dataModel: context.watch<ButtonsProvider>().tuesday),
              ScheduleTile(
                  dataModel: context.watch<ButtonsProvider>().wednesday),
              ScheduleTile(
                  dataModel: context.watch<ButtonsProvider>().thursday),
              ScheduleTile(
                  dataModel: context.watch<ButtonsProvider>().friday),
              ScheduleTile(
                  dataModel: context.watch<ButtonsProvider>().saturday),
              Align(
                alignment: Alignment.center,
                child: MaterialButton(
                  onPressed: () async {
                   await context.read<ButtonsProvider>().saveData();
                    Navigator.of(context).pop();
                  },
                  minWidth: 0,
                  padding: EdgeInsets.symmetric(
                      horizontal: context.percentWidth * 12),
                  color: Colors.indigo,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: const BorderSide(color: Colors.indigo)),
                  child:const Text("Save",style:TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),),
                ),
              )
            ],
          ),
        )
    );
  }

}

