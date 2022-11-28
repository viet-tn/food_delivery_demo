import 'package:flutter/material.dart';

import '../../../../../constants/ui/sizes.dart';
import '../../../../../constants/ui/text_style.dart';
import '../../../../../repositories/maps/search/place_model.dart';

class PlaceListTile extends StatelessWidget {
  const PlaceListTile({
    super.key,
    required this.place,
    this.onTileTapped,
  });

  final FPlace place;
  final Function(FPlace place)? onTileTapped;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onTileTapped?.call(place);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: FTextStyles.heading5,
                    ),
                    gapH8,
                    Text(
                      place.address,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: FTextStyles.label,
                    ),
                  ],
                ),
              ),
              gapW8,
              const Icon(
                Icons.north_west,
              ),
              gapW8,
            ],
          ),
        ),
      ),
    );
  }
}
