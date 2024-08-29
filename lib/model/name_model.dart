class NameModel {
  int? id;
  String name;

  NameModel({this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  static NameModel fromMap(Map<String, dynamic> map) {
    return NameModel(
      id: map['id'],
      name: map['name'],
    );
  }
}
