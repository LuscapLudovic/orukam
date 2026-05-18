import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models.dart';
import '../providers/competition_provider.dart';
import 'person_section.dart';

class TapisCard extends StatelessWidget {
  final Tapis tapis;

  const TapisCard({super.key, required this.tapis});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CompetitionProvider>(context);
    final refs = provider.getTapisPersons(tapis.id!, PersonType.referee);
    final comms = provider.getTapisPersons(tapis.id!, PersonType.commissioner);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.orange, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(tapis.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.grey, size: 20),
                  onPressed: () => provider.removeTapis(tapis.id!),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView(
                children: [
                  PersonSection(
                    title: 'Arbitres',
                    color: Colors.blue,
                    persons: refs,
                    tapisId: tapis.id!,
                    type: PersonType.referee,
                  ),
                  const SizedBox(height: 12),
                  PersonSection(
                    title: 'Commissaires',
                    color: Colors.red,
                    persons: comms,
                    tapisId: tapis.id!,
                    type: PersonType.commissioner,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
