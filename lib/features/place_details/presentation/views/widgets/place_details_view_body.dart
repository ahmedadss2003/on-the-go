import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:intl/intl.dart';
import 'package:on_the_go/core/models/tour_model.dart';
import 'package:on_the_go/core/widgets/youtube_section.dart';
import 'package:on_the_go/features/discover/presentation/manager/booking_cubit/booking_cubit.dart';
import 'package:on_the_go/features/discover/presentation/views/widgets/discover_places_gridview.dart';

class PlaceDetailsViewBody extends StatefulWidget {
  const PlaceDetailsViewBody({super.key, required this.tourModel});
  final TourModel tourModel;

  @override
  PlaceDetailsViewBodyState createState() => PlaceDetailsViewBodyState();
}

List<String> included = [
  "Return fly tickets",
  "All transfers by A/C vehicle in Sharm el Sheikh and Cairo",
  "Giza Pyramids, Sphinx and Kephren Temple",
  "English speaking tour guide",
  "Lunch in Cairo",
  "Egyptian Museum",
];

List<String> notIncluded = [
  "Drinks on the Restaurant",
  "Boat ride on the Nile",
  "Any extras not mentioned in the program",
  "Entrance Fees",
];

class PlaceDetailsViewBodyState extends State<PlaceDetailsViewBody>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _controllers = {
    'name': TextEditingController(),
    'email': TextEditingController(),
    'phone': TextEditingController(),
  };

  DateTime? selectedDate;
  int adults = 1, children = 0;
  bool _isBookingInProgress = false;
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late ScrollController _scrollController;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    );
    _scrollController = ScrollController();
    _animController.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0.0,
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void didUpdateWidget(PlaceDetailsViewBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tourModel != widget.tourModel) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    _animController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _submitBooking() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedDate == null) {
      _showMessage('Please select a departure date', isError: true);
      return;
    }

    setState(() => _isBookingInProgress = true);

    final discountAmount =
        widget.tourModel.priceAdult * (widget.tourModel.discount / 100);
    final price = (widget.tourModel.priceAdult - discountAmount).round();
    final totalPrice =
        (adults * price + children * widget.tourModel.priceChild).toDouble();

    final bookingData = {
      'full_name': _controllers['name']!.text.trim(),
      'email': _controllers['email']!.text.trim(),
      'phone_number': _controllers['phone']!.text.trim(),
      'num_adults': adults,
      'num_children': children,
      'departure_date': selectedDate!.toIso8601String().split('T')[0],
      'tour_name': widget.tourModel.title,
      'total_price': totalPrice,
      'is_read': false,
    };
    context.read<BookingCubit>().bookTour(bookingData);
  }

  void _showMessage(String message, {bool isError = false}) {
    if (isError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red[600]),
      );
    } else {
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        title: "Success",
        desc: message,
        dialogType: DialogType.success,
        btnOkOnPress: () {},
      ).show();
    }
  }

  void _resetForm() {
    _controllers.values.forEach((controller) => controller.clear());
    setState(() {
      selectedDate = null;
      adults = 1;
      children = 0;
    });
  }

  void _showImageGallery() {
    int currentPage = _currentImageIndex;
    final pageController = PageController(initialPage: currentPage);
    final images = widget.tourModel.images.map((e) => e.url).toList();

    // Handle empty image list
    if (images.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('No images available')));
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        double dialogWidth;
        if (screenWidth < 600) {
          dialogWidth = screenWidth;
        } else if (screenWidth < 900) {
          dialogWidth = screenWidth * 0.5;
        } else {
          dialogWidth = screenWidth * 0.4;
        }

        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: Center(
            child: Container(
              width: dialogWidth,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: StatefulBuilder(
                builder:
                    (context, setState) => Stack(
                      children: [
                        // Image PageView
                        PageView.builder(
                          controller: pageController,
                          itemCount: images.length,
                          onPageChanged:
                              (index) => setState(() => currentPage = index),
                          itemBuilder:
                              (context, index) => Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        images[index],
                                        fit:
                                            BoxFit
                                                .cover, // Center and fit image
                                        width: double.infinity,
                                        height: double.infinity,
                                        loadingBuilder: (
                                          context,
                                          child,
                                          loadingProgress,
                                        ) {
                                          if (loadingProgress == null)
                                            return child;
                                          return const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.amber,
                                            ),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Center(
                                                  child: Icon(
                                                    Icons.error,
                                                    color: Colors.red,
                                                    size: 40,
                                                  ),
                                                ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        ),
                        // Page Indicators
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              images.length,
                              (i) => Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                width: currentPage == i ? 10 : 6,
                                height: currentPage == i ? 10 : 6,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      currentPage == i
                                          ? Colors.amber
                                          : Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Close Button
                        Positioned(
                          top: 10,
                          right: 10,
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 24,
                              semanticLabel: 'Close gallery',
                            ),
                            onPressed: () => Navigator.pop(context),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black54,
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(8),
                            ),
                          ),
                        ),
                        // Navigation Arrows
                        if (currentPage > 0)
                          Positioned(
                            left: 10,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: IconButton(
                                onPressed:
                                    () => pageController.previousPage(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                    ),
                                icon: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                  size: 20,
                                  semanticLabel: 'Previous image',
                                ),
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.teal.withOpacity(0.7),
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(8),
                                ),
                              ),
                            ),
                          ),
                        if (currentPage < images.length - 1)
                          Positioned(
                            right: 10,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: IconButton(
                                onPressed:
                                    () => pageController.nextPage(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                    ),
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 20,
                                  semanticLabel: 'Next image',
                                ),
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.teal.withOpacity(0.7),
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(8),
                                ),
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
    );
  }

  String extractYoutubeVideoId(String url) {
    Uri uri = Uri.parse(url);
    return uri.queryParameters['v'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<BookingCubit, BookingState>(
        listener: (context, state) {
          setState(() {
            _isBookingInProgress = false;
          });

          if (state is BookingSuccess) {
            _showMessage('Booking successful! We\'ll contact you soon.');
            _resetForm();
          } else if (state is BookingFailure) {
            _showMessage('Booking failed: ${state.error}', isError: true);
          }
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  _buildHeroSection(),
                  _buildMainContent(),
                  const SizedBox(height: 20),
                  const AutoSizeText(
                    "Explore Similar Tours",
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    child: CustomDiscoverPlacesByCategoryGridView(
                      currentTour: widget.tourModel,
                      governMentName: widget.tourModel.governorate,
                    ),
                  ),
                ],
              ),
            ),
            if (_isBookingInProgress)
              Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.teal),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    final images = widget.tourModel.images.map((e) => e.url).toList();
    return SizedBox(
      height: 450,
      child: Stack(
        children: [
          GestureDetector(
            onTap: _showImageGallery,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    images.isNotEmpty ? images[_currentImageIndex] : '',
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  ),
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  Text(
                    widget.tourModel.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildHeroStat(
                        widget.tourModel.rating.toString(),
                        'Rating',
                        Icons.star_border,
                        Colors.amber,
                      ),
                      const SizedBox(width: 20),
                      _buildHeroStat(
                        widget.tourModel.timeOfTour,
                        'Duration',
                        Icons.timer,
                        Colors.teal,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroStat(
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                label,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 900;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child:
              isDesktop
                  ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: _buildTourDetails()),
                      const SizedBox(width: 30),
                      Expanded(flex: 2, child: _buildBookingForm()),
                    ],
                  )
                  : Column(
                    children: [
                      _buildTourDetails(),
                      const SizedBox(height: 30),
                      _buildBookingForm(),
                    ],
                  ),
        );
      },
    );
  }

  Widget _buildTourDetails() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTourHeader(),
                const SizedBox(height: 20),
                _buildDescription(),
                const SizedBox(height: 20),
                _buildTourInfo(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildIncludedSection(),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 600;
                  final isTablet = constraints.maxWidth < 900;
                  final videoHeight =
                      isMobile
                          ? 220.0
                          : isTablet
                          ? 320.0
                          : 420.0;

                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: videoHeight,
                      maxWidth: constraints.maxWidth,
                    ),
                    child:
                        widget.tourModel.youtubeVideoUrl != null
                            ? YoutubeVideoWidget(
                              videoId: extractYoutubeVideoId(
                                widget.tourModel.youtubeVideoUrl!,
                              ),
                            )
                            : const SizedBox(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTourHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.tourModel.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.teal[50],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.teal[100]!),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                Icons.access_time,
                widget.tourModel.timeOfTour,
                'Duration',
                Colors.teal,
              ),
              _buildStatItem(
                Icons.calendar_month,
                widget.tourModel.availability,
                'Available',
                Colors.teal,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 14,
          ),
        ),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }

  Widget _buildDescription() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.teal[100]!),
      ),
      child: ExpandedTile(
        title: const Text(
          'About This Tour',
          style: TextStyle(
            color: Colors.teal,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          widget.tourModel.description,
          style: TextStyle(fontSize: 16, height: 1.6, color: Colors.grey[800]),
        ),
        controller: ExpandedTileController(),
        leading: const Icon(Icons.info_outline, size: 22, color: Colors.teal),
      ),
    );
  }

  Widget _buildTourInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          _buildInfoRow(
            'Departure Time',
            widget.tourModel.departureTime != null
                ? 'Around ${formatTimeOfDay(widget.tourModel.departureTime!)}'
                : 'N/A',
            Icons.schedule,
            Colors.teal,
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            'Return Time',
            widget.tourModel.returnTime != null
                ? 'Around ${formatTimeOfDay(widget.tourModel.returnTime!)}'
                : 'N/A',
            Icons.schedule_send,
            Colors.teal,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
              Text(
                value,
                style: TextStyle(color: Colors.grey[700], fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIncludedSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child:
              isMobile
                  ? Column(
                    children: [
                      _buildIncludedCard('Included', included, Colors.green),
                      const SizedBox(height: 12),
                      _buildIncludedCard(
                        'Not Included',
                        notIncluded,
                        Colors.red,
                      ),
                    ],
                  )
                  : Row(
                    children: [
                      Expanded(
                        child: _buildIncludedCard(
                          'Included',
                          included,
                          Colors.green,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildIncludedCard(
                          'Not Included',
                          notIncluded,
                          Colors.red,
                        ),
                      ),
                    ],
                  ),
        );
      },
    );
  }

  Widget _buildIncludedCard(
    String title,
    List<String> items,
    MaterialColor color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color[200]!, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: color[600],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...items.asMap().entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 12, right: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Transform.translate(
                    offset: const Offset(0, 4),
                    child: Icon(
                      title == 'Included' ? Icons.check_circle : Icons.cancel,
                      color: color[600],
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingForm() {
    final discountAmount =
        widget.tourModel.priceAdult * (widget.tourModel.discount / 100);
    final price = (widget.tourModel.priceAdult - discountAmount).round();
    final totalPrice =
        (adults * price + children * widget.tourModel.priceChild).toString();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.teal[100]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ..._buildFormFields(),
                  const SizedBox(height: 15),
                  _buildDateField(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.teal[100]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '£${price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'Per Person',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildNumberFields(),
                  const SizedBox(height: 15),
                  _buildTotalPrice(totalPrice),
                  const SizedBox(height: 15),
                  _buildBookButton(),
                  const SizedBox(height: 15),
                  _buildWhyChooseUs(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    final fields = [
      {
        'key': 'name',
        'hint': 'Enter your full name',
        'icon': Icons.person_outline,
        'label': 'Full Name',
      },
      {
        'key': 'email',
        'hint': 'Enter your email',
        'icon': Icons.email_outlined,
        'label': 'Email Address',
      },
      {
        'key': 'phone',
        'hint': 'Enter your phone number',
        'icon': Icons.phone_outlined,
        'label': 'WhatsApp Number',
      },
    ];

    return fields
        .map(
          (field) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  field['label'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _controllers[field['key']],
                  decoration: InputDecoration(
                    hintText: field['hint'] as String,
                    prefixIcon: Icon(
                      field['icon'] as IconData,
                      color: Colors.teal,
                      size: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                  ),
                  validator:
                      (value) =>
                          value?.trim().isEmpty == true
                              ? 'This field is required'
                              : null,
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Date',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              builder: (context, child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: Colors.teal,
                      onPrimary: Colors.white,
                      surface: Colors.white,
                      onSurface: Colors.black87,
                    ),
                    dialogBackgroundColor: Colors.white,
                  ),
                  child: child!,
                );
              },
            );
            if (picked != null) setState(() => selectedDate = picked);
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.teal[100]!),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.teal,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  selectedDate != null
                      ? DateFormat('dd MMM yyyy').format(selectedDate!)
                      : 'Select a date',
                  style: TextStyle(
                    color:
                        selectedDate != null
                            ? Colors.black87
                            : Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberFields() {
    return Row(
      children: [
        Expanded(
          child: _buildNumberField(
            'Adults',
            adults,
            (value) => setState(() => adults = value),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildNumberField(
            'Children',
            children,
            (value) => setState(() => children = value),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberField(String label, int value, Function(int) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.teal[100]!),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () => onChanged(value + 1),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: value > 0 ? () => onChanged(value - 1) : null,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: value > 0 ? Colors.red : Colors.grey[400],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTotalPrice(String totalPrice) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Price',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                '£$totalPrice',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Icon(Icons.monetization_on, color: Colors.white, size: 24),
        ],
      ),
    );
  }

  Widget _buildBookButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
        onPressed: _isBookingInProgress ? null : _submitBooking,
        child:
            _isBookingInProgress
                ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.flight_takeoff, color: Colors.white),
                    SizedBox(width: 8),
                    AutoSizeText(
                      'Book Now',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }

  Widget _buildWhyChooseUs() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why Book With Us?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.verified, color: Colors.green[600], size: 18),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Unbeatable Prices',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.support_agent, color: Colors.green[600], size: 18),
              const SizedBox(width: 8),
              const Expanded(
                child: Text('24/7 Support', style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    return DateFormat.jm().format(dateTime);
  }
}
