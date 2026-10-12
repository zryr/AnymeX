import 'package:anymex/utils/theme_extensions.dart';
import 'package:anymex/widgets/anymex_widgets/anymex_dialog.dart';
import 'package:anymex/widgets/anymex_widgets/anymex_text.dart';
import 'package:anymex/widgets/anymex_widgets/anymex_tile.dart';
import 'package:flutter/material.dart';

/// Returns the temporary "Don't ask again" choice only when Delete is pressed.
class RepositoryDeletionDialog extends StatefulWidget {
  final String repositoryName;

  const RepositoryDeletionDialog({super.key, required this.repositoryName});

  @override
  State<RepositoryDeletionDialog> createState() =>
      _RepositoryDeletionDialogState();
}

class _RepositoryDeletionDialogState extends State<RepositoryDeletionDialog> {
  bool _dontAskAgain = false;
  bool _confirmed = false;

  @override
  Widget build(BuildContext context) {
    return AnymeXDialog(
      title: 'Delete Repository?',
      confirmText: 'Delete',
      autoDismiss: false,
      onConfirm: () {
        if (_confirmed) return;
        _confirmed = true;
        Navigator.of(context).pop(_dontAskAgain);
      },
      contentWidget: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: AnymeXText(
              'Are you sure you want to delete "${widget.repositoryName}"? '
              'You will need to re-add its URL if you want to use it again.',
              size: 14,
              color: context.colors.onSurfaceVariant,
              textAlign: TextAlign.center,
              maxLines: 100,
            ),
          ),
          const SizedBox(height: 12),
          Semantics(
            checked: _dontAskAgain,
            child: AnymeXTile.checkbox(
              title: "Don't ask again",
              value: _dontAskAgain,
              onChanged: (value) => setState(() => _dontAskAgain = value),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }
}
