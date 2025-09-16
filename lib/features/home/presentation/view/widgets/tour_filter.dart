import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:on_the_go/features/discover/presentation/views/discover_places_view.dart';
import 'package:on_the_go/features/home/presentation/manager/get_categories/get_categories_cubit.dart';

class FilterSection extends StatefulWidget {
  const FilterSection({super.key});

  @override
  _FilterSectionState createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  String? selectedGovernment;
  String? selectedType;

  @override
  void initState() {
    super.initState();
    context.read<GetCategoryCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile = screenWidth < 600;
        final isTablet = screenWidth < 1000;

        double containerWidth;
        if (isMobile) {
          containerWidth = screenWidth - 32;
        } else if (isTablet) {
          containerWidth = screenWidth * 0.85;
        } else {
          containerWidth = screenWidth * 0.5;
        }

        return Container(
          constraints: BoxConstraints(
            maxWidth: containerWidth,
            minHeight: isMobile ? 160 : 90, // Increased height for mobile
          ),
          width: containerWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(isMobile ? 20 : 33),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                blurRadius: 15,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: EdgeInsets.all(isMobile ? 16 : 12),
          child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
        );
      },
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        // First row: Where to button (full width)
        SizedBox(
          height: 80,
          width: double.infinity,
          child: WhereToButton(
            selectedGovernment: selectedGovernment,
            onGovernmentSelected: (government) {
              setState(() {
                selectedGovernment = government;
              });
            },
          ),
        ),

        const SizedBox(height: 12),

        // Second row: Type button (full width)
        SizedBox(
          height: 80,
          width: double.infinity,
          child: TypeButton(
            selectedType: selectedType,
            onTypeSelected: (type) {
              setState(() {
                selectedType = type;
              });
            },
          ),
        ),

        const SizedBox(height: 16),

        // Third row: Search button (centered)
        Center(
          child: SearchButton(
            governmentName: selectedGovernment,
            type: selectedType,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: WhereToButton(
            selectedGovernment: selectedGovernment,
            onGovernmentSelected: (government) {
              setState(() {
                selectedGovernment = government;
              });
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 1,
          child: TypeButton(
            selectedType: selectedType,
            onTypeSelected: (type) {
              setState(() {
                selectedType = type;
              });
            },
          ),
        ),
        const SizedBox(width: 16),
        SearchButton(governmentName: selectedGovernment, type: selectedType),
      ],
    );
  }
}

class TypeButton extends StatelessWidget {
  final String? selectedType;
  final Function(String) onTypeSelected;

  const TypeButton({
    super.key,
    required this.onTypeSelected,
    this.selectedType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCategoryCubit, GetCategoryState>(
      builder: (context, state) {
        List<Map<String, dynamic>> categories = [];
        if (state is GetCategorySuccess) {
          categories =
              state.categories
                  .map(
                    (category) => {
                      'name': category.name,
                      'icon': _getCategoryIcon(category.name),
                    },
                  )
                  .toList();
        } else if (state is GetCategoryLoading) {
          return FilterButton(
            icon: Icons.category_rounded,
            label: 'Type',
            hint: 'Loading types...',
            onTap: () {},
          );
        } else if (state is GetCategoryError) {
          return FilterButton(
            icon: Icons.error,
            label: 'Type',
            hint: 'Error loading types',
            onTap: () {
              context.read<GetCategoryCubit>().getCategories();
            },
          );
        }

        return FilterButton(
          icon: Icons.category_rounded,
          label: 'Type',
          hint: selectedType ?? 'Select type',
          onTap: () {
            _showTypeMenu(context, categories);
          },
        );
      },
    );
  }

  void _showTypeMenu(
    BuildContext context,
    List<Map<String, dynamic>> categories,
  ) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    if (isMobile) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        backgroundColor: Colors.white,
        isScrollControlled: true,
        builder:
            (context) => _CustomMenu(
              items: categories,
              selectedItem: selectedType,
              onItemSelected: onTypeSelected,
              title: 'Select Tour Type',
            ),
      );
    } else {
      showDialog(
        context: context,
        builder:
            (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.white,
              child: _CustomMenu(
                items: categories,
                selectedItem: selectedType,
                onItemSelected: onTypeSelected,
                title: 'Select Tour Type',
              ),
            ),
      );
    }
  }

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName) {
      case 'Red Sea Tours':
        return Icons.water_rounded;
      case 'Historical Tours':
        return Icons.history_edu_rounded;
      case 'Family & fun Tours':
        return Icons.family_restroom_rounded;
      case 'Sharm Desert Tours':
        return Icons.terrain_rounded;
      default:
        return Icons.category_rounded;
    }
  }
}

class WhereToButton extends StatelessWidget {
  final String? selectedGovernment;
  final Function(String) onGovernmentSelected;

