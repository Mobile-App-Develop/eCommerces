// To parse this JSON data, do
//
//     final catagoryModel = catagoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CatagoryModel catagoryModelFromJson(String str) => CatagoryModel.fromJson(json.decode(str));

String catagoryModelToJson(CatagoryModel data) => json.encode(data.toJson());

class CatagoryModel {
  List<Catagory> catagory;

  CatagoryModel({
    required this.catagory,
  });

  factory CatagoryModel.fromJson(Map<String, dynamic> json) => CatagoryModel(
    catagory: List<Catagory>.from(json["catagory"].map((x) => Catagory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "catagory": List<dynamic>.from(catagory.map((x) => x.toJson())),
  };
}

class Catagory {
  String name;
  List<String> subcatagory;

  Catagory({
    required this.name,
    required this.subcatagory,
  });

  factory Catagory.fromJson(Map<String, dynamic> json) => Catagory(
    name: json["Name"],
    subcatagory: List<String>.from(json["subcatagory"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "subcatagory": List<dynamic>.from(subcatagory.map((x) => x)),
  };
}
