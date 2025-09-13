import 'package:flutter/material.dart';
import 'package:on_the_go/features/discover/presentation/views/widgets/discover_places_view_body.dart';

class DiscoverPlacesView extends StatelessWidget {
  const DiscoverPlacesView({
    super.key,
    required this.governmentName,
    this.type,
  });
  static const routeName = "/discover_places";
  final String governmentName;
  final String? type;
  @override
  Widget build(BuildContext context) {
    return SelectableRegion(
      focusNode: FocusNode(),
      selectionControls: MaterialTextSelectionControls(),
      child: DiscoverPlacesViewBody(governMentName: governmentName, type: type),
    );
  }
}
