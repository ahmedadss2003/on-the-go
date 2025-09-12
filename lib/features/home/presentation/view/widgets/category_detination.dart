import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_the_go/features/discover/presentation/views/discover_places_view.dart';

class HoverMenuCategoryDestinationButton extends StatefulWidget {
  const HoverMenuCategoryDestinationButton({super.key});

  @override
  HoverMenuCategoryDestinationButtonState createState() =>
      HoverMenuCategoryDestinationButtonState();
}

class HoverMenuCategoryDestinationButtonState
    extends State<HoverMenuCategoryDestinationButton>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isMenuOpen = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _showMenu(BuildContext context) {
    if (_isMenuOpen) return;

    _overlayEntry = _createOverlayEntry(context);
    Overlay.of(context).insert(_overlayEntry!);
    _isMenuOpen = true;
    _controller.forward(from: 0);
  }

  void _hideMenu() {
    if (!_isMenuOpen) return;

    _overlayEntry?.remove();
    _overlayEntry = null;
    _isMenuOpen = false;
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          width: 200,
          child: CompositedTransformFollower(
            link: _layerLink,
            offset: Offset(-40, 40),
            showWhenUnlinked: false,
            child: MouseRegion(
              onExit: (_) => _hideMenu(),
              child: SlideTransition(
                position: _offsetAnimation,
                child: Material(
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromRGBO(8, 64, 154, 0.8),
                  elevation: 4,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      _menuItem("Red Sea Tours"),
                      _menuItem("Hisorical Tours"),
                      _menuItem("Family & fun Tours"),
                      _menuItem("Sharm Desert Tours"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _menuItem(String text) {
    return InkWell(
      hoverColor: const Color.fromARGB(255, 3, 41, 106),
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        context.go(DiscoverPlacesView.routeName, extra: {'type': text});
        _hideMenu();
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: (_) => _showMenu(context),
        child: SizedBox(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Trips",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                  color: Colors.white,
                ),
              ),
              Icon(Icons.arrow_drop_down, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
