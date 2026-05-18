import 'package:flutter/material.dart';
import '../models.dart';
import '../database_helper.dart';

class CompetitionProvider extends ChangeNotifier {
  List<Tapis> _tapisList = [];
  List<Person> _persons = [];
  String _competitionName = 'Ma Compétition';
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Tapis> get tapisList => _tapisList;
  List<Person> get persons => _persons;
  String get competitionName => _competitionName;

  CompetitionProvider() {
    refreshData();
  }

  Future<void> refreshData() async {
    _tapisList = await _dbHelper.getTapisList();
    _persons = await _dbHelper.getPersons();
    _competitionName = await _dbHelper.getCompetitionName();
    notifyListeners();
  }

  Future<void> updateCompetitionName(String name) async {
    await _dbHelper.updateCompetitionName(name);
    await refreshData();
  }

  Future<void> addTapis(String name) async {
    await _dbHelper.insertTapis(Tapis(name: name));
    await refreshData();
  }

  Future<void> removeTapis(int id) async {
    await _dbHelper.deleteTapis(id);
    await refreshData();
  }

  Future<void> addPerson(Person person) async {
    await _dbHelper.insertPerson(person);
    await refreshData();
  }

  Future<void> removePerson(int id) async {
    await _dbHelper.deletePerson(id);
    await refreshData();
  }

  Future<void> movePerson(int personId, int? newTapisId, bool isLead) async {
    final person = _persons.firstWhere((p) => p.id == personId);
    
    // If setting as lead, we might want to unset others of same type on same tapis
    if (isLead) {
      for (var p in _persons.where((p) =>
          p.tapisId == newTapisId &&
          p.type == person.type &&
          p.isLead)) {
        await _dbHelper.updatePerson(p.copyWith(isLead: false));
      }
    }
    
    await _dbHelper.updatePerson(person.copyWith(tapisId: newTapisId, isLead: isLead));
    await refreshData();
  }

  Future<void> toggleLead(Person person) async {
    if (!person.isLead) {
      for (var p in _persons.where((p) =>
          p.tapisId == person.tapisId &&
          p.type == person.type &&
          p.isLead)) {
        await _dbHelper.updatePerson(p.copyWith(isLead: false));
      }
    }
    await _dbHelper.updatePerson(person.copyWith(isLead: !person.isLead));
    await refreshData();
  }

  Future<void> clearCompetition() async {
    await _dbHelper.clearAll();
    await refreshData();
  }

  List<Person> getGlobalReferees() => _persons
      .where((p) => p.tapisId == null && p.type == PersonType.referee)
      .toList();
  List<Person> getGlobalCommissioners() => _persons
      .where((p) => p.tapisId == null && p.type == PersonType.commissioner)
      .toList();

  List<Person> getTapisPersons(int tapisId, PersonType type) => _persons
      .where((p) => p.tapisId == tapisId && p.type == type)
      .toList();
}
