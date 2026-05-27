import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models.dart';
import '../providers/competition_provider.dart';
import 'dialogs.dart';

class GlobalLeadTile extends StatelessWidget {
  final String title;
  final Color color;
  final Color textColor;
  final List<Person> persons;
  final PersonType type;

  const GlobalLeadTile({
    super.key,
    required this.title,
    required this.color,
    required this.textColor,
    required this.persons,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CompetitionProvider>(context, listen: false);
    final lead = persons.cast<Person?>().firstWhere((p) => p!.isLead, orElse: () => null);

    return DragTarget<Person>(
      onWillAcceptWithDetails: (details) => details.data.type == type,
      onAcceptWithDetails: (details) {
        provider.movePerson(details.data.id!, null, true);
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: candidateData.isNotEmpty ? color.withValues(alpha: 0.5) : color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: candidateData.isNotEmpty ? textColor : textColor.withValues(alpha: 0.5),
              width: candidateData.isNotEmpty ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Text(title,
                  style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
              const SizedBox(height: 4),
              if (lead != null)
                Draggable<Person>(
                  data: lead,
                  feedback: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: color.withValues(alpha: 0.8),
                      child: Text(lead.name),
                    ),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.3,
                    child: Text(lead.name, textAlign: TextAlign.center),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Text(lead.name,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis)),
                      IconButton(
                        icon: const Icon(Icons.close, size: 16),
                        onPressed: () => provider.removePerson(lead.id!),
                      )
                    ],
                  ),
                )
              else
                TextButton.icon(
                  onPressed: () => showAddPersonDialog(context, provider, null, type, true),
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Définir'),
                ),
            ],
          ),
        );
      },
    );
  }
}
