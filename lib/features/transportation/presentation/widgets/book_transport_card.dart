import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_the_go/features/transportation/data/models/transportation_model.dart';
import 'package:on_the_go/features/transportation/presentation/manager/transportation_booking_cubit/transportation_booking_cubit.dart';
import 'package:on_the_go/features/transportation/presentation/widgets/transportation_booking_form.dart';

class TransportationBookingCard extends StatefulWidget {
  final TransportationModel transportationModel;
  final double width;

  const TransportationBookingCard({
    super.key,
    required this.transportationModel,
    required this.width,
  });

  @override
  State<TransportationBookingCard> createState() =>
      _TransportationBookingCardState();
}

class _TransportationBookingCardState extends State<TransportationBookingCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double fontSize =
        widget.width < 400
            ? 12
            : widget.width < 600
            ? 14
            : 16;
    final double titleFontSize =
        widget.width < 400
            ? 18
            : widget.width < 600
            ? 20
            : 22;
    final double priceFontSize =
        widget.width < 400
            ? 16
            : widget.width < 600
            ? 18
            : 20;
    final double padding = widget.width < 400 ? 16 : 20;
    final double cardHeight =
        widget.width < 400
            ? 320
            : widget.width < 600
            ? 360
            : 400;

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _animationController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              height: cardHeight,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(_isHovered ? 0.15 : 0.08),
                    spreadRadius: _isHovered ? 3 : 0,
                    blurRadius: _isHovered ? 20 : 15,
                    offset: Offset(0, _isHovered ? 8 : 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Material(
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      // Background Image with Professional Overlay
                      Positioned.fill(child: _buildImageBackground()),

                      // Professional Gradient Overlay
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.1),
                                Colors.black.withOpacity(0.3),
                                Colors.black.withOpacity(0.8),
                              ],
                              stops: const [0.0, 0.5, 1.0],
                            ),
                          ),
                        ),
                      ),

                      // Content Layer
                      Positioned.fill(
                        child: Padding(
                          padding: EdgeInsets.all(padding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header Section
                              _buildHeaderSection(titleFontSize, fontSize),

                              const Spacer(),

                              // Price Section
                              _buildPriceSection(
                                priceFontSize,
                                fontSize,
                                padding,
                              ),

                              SizedBox(height: padding * 0.8),

                              // CTA Button
                              _buildBookingButton(fontSize, padding),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageBackground() {
    return Image.network(
      widget.transportationModel.image,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFF8F9FA), Color(0xFFE9ECEF)],
            ),
          ),
          child: Center(
            child: CircularProgressIndicator(
              value:
                  loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
              color: const Color(0xFF2C3E50),
              strokeWidth: 2,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF34495E), Color(0xFF2C3E50)],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.directions_bus_outlined,
                  size: 60,
                  color: Colors.white.withOpacity(0.8),
                ),
                const SizedBox(height: 12),
                Text(
                  'Transportation Service',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderSection(double titleFontSize, double fontSize) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3498DB), Color(0xFF2980B9)],
              ),
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.transportationModel.typeBus,
              style: TextStyle(
                color: const Color(0xFF2C3E50),
                fontSize: titleFontSize,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Icon(
            Icons.star_rounded,
            color: const Color(0xFFE67E22),
            size: fontSize + 4,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSection(
    double priceFontSize,
    double fontSize,
    double padding,
  ) {
    return Container(
      padding: EdgeInsets.all(padding * 0.8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          // Adult Price
          _buildPriceRow(
            'Adult Ticket',
            widget.transportationModel.price,
            const Color(0xFF27AE60),
            priceFontSize,
            fontSize,
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: padding * 0.3),
            child: Divider(color: Colors.grey.withOpacity(0.3), height: 1),
          ),

          // Child Price
          _buildPriceRow(
            'Child Ticket',
            widget.transportationModel.childPrice,
            const Color(0xFFE67E22),
            priceFontSize,
            fontSize,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    String label,
    double price,
    Color color,
    double priceFontSize,
    double fontSize,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF2C3E50),
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
        ),
        Row(
          children: [
            Text(
              '£',
              style: TextStyle(
                color: color,
                fontSize: priceFontSize * 0.8,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              price.toStringAsFixed(2),
              style: TextStyle(
                color: color,
                fontSize: priceFontSize,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBookingButton(double fontSize, double padding) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          final cubit = context.read<TransportationBookingCubit>();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => BlocProvider.value(
                    value: cubit,
                    child: TransportBookingForm(
                      transportationModel: widget.transportationModel,
                    ),
                  ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2C3E50),
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ).copyWith(
          overlayColor: WidgetStateProperty.all(Colors.white.withOpacity(0.1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Book Now',
              style: TextStyle(
                fontSize: fontSize + 2,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward_rounded, size: fontSize + 4),
          ],
        ),
      ),
    );
  }
}
