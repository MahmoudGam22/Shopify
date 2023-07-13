// ignore_for_file: unused_import

import 'package:flutter/material.dart';

class CateogriesModel {
  late bool status;
  late CateogriesaData data;

  CateogriesModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = CateogriesaData.fromjson(json['data']);


  }
}

class CateogriesaData {
  late int currentpage;
  late List<Datamodel>data=[];
  CateogriesaData.fromjson(Map<String, dynamic> json) {
    currentpage = json['current_page'];
    json['data'].forEach((element){
      data.add(Datamodel.fromjson(element));
    });
  }

}

class Datamodel {
  late int id;
  late String name;
  late String image;
  Datamodel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
