
import 'dart:convert';

DataModel dataModelFromJson(j) => DataModel.fromJson(j);

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    required this.day,
    required this.check,
    required this.morning,
    required this.afternoon,
    required this.evening,
  });

  final String day;
  bool check;
  bool morning;
  bool afternoon;
  bool evening;

  factory DataModel.fromJson(json) => DataModel(
    day: json["day"],
    check: json["check"],
    morning: json["morning"],
    afternoon: json["afternoon"],
    evening: json["evening"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "check": check,
    "morning": morning,
    "afternoon": afternoon,
    "evening": evening,
  };

  setMorning(bool value){
    morning = value;
  }
  setAfterNoon(bool value){
    afternoon = value;
  }
  setEvening(bool value){
    evening = value;
  }
  setCheck(bool value){
    check = value;
  }

}
