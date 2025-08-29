import 'package:flutter/material.dart';

// Main Filter Section Widget
class FilterSection extends StatelessWidget {
  const FilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final isTablet = constraints.maxWidth < 1000;
        double width = MediaQuery.of(context).size.width;
        return Container(
          width:
              isMobile
                  ? width
                  : isTablet
                  ? width * 0.9
                  : width * 0.5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          padding: EdgeInsets.all(10),
          child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
        );
      },
    );
  }

  Widget _buildMobileLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(child: WhereToButton()),
        const SizedBox(width: 8),
        const Expanded(child: TypeButton()),
        const SizedBox(width: 8),
        const SearchButton(),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(flex: 1, child: WhereToButton()),
        const SizedBox(width: 8),
        const Expanded(flex: 1, child: TypeButton()),
        const SizedBox(width: 16),
        const SearchButton(),
      ],
    );
  }
}

// Where To Button Widget
class WhereToButton extends StatelessWidget {
  const WhereToButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilterButton(
      icon: Icons.location_on_rounded,
      label: 'Where to?',
      hint: 'Explore destinations',
    );
  }
}

// Type Button Widget
class TypeButton extends StatelessWidget {
  const TypeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilterButton(
      icon: Icons.category_rounded,
      label: 'Type',
      hint: 'Select type',
      onTap: () {},
    );
  }
}

// Search Button Widget
class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        elevation: 8,
        shadowColor: Colors.orange.withOpacity(0.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.all(isMobile ? 8 : 12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_rounded,
            color: Colors.white,
            size: isMobile ? 20 : 24,
          ),
          if (!isMobile) ...[
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: const Text(
                'Search',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class FilterButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String hint;
  final VoidCallback? onTap;

  const FilterButton({
    super.key,
    required this.icon,
    required this.label,
    required this.hint,
    this.onTap,
  });

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return MouseRegion(
      onEnter:
          (_) => setState(() {
            _isHovered = true;
            _controller.forward();
          }),
      onExit:
          (_) => setState(() {
            _isHovered = false;
            _controller.reverse();
          }),
      child: GestureDetector(
        onTap: widget.onTap,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              gradient:
                  _isHovered
                      ? LinearGradient(
                        colors: [
                          Colors.orange.withOpacity(0.1),
                          Colors.orange.withOpacity(0.2),
                        ],
                      )
                      : LinearGradient(
                        colors: [Colors.white, Colors.grey[50]!],
                      ),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: _isHovered ? Colors.orange : Colors.grey[300]!,
                width: 1.5,
              ),
              boxShadow:
                  _isHovered
                      ? [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                      : [],
            ),
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.icon,
                  color: _isHovered ? Colors.orange : Colors.blue,
                  size: isMobile ? 18 : 22,
                ),
                const SizedBox(height: 6),
                Text(
                  widget.label,
                  style: TextStyle(
                    color: _isHovered ? Colors.orange : Colors.blue,
                    fontSize: isMobile ? 12 : 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.hint,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: isMobile ? 10 : 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
