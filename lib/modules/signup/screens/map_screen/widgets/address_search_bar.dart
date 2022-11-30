import 'package:flutter/material.dart';

import '../../../../../constants/ui/colors.dart';
import '../../../../../constants/ui/ui_parameters.dart';
import '../../../../../repositories/maps/search/place_model.dart';
import '../../../../../widgets/textfield/text_field.dart';
import 'place_list_tile.dart';

class AddressSearchBar extends StatelessWidget {
  const AddressSearchBar({
    super.key,
    this.suggestions = const <FPlace>[],
    this.controller,
    this.onTitleTapped,
  });

  final List<FPlace> suggestions;
  final TextEditingController? controller;
  final Function(FPlace place)? onTitleTapped;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        FTextField(
          hintText: 'Enter your location ...',
          controller: controller,
          borderRadius: suggestions.isNotEmpty
              ? const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                )
              : Ui.borderRadius,
          prefixIcon: const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Icon(
              Icons.search,
              color: FColors.lightGreen,
            ),
          ),
        ),
        suggestions.isEmpty
            ? const SizedBox()
            : Container(
                constraints: BoxConstraints(
                  minHeight: 0.0,
                  maxHeight: height - height * .2,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                  color: Colors.white,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: Ui.borderRadius,
                  ),
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: suggestions
                          .map(
                            (place) => PlaceListTile(
                              place: place,
                              onTileTapped: onTitleTapped,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              )
      ],
    );
  }
}
