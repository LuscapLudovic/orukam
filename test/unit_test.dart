import 'package:flutter_test/flutter_test.dart';
import 'package:orukam/models.dart';

void main() {
  group('Person Model Tests', () {
    test('Person toMap and fromMap works correctly', () {
      final person = Person(
        id: 1,
        name: 'Jean Arbitre',
        type: PersonType.referee,
        tapisId: 2,
        isLead: true,
      );

      final map = person.toMap();
      expect(map['id'], 1);
      expect(map['name'], 'Jean Arbitre');
      expect(map['type'], PersonType.referee.index);
      expect(map['tapisId'], 2);
      expect(map['isLead'], 1);

      final personFromMap = Person.fromMap(map);
      expect(personFromMap.id, person.id);
      expect(personFromMap.name, person.name);
      expect(personFromMap.type, person.type);
      expect(personFromMap.tapisId, person.tapisId);
      expect(personFromMap.isLead, person.isLead);
    });

    test('Person copyWith works correctly', () {
      final person = Person(
        name: 'Initial Name',
        type: PersonType.commissioner,
      );

      final updatedPerson = person.copyWith(name: 'New Name', isLead: true);
      
      expect(updatedPerson.name, 'New Name');
      expect(updatedPerson.type, PersonType.commissioner);
      expect(updatedPerson.isLead, true);
      expect(updatedPerson.id, isNull);
    });
  });

  group('Tapis Model Tests', () {
    test('Tapis toMap and fromMap works correctly', () {
      final tapis = Tapis(id: 1, name: 'Tapis Sud');
      
      final map = tapis.toMap();
      expect(map['id'], 1);
      expect(map['name'], 'Tapis Sud');

      final tapisFromMap = Tapis.fromMap(map);
      expect(tapisFromMap.id, 1);
      expect(tapisFromMap.name, 'Tapis Sud');
    });
  });
}
