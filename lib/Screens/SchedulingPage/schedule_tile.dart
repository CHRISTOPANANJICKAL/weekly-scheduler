import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:scheduler/ButtonDataModel/button_data_model.dart';
import 'package:scheduler/Providers/buttons_provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:provider/provider.dart';

class ScheduleTile extends StatelessWidget {
  final DataModel dataModel;
  const ScheduleTile(
      {Key? key,
      required this.dataModel,
     })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  dataModel.setCheck(!dataModel.check);
                  context.read<ButtonsProvider>().refreshData(dataModel);
                },
                icon: Icon(
                  Icons.check_circle,
                  color: (dataModel.check)? Colors.green : Colors.grey,
                )),
            SizedBox(
              width: context.percentWidth *13,
              child: Text(dataModel.day,style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12
              ),),
            ),
            if(dataModel.check)
            Buttons(text: "Morning", dataModel: dataModel),
            if(dataModel.check)
            Buttons(text: "Afternoon", dataModel: dataModel),
            if(dataModel.check)
            Buttons(text: "Evening", dataModel: dataModel),
            if(!dataModel.check)
              const Text("Unavailable",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,color: Colors.grey
              ),),
          ],
        ),
        const Divider()
      ],
    );
  }
}



class Buttons extends StatelessWidget {
  final String text;
  final DataModel dataModel;
  const Buttons({Key? key, required this.text, required this.dataModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: context.percentWidth*2),
      child: MaterialButton(
        minWidth: 0,
        padding: EdgeInsets.symmetric(horizontal: context.percentWidth*5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color:(text == "Morning")?((dataModel.morning)?Colors.indigo:Colors.grey):(text == "Afternoon")?((dataModel.afternoon)?Colors.indigo:Colors.grey):(dataModel.evening)?Colors.indigo:Colors.grey)),
        onPressed: () {
          if(text =="Morning"){
            dataModel.setMorning(!dataModel.morning);
          }else if(text =="Afternoon"){
            dataModel.setAfterNoon(!dataModel.afternoon);
          }else if(text == "Evening"){
            dataModel.setEvening(!dataModel.evening);
          }
          context.read<ButtonsProvider>().refreshData(dataModel);
        },
        child: Text(text,style: TextStyle(
            fontSize:11,
            color:(text == "Morning")?((dataModel.morning)?Colors.indigo:Colors.grey):
            (text == "Afternoon")?((dataModel.afternoon)?Colors.indigo:Colors.grey):
            (dataModel.evening)?Colors.indigo:Colors.grey)
        ),
      ),
    );
  }
}
