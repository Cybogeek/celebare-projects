import 'package:celebrareeditor/provider/controlprovider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditorTopBar extends StatelessWidget {
  const EditorTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int id = context.watch<ControlProvider>().editingText;
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  context
                      .read<ControlProvider>()
                      .updateText(id, null, 50, 50, Colors.blue, null, 16);
                  //context.read<ControlProvider>().resetTextPos();
                  // Provider.of<ControlProvider>(context).resetTextPos();
                },
                icon: const Icon(Icons.undo_rounded),
                label: const Text('UNDO'),
              ),
              const SizedBox(
                width: 10,
              ),
              OutlinedButton.icon(
                onPressed: null,
                icon: const Icon(Icons.redo_rounded),
                label: const Text('REDO'),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 4,
                    bottom: 4,
                  ),
                  child: Text(
                    'Double click on the Text to Edit',
                    style: context.watch<ControlProvider>().fStyle.copyWith(
                          fontSize: 16,
                          color: context.watch<ControlProvider>().fColor,
                          overflow: TextOverflow.fade,
                        ),
                    softWrap: true,
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
