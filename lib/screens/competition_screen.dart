import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models.dart';
import '../providers/competition_provider.dart';
import '../widgets/global_lead_tile.dart';
import '../widgets/tapis_card.dart';
import '../widgets/dialogs.dart';

class CompetitionScreen extends StatelessWidget {
  const CompetitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CompetitionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () => showEditTitleDialog(context, provider),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(provider.competitionName),
              const SizedBox(width: 8),
              const Icon(Icons.edit, size: 18),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep, color: Colors.red),
            onPressed: () => confirmClear(context, provider),
            tooltip: 'Supprimer',
          ),
        ],
      ),
      body: Column(
        children: [
          // Global Leads
          _buildGlobalHeader(context, provider),
          const Divider(),
          // Mats List
          Expanded(
            child: provider.tapisList.isEmpty
                ? const Center(child: Text('Aucun tapis ajouté'))
                : LayoutBuilder(builder: (context, constraints) {
                    int crossAxisCount = 1;
                    if (constraints.maxWidth > 600) crossAxisCount = 2;
                    if (constraints.maxWidth > 1000) crossAxisCount = 3;

                    return GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: constraints.maxWidth > 1400
                            ? 5
                            : constraints.maxWidth > 1100
                                ? 4
                                : constraints.maxWidth > 800
                                    ? 3
                                    : constraints.maxWidth > 500
                                        ? 2
                                        : 1,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: provider.tapisList.length,
                      itemBuilder: (context, index) {
                        return TapisCard(tapis: provider.tapisList[index]);
                      },
                    );
                  }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showAddTapisDialog(context, provider),
        label: const Text('Ajouter Tapis'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildGlobalHeader(BuildContext context, CompetitionProvider provider) {
    final globalRefs = provider.getGlobalReferees();
    final globalComms = provider.getGlobalCommissioners();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: GlobalLeadTile(
              title: 'Resp. Arbitre',
              color: Colors.blue.shade100,
              textColor: Colors.blue.shade900,
              persons: globalRefs,
              type: PersonType.referee,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GlobalLeadTile(
              title: 'Resp. Commissaire',
              color: Colors.red.shade100,
              textColor: Colors.red.shade900,
              persons: globalComms,
              type: PersonType.commissioner,
            ),
          ),
        ],
      ),
    );
  }
}
