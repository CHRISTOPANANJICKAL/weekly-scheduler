import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:scheduler/ButtonDataModel/button_data_model.dart';


class ButtonsProvider extends ChangeNotifier {
  bool check = false;
  bool dataLoaded = false;
  bool dataLoading = false;
  String error = "";
  String textViewText = "you are not available on any days according to schedules.";
  String buttonText = "Add Schedule";
  late File file;
  setDataLoaded(bool value) {
    dataLoaded = value;
    notifyListeners();
  }

  setDataLoading(bool value) {
    dataLoading = value;
    notifyListeners();
  }

  String getError(){
    return error;
  }


  late DataModel sunday;
  late DataModel monday;
  late DataModel tuesday;
  late DataModel wednesday;
  late DataModel thursday;
  late DataModel friday;
  late DataModel saturday;

  refreshData(DataModel dataModel){
    if(dataModel.day == "SUN"){
      sunday = dataModel;
    }else if(dataModel.day == "MON"){
      monday = dataModel;
    }else if(dataModel.day == "TUE"){
      tuesday = dataModel;
    }else if(dataModel.day == "WED"){
      wednesday = dataModel;
    }else if(dataModel.day == "THU"){
      thursday = dataModel;
    }else if(dataModel.day == "FRI"){
      friday = dataModel;
    }else if(dataModel.day == "SAT"){
      saturday = dataModel;
    }
    notifyListeners();
  }


  getData() async {
    try {
      final _dir = await getApplicationDocumentsDirectory();
      file = File(_dir.path+"/data/data.json");
      if(!file.existsSync()){
        Directory(_dir.path+"/data/").createSync(recursive: true);
        String json  = await rootBundle.loadString('assets/data.json');
        file.createSync();
        await file.writeAsString(json);
      }

      String dataStr = await file.readAsString();

      var data = jsonDecode(dataStr);
      sunday = dataModelFromJson(data["sunday"]);
      monday = dataModelFromJson(data["monday"]);
      tuesday = dataModelFromJson(data["tuesday"]);
      wednesday = dataModelFromJson(data["wednesday"]);
      thursday = dataModelFromJson(data["thursday"]);
      friday = dataModelFromJson(data["friday"]);
      saturday = dataModelFromJson(data["saturday"]);
      error = "";
      dataLoading = false;
      dataLoaded = true;
      textViewText = getTextViewText();
      buttonText = getButtonText();
      notifyListeners();
    } catch (e) {
      error = e.toString();
      dataLoading = false;
      dataLoaded = false;
      notifyListeners();
    }
  }

  saveData() async {
    String sun = dataModelToJson(sunday);
    String mon = dataModelToJson(monday);
    String tue = dataModelToJson(tuesday);
    String wed = dataModelToJson(wednesday);
    String thu = dataModelToJson(thursday);
    String fri = dataModelToJson(friday);
    String sat = dataModelToJson(saturday);

    String jsonString = '{"sunday":$sun,"monday":$mon,"tuesday":$tue,"wednesday":$wed,"thursday":$thu,"friday":$fri,"saturday":$sat}';
    await file.writeAsString(jsonString);

    textViewText = getTextViewText();
    buttonText = getButtonText();
    notifyListeners();
  }



   String getTextViewText(){
    String nameStr =  "you are available in ";
    String str = getString(sunday)+getString(monday)+getString(tuesday)+getString(wednesday)+getString(thursday)+getString(friday)+getString(saturday);
    if (str.isNotEmpty) {
      str = str.substring(0, str.length - 1);
      buttonText = "Edit Schedule";
      return nameStr+str+".";
    }else{
      buttonText = "Add Schedule";
      return "you are not available on any days according to schedules.";
    }
  }


  String getString(DataModel dataModel){
    String day = "";
    if(dataModel.check){
      if(dataModel.day =="SUN"){
        day = "Sunday";
      }else if(dataModel.day =="MON"){
        day = "Monday";
      }else if(dataModel.day =="TUE"){
        day = "Tuesday";
      }else if(dataModel.day =="WED"){
        day = "Wednesday";
      }else if(dataModel.day =="THU"){
        day = "Thursday";
      }else if(dataModel.day =="FRI"){
        day = "Friday";
      }else if(dataModel.day =="SAT"){
        day = "Saturday";
      }
      if(dataModel.morning && dataModel.afternoon && dataModel.evening){
        return "$day whole day,";
      }
      if(dataModel.morning && dataModel.afternoon){
        return "$day Morning and Afternoon,";
      }
      if(dataModel.morning && dataModel.evening){
        return "$day Morning and Evening,";
      }
      if(dataModel.afternoon && dataModel.evening){
        return "$day Afternoon and Evening,";
      }
      if(dataModel.morning){
        return "$day Morning,";
      }
      if(dataModel.afternoon){
        return "$day Afternoon,";
      }
      if(dataModel.evening){
        return "$day Evening,";
      }else {
        return "";
      }
    }
    return "";
  }


  String getButtonText(){
    return buttonText;
  }
}
