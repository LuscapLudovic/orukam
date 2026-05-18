enum PersonType { referee, commissioner }

class Person {
  final int? id;
  final String name;
  final PersonType type;
  final int? tapisId; // null means competition level
  final bool isLead;

  Person({
    this.id,
    required this.name,
    required this.type,
    this.tapisId,
    this.isLead = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.index,
      'tapisId': tapisId,
      'isLead': isLead ? 1 : 0,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'],
      name: map['name'],
      type: PersonType.values[map['type']],
      tapisId: map['tapisId'],
      isLead: map['isLead'] == 1,
    );
  }

  Person copyWith({
    int? id,
    String? name,
    PersonType? type,
    int? tapisId,
    bool? isLead,
  }) {
    return Person(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      tapisId: tapisId ?? this.tapisId,
      isLead: isLead ?? this.isLead,
    );
  }
}

class Tapis {
  final int? id;
  final String name;

  Tapis({this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Tapis.fromMap(Map<String, dynamic> map) {
    return Tapis(
      id: map['id'],
      name: map['name'],
    );
  }
}
