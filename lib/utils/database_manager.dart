import 'dart:convert';
import 'package:flutter/services.dart';

class DatabaseItem {
  final String id;
  final List<String> images;
  final String video;
  final Map<String, dynamic> vietnamese;
  final Map<String, dynamic> english;

  DatabaseItem({
    required this.id,
    required this.images,
    required this.video,
    required this.vietnamese,
    required this.english,
  });

  factory DatabaseItem.fromJson(Map<String, dynamic> json) {
    return DatabaseItem(
      id: json['id'],
      images: List<String>.from(json['images']),
      video: json['video'],
      vietnamese: json['vietnamese'],
      english: json['english'],
    );
  }
}

class DataManager {
  static final DataManager _instance = DataManager._internal();

  factory DataManager() {
    return _instance;
  }

  DataManager._internal();

  Future<List<DatabaseItem>> loadDatabase(String filePath) async {
    String data = await rootBundle.loadString(filePath);
    List<dynamic> jsonData = json.decode(data);
    return jsonData.map((item) => DatabaseItem.fromJson(item)).toList();
  }
}

class DatabaseManager {
  static final DatabaseManager _instance = DatabaseManager._internal();
  final DataManager _dataManager = DataManager();

  factory DatabaseManager() {
    return _instance;
  }

  DatabaseManager._internal();

  List<DatabaseItem> database = [];

  Future<void> loadDatabase() async {
    database = await _dataManager.loadDatabase('database/db_items.json');
  }
}
