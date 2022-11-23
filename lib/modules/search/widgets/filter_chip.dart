import 'package:flutter/material.dart';

import '../../../constants/ui/colors.dart';

class FFilterChip extends StatelessWidget {
  const FFilterChip({
    super.key,
    required this.label,
    this.selected = true,
    this.onSelected,
  });

  final Widget label;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      backgroundColor: FColors.pastelOrange.withOpacity(.1),
      selectedColor: FColors.metallicOrangeO5.withOpacity(.35),
      checkmarkColor: FColors.metallicOrange,
      label: label,
      onSelected: onSelected,
      selected: selected,
    );
  }
}
