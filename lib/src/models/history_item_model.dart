class HistoryItem {
  int id;
  String name;

  HistoryItem({
    this.id,
    this.name,
  });

  factory HistoryItem.fromMap(Map<String, dynamic> json) => HistoryItem(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
  };
}