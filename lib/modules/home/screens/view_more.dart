import 'package:flutter/material.dart';
import '../../../utils/ui/scaffold.dart';

class ViewMore extends StatefulWidget {
  const ViewMore({
    super.key,
    required this.itemCount,
    required this.crossAxisCount,
    required this.itemBuilder,
  });

  final int itemCount;
  final int crossAxisCount;
  final Widget Function(int) itemBuilder;

  @override
  State<ViewMore> createState() => _ViewMoreState();
}

class _ViewMoreState extends State<ViewMore> {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      body: Column(
        children: [
          widget.itemCount == 0
              ? const Text('Empty')
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.crossAxisCount,
                  ),
                  itemBuilder: (_, index) {
                    return widget.itemBuilder(index);
                  },
                ),
        ],
      ),
    );
  }
}
