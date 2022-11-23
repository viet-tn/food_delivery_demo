import 'package:flutter/material.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../search/widgets/filter_button.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
    this.onFilterPressed,
    this.enable = true,
    this.searchController,
  });

  final VoidCallback? onFilterPressed;
  final bool enable;
  final TextEditingController? searchController;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !enable,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                color: FColors.pastelOrange,
                borderRadius: Ui.borderRadius,
              ),
              child: TextField(
                autofocus: true,
                controller: searchController,
                enabled: enable,
                enableInteractiveSelection: false,
                maxLines: 1,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(18.0),
                  hintText: 'What do you want to order?',
                  hintStyle: FTextStyles.label
                      .copyWith(color: FColors.metallicOrangeO5),
                  prefixIcon: const Icon(
                    Icons.search_outlined,
                    color: FColors.metallicOrange,
                  ),
                ),
              ),
            ),
          ),
          gapW12,
          FilterButton(
            onFilterPressed: onFilterPressed,
          )
        ],
      ),
    );
  }
}
