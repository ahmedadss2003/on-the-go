import 'package:flutter/material.dart';

class FilterSection extends StatefulWidget {
  const FilterSection({super.key});

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection>
    with TickerProviderStateMixin {
  bool _showWherePopup = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.1),
                Colors.blue.withOpacity(0.3),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          padding: EdgeInsets.all(isMobile ? 12.0 : 16.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [isMobile ? _buildMobileLayout() : _buildDesktopLayout()],
          ),
        );
      },
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildWhereButton(true),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildFilterButton(
                Icons.calendar_month_rounded,
                'When?',
                'Select dates',
                true,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildFilterButton(
                Icons.access_time_rounded,
                'Duration?',
                'Trip length',
                true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildFilterButton(
                Icons.group_rounded,
                'Guests?',
                '2 Adults',
                true,
              ),
            ),
            const SizedBox(width: 8),
            _buildSearchButton(true),
          ],
        ),
        if (_showWherePopup) ...[const SizedBox(height: 12)],
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(child: _buildWhereButton(false)),
        Expanded(
          child: _buildFilterButton(
            Icons.calendar_month_rounded,
            'When?',
            'Select dates',
            false,
          ),
        ),
        Expanded(
          child: _buildFilterButton(
            Icons.access_time_rounded,
            'Duration?',
            'Trip length',
            false,
          ),
        ),
        Expanded(
          child: _buildFilterButton(
            Icons.group_rounded,
            'Guests?',
            '2 Adults',
            false,
          ),
        ),
        _buildSearchButton(false),
      ],
    );
  }

  Widget _buildWhereButton(bool isMobile) {
    return MouseRegion(
      child: GestureDetector(
        child: FilterButton(
          icon: Icons.location_on_rounded,
          label: 'Where to?',
          hint: 'Explore destinations',
          isMobile: isMobile,
        ),
      ),
    );
  }

  Widget _buildFilterButton(
    IconData icon,
    String label,
    String hint,
    bool isMobile,
  ) {
    return FilterButton(
      icon: icon,
      label: label,
      hint: hint,
      isMobile: isMobile,
    );
  }

  Widget _buildSearchButton(bool isMobile) {
    return Container(
      margin: EdgeInsets.only(left: isMobile ? 0 : 8),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          elevation: 8,
          shadowColor: Colors.orange.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(isMobile ? 8 : 9),
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
              const Text(
                'Search',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class FilterButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String hint;
  final bool isMobile;
  final bool isActive;

  const FilterButton({
    super.key,
    required this.icon,
    required this.label,
    required this.hint,
    required this.isMobile,
    this.isActive = false,
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
      end: 1.02,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isActive = widget.isActive || _isHovered;
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
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            gradient:
                isActive
                    ? LinearGradient(
                      colors: [
                        Colors.orange.withOpacity(0.1),
                        Colors.orange.withOpacity(0.2),
                      ],
                    )
                    : LinearGradient(colors: [Colors.white, Colors.grey[50]!]),
            borderRadius: BorderRadius.circular(70),
            border: Border.all(
              color: isActive ? Colors.orange : Colors.grey[300]!,
              width: 1.5,
            ),
            boxShadow:
                isActive
                    ? [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                    : [],
          ),
          padding: EdgeInsets.symmetric(
            horizontal: widget.isMobile ? 16 : 20,
            vertical: widget.isMobile ? 12 : 16,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: isActive ? Colors.orange : Colors.blue,
                size: widget.isMobile ? 20 : 22,
              ),
              const SizedBox(height: 6),
              Text(
                widget.label,
                style: TextStyle(
                  color: isActive ? Colors.orange : Colors.blue,
                  fontSize: widget.isMobile ? 12 : 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                widget.hint,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: widget.isMobile ? 10 : 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
