import 'dart:convert';

class HistoryData {
  String? address;
  double? latitude;
  double? longitude;

  //HistoryData(this.address,this.latitude,this.longitude);

  HistoryData({
    this.address,
    this.latitude,
    this.longitude,
  });

  factory HistoryData.fromJson(Map<String, dynamic> jsonData) {
    return HistoryData(
      address: jsonData['address'],
      latitude: jsonData['latitude'],
      longitude: jsonData['longitude'],
    );
  }

  static Map<String, dynamic> toMap(HistoryData historyData) => {
    'address': historyData.address,
    'latitude': historyData.latitude,
    'longitude': historyData.longitude,
  };

  static String encode(List<HistoryData> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((historyData) => HistoryData.toMap(historyData))
        .toList(),
  );

  static List<HistoryData> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<HistoryData>((item) => HistoryData.fromJson(item))
          .toList();
  
  
}