import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models.dart';
import '../providers/competition_provider.dart';
import 'dialogs.dart';

class PersonSection extends StatelessWidget {
  final String title;
  final Color color;
  final List<Person> persons;
  final int tapisId;
  final PersonType type;

  const PersonSection({
    super.key,
    required this.title,
    required this.color,
    required this.persons,
    required this.tapisId,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CompetitionProvider>(context, listen: false);
    final lead = persons.cast<Person?>().firstWhere((p) => p!.isLead, orElse: () => null);
    final regulars = persons.where((p) => !p.isLead).toList();

    return DragTarget<Person>(
      onWillAcceptWithDetails: (details) => details.data.type == type,
      onAcceptWithDetails: (details) {
        provider.movePerson(details.data.id!, tapisId, false);
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(
              color: candidateData.isNotEmpty ? color.withValues(alpha: 0.5) : color,
              width: candidateData.isNotEmpty ? 3 : 1,
            ),
            borderRadius: BorderRadius.circular(8),
            color: candidateData.isNotEmpty ? color.withValues(alpha: 0.05) : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: TextStyle(fontWeight: FontWeight.bold, color: color)),
                  IconButton(
                    icon: const Icon(Icons.person_add, size: 18),
                    onPressed: () =>
                        showAddPersonDialog(context, provider, tapisId, type, false),
                  ),
                ],
              ),
              // Lead box
              DragTarget<Person>(
                onWillAcceptWithDetails: (details) => details.data.type == type,
                onAcceptWithDetails: (details) {
                  provider.movePerson(details.data.id!, tapisId, true);
                },
                builder: (context, leadCandidate, _) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    margin: const EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(
                      color: leadCandidate.isNotEmpty
                          ? color.withValues(alpha: 0.4)
                          : color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: leadCandidate.isNotEmpty ? color : color.withValues(alpha: 0.5),
                        width: leadCandidate.isNotEmpty ? 2 : 1,
                      ),
                    ),
                    child: lead != null
                        ? Draggable<Person>(
                            data: lead,
                            feedback: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(4),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                color: color.withValues(alpha: 0.8),
                                child: Text(lead.name,
                                    style: const TextStyle(color: Colors.white)),
                              ),
                            ),
                            childWhenDragging: Opacity(
                              opacity: 0.3,
                              child: Row(
                                children: [
                                  const Text('Resp: ',
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                  Expanded(child: Text(lead.name)),
                                ],
                              ),
                            ),
                            child: Row(
                              children: [
                                const Text('Resp: ',
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                Expanded(child: Text(lead.name)),
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline, size: 14),
                                  onPressed: () => provider.removePerson(lead.id!),
                                )
                              ],
                            ),
                          )
                        : InkWell(
                            onTap: () =>
                                showAddPersonDialog(context, provider, tapisId, type, true),
                            child: const Center(
                              child: Text('Définir responsable',
                                  style: TextStyle(
                                      fontSize: 12, fontStyle: FontStyle.italic)),
                            ),
                          ),
                  );
                },
              ),
              // Regulars list
              ...regulars.map((p) => Draggable<Person>(
                    data: p,
                    feedback: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: color.withValues(alpha: 0.8),
                        child: Text(p.name, style: const TextStyle(color: Colors.white)),
                      ),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('- ${p.name}', style: const TextStyle(fontSize: 13)),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text('- ${p.name}',
                                  style: const TextStyle(fontSize: 13))),
                          IconButton(
                            icon: const Icon(Icons.delete, size: 14),
                            onPressed: () => provider.removePerson(p.id!),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}
