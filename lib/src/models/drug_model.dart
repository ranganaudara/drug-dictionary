// To parse this JSON data, do
//
//     final drug = drugFromJson(jsonString);

import 'dart:convert';

Drug drugFromJson(String str) => Drug.fromMap(json.decode(str));

String drugToJson(Drug data) => json.encode(data.toMap());

class Drug {
  int id;
  String name;
  String maxDose;
  String whenToTake;
  String interactions;
  String instructions;
  int favourite;

  Drug({
    this.id,
    this.name,
    this.maxDose,
    this.whenToTake,
    this.interactions,
    this.instructions,
    this.favourite,
  });

  factory Drug.fromMap(Map<String, dynamic> json) => Drug(
    id: json["id"],
    name: json["name"],
    maxDose: json["max_dose"],
    whenToTake: json["when_to_take"],
    interactions: json["interactions"],
    instructions: json["instructions"],
    favourite: json["favourite"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "max_dose": maxDose,
    "when_to_take": whenToTake,
    "interactions": interactions,
    "instructions": instructions,
    "favourite": favourite,
  };
}