  const WhereToButton({
    super.key,
    required this.onGovernmentSelected,
    this.selectedGovernment,
  });

  @override
  Widget build(BuildContext context) {
    return FilterButton(
      icon: Icons.location_on_rounded,
      label: 'Where to?',
      hint: selectedGovernment ?? 'Explore destinations',
      onTap: () {
        _showGovernmentMenu(context);
      },
    );
  }

  void _showGovernmentMenu(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final governments = [
      {'name': 'Sharm El Sheikh Tours', 'icon': Icons.beach_access_rounded},
      {'name': 'Cairo Tours', 'icon': Icons.account_balance_rounded},
      {'name': 'Luxor Tours', 'icon': Icons.apartment_rounded},
    ];

    if (isMobile) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        backgroundColor: Colors.white,
        isScrollControlled: true,
        builder:
            (context) => _CustomMenu(
              items: governments,
              selectedItem: selectedGovernment,
              onItemSelected: onGovernmentSelected,
              title: 'Select Destination',
            ),
      );
    } else {
      showDialog(
        context: context,
        builder:
            (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.white,
              child: _CustomMenu(
                items: governments,
                selectedItem: selectedGovernment,
                onItemSelected: onGovernmentSelected,
                title: 'Select Destination',
              ),
            ),
      );
    }
  }
}

class _CustomMenu extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final String? selectedItem;
  final Function(String) onItemSelected;
  final String title;

  const _CustomMenu({
    required this.items,
    required this.selectedItem,
    required this.onItemSelected,
    required this.title,
  });

  @override
  _CustomMenuState createState() => _CustomMenuState();
}

class _CustomMenuState extends State<_CustomMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      constraints: BoxConstraints(
        maxHeight: isMobile ? MediaQuery.of(context).size.height * 0.5 : 300,
        maxWidth: isMobile ? double.infinity : 400,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),
          Flexible(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: widget.items.length,
                  separatorBuilder:
                      (context, index) =>
                          Divider(color: Colors.grey[200], height: 1),
                  itemBuilder: (context, index) {
                    final item = widget.items[index];
                    return _MenuItem(
                      name: item['name'],
                      icon: item['icon'],
                      isSelected: item['name'] == widget.selectedItem,
                      onTap: () {
                        widget.onItemSelected(item['name']);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatefulWidget {
  final String name;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _MenuItem({
    required this.name,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<_MenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color:
                _isHovered || widget.isSelected
                    ? Colors.orange.withOpacity(0.1)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 20,
                color: widget.isSelected ? Colors.orange : Colors.blue.shade600,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: widget.isSelected ? Colors.orange : Colors.black87,
                  ),
                ),
              ),
              if (widget.isSelected)
                const Icon(Icons.check_circle, size: 20, color: Colors.orange),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchButton extends StatelessWidget {
  final String? governmentName;
  final String? type;

  const SearchButton({super.key, this.governmentName, this.type});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: isMobile ? 200 : null, // Fixed width for mobile
      child: ElevatedButton(
        onPressed: () {
          if (governmentName == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please select a destination'),
                backgroundColor: Colors.orange,
              ),
            );
            return;
          }
          final base = '${DiscoverPlacesView.routeName}/$governmentName';
          final path = type != null ? '$base?type=$type' : base;
          context.go(path);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          elevation: 8,
          shadowColor: Colors.orange.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isMobile ? 25 : 20),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 20,
            vertical: isMobile ? 16 : 14,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_rounded,
              color: Colors.white,
              size: isMobile ? 20 : 24,
            ),
            if (isMobile) ...[
              const SizedBox(width: 8),
              Text(
                'Search',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

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
            duration: const Duration(milliseconds: 300),
            width: double.infinity, // Full width for mobile
            height: isMobile ? 60 : null, // Fixed height for mobile
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:
                    _isHovered
                        ? [
                          Colors.orange.withOpacity(0.1),
                          Colors.orange.withOpacity(0.2),
                        ]
                        : [Colors.white, Colors.grey[50]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isHovered ? Colors.orange.shade300 : Colors.grey[300]!,
                width: 1.5,
              ),
              boxShadow:
                  _isHovered
                      ? [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                      : [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.08),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 12,
              vertical: isMobile ? 12 : 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  widget.icon,
                  color:
                      _isHovered
                          ? Colors.orange.shade700
                          : Colors.blue.shade600,
                  size: isMobile ? 24 : 20,
                ),
                SizedBox(width: isMobile ? 16 : 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.label,
                        style: TextStyle(
                          color:
                              _isHovered
                                  ? Colors.orange.shade700
                                  : Colors.blue.shade600,
                          fontSize: isMobile ? 16 : 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.hint,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: isMobile ? 14 : 12,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                if (isMobile)
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color:
                        _isHovered ? Colors.orange.shade700 : Colors.grey[500],
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
