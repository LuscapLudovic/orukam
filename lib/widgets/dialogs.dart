import 'package:flutter/material.dart';
import '../models.dart';
import '../providers/competition_provider.dart';

void showAddTapisDialog(BuildContext context, CompetitionProvider provider) {
  final controller = TextEditingController();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Nouveau Tapis'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: 'Nom du tapis (ex: Tapis 1)'),
        autofocus: true,
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler')),
        ElevatedButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              provider.addTapis(controller.text);
              Navigator.pop(context);
            }
          },
          child: const Text('Ajouter'),
        ),
      ],
    ),
  );
}

void confirmClear(BuildContext context, CompetitionProvider provider) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Supprimer ${provider.competitionName} ?'),
      content: const Text(
          'Cela effacera tous les tapis et tous les participants. Cette action est irréversible.'),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler')),
        TextButton(
          onPressed: () {
            provider.clearCompetition();
            Navigator.pop(context);
          },
          child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}

void showEditTitleDialog(BuildContext context, CompetitionProvider provider) {
  final controller = TextEditingController(text: provider.competitionName);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Nom de la compétition'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: 'Ex: Tournoi de Paris'),
        autofocus: true,
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler')),
        ElevatedButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              provider.updateCompetitionName(controller.text);
              Navigator.pop(context);
            }
          },
          child: const Text('Enregistrer'),
        ),
      ],
    ),
  );
}

void showAddPersonDialog(BuildContext context, CompetitionProvider provider,
    int? tapisId, PersonType type, bool isLead) {
  final controller = TextEditingController();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(isLead ? 'Ajouter Responsable' : 'Ajouter Membre'),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Nom',
          labelText: type == PersonType.referee ? 'Arbitre' : 'Commissaire',
        ),
        autofocus: true,
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler')),
        ElevatedButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              provider.addPerson(Person(
                name: controller.text,
                type: type,
                tapisId: tapisId,
                isLead: isLead,
              ));
              Navigator.pop(context);
            }
          },
          child: const Text('Ajouter'),
        ),
      ],
    ),
  );
}
