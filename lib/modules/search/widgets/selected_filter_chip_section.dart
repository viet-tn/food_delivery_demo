import 'package:flutter/material.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/sizes.dart';
import '../../../widgets/chips/input_chip.dart';
import '../cubit/search_cubit.dart';

class SelectedFilterChipSection extends StatelessWidget {
  const SelectedFilterChipSection({
    super.key,
    required this.filter,
    this.onDeleteChip,
    this.onDeleteAllChip,
  });

  final List<SelectableItem> filter;
  final void Function(SelectableItem filter)? onDeleteChip;
  final void Function(Iterable<SelectableItem> items)? onDeleteAllChip;

  @override
  Widget build(BuildContext context) {
    final items = filter.where((item) => item.isSelected);
    return items.isEmpty
        ? const SizedBox()
        : Row(
            children: [
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      gapW16,
                      ...items.map(
                        (item) => FInputChip(
                          onDeleted: (_) => onDeleteChip?.call(item),
                          label: item.value,
                        ),
                      ),
                      gapW12,
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () => onDeleteAllChip?.call(items),
                icon: const Icon(
                  Icons.close_rounded,
                  color: FColors.metallicOrange,
                ),
              )
            ],
          );
  }
}
