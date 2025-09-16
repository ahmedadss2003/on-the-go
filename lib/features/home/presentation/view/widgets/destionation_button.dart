import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_the_go/features/discover/presentation/views/discover_places_view.dart';

class HoverMenuDestinationButton extends StatefulWidget {
  const HoverMenuDestinationButton({super.key});

  @override
  HoverMenuDestinationButtonState createState() =>
      HoverMenuDestinationButtonState();
}

class HoverMenuDestinationButtonState extends State<HoverMenuDestinationButton>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isMenuOpen = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  // Check if we're on a touch device (mobile/tablet)
  bool get _isTouchDevice =>
      !kIsWeb ||
      (kIsWeb &&
          (defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.android));

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

    _controller.reverse().then((_) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isMenuOpen = false;
    });
  }

  void _toggleMenu(BuildContext context) {
    if (_isMenuOpen) {
      _hideMenu();
    } else {
      _showMenu(context);
    }
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    return OverlayEntry(
      builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: _isTouchDevice ? _hideMenu : null,
          child: Stack(
            children: [
              Positioned(
                width: 200,
                child: CompositedTransformFollower(
                  link: _layerLink,
                  offset: const Offset(-40, 40),
                  showWhenUnlinked: false,
                  child: GestureDetector(
                    onTap: () {}, // Prevent tap from bubbling up
                    child: MouseRegion(
                      onExit: _isTouchDevice ? null : (_) => _hideMenu(),
                      child: SlideTransition(
                        position: _offsetAnimation,
                        child: Material(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromRGBO(8, 64, 154, 0.8),
                          elevation: 4,
                          child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            children: [
                              _menuItem("Sharm El Sheikh Tours"),
                              _menuItem("Cairo Tours"),
                              _menuItem("Luxor Tours"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
        final base = '${DiscoverPlacesView.routeName}/$text';
        const type = null; // لو عندك type ضيفه هنا، لو مش موجود سيبها null

        final path = type != null ? '$base?type=$type' : base;

        context.go(path);
        _hideMenu();
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child:
          _isTouchDevice
              ? GestureDetector(
                onTap: () => _toggleMenu(context),
                child: _buildButtonContent(),
              )
              : MouseRegion(
                onEnter: (_) => _showMenu(context),
                child: GestureDetector(
                  onTap: () => _toggleMenu(context),
                  child: _buildButtonContent(),
                ),
              ),
    );
  }

  Widget _buildButtonContent() {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Destinations",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
          Icon(
            _isMenuOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _hideMenu();
    super.dispose();
  }
}
