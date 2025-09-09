import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:intl/intl.dart';
import 'package:on_the_go/core/models/tour_model.dart';
import 'package:on_the_go/features/discover/presentation/views/widgets/discover_places_gridview.dart';
import 'package:on_the_go/features/place_details/presentation/views/widgets/youtube_section.dart';

class PlaceDetailsViewBody extends StatefulWidget {
  const PlaceDetailsViewBody({super.key, required this.tourModel});
  final TourModel tourModel;

  @override
  PlaceDetailsViewBodyState createState() => PlaceDetailsViewBodyState();
}

List<String> included = [
  "Included",
  "Return fly tickets",
  "All transfers by A/C vehicle in Sharm el Sheikh and Cairo",
  "Giza Pyramids, Sphinx and Kephren Temple",
  "English speaking tour guide",
  "Lunch in Cairo",
  "Egyptian Museum",
];

List<String> notIncluded = [
  "Not Included",
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
    'hotel': TextEditingController(),
  };

  DateTime? selectedDate;
  int adults = 1, children = 0;
  bool _isBookingInProgress = false;
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late ScrollController _scrollController; // Added ScrollController

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
    _scrollController = ScrollController(); // Initialize ScrollController
    _animController.forward();
  }

  @override
  void didUpdateWidget(PlaceDetailsViewBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if tourModel has changed
    if (oldWidget.tourModel != widget.tourModel) {
      // Scroll to top with animation when tourModel changes
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
    _scrollController.dispose(); // Dispose ScrollController
    super.dispose();
  }

  void _submitBooking() async {
    if (!_formKey.currentState!.validate() || selectedDate == null) {
      _showMessage('Please fill all fields and select a date', isError: true);
      return;
    }

    setState(() => _isBookingInProgress = true);

    // Simulate booking process
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isBookingInProgress = false);
    _showMessage('Booking confirmed! We\'ll contact you soon.');
    _resetForm();
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
    int currentPage = 0;
    final pageController = PageController();
    final images = widget.tourModel.images.map((e) => e.url).toList();

    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            child: StatefulBuilder(
              builder:
                  (context, setState) => SizedBox(
                    width: 600,
                    height: 400,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              PageView.builder(
                                controller: pageController,
                                itemCount: images.length,
                                onPageChanged:
                                    (index) =>
                                        setState(() => currentPage = index),
                                itemBuilder:
                                    (context, index) => Image.network(
                                      images[index],
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                                Icons.error,
                                                size: 50,
                                                color: Colors.red,
                                              ),
                                    ),
                              ),
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
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                      ),
                                      style: IconButton.styleFrom(
                                        backgroundColor: Colors.black54,
                                        shape: const CircleBorder(),
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
                                      ),
                                      style: IconButton.styleFrom(
                                        backgroundColor: Colors.black54,
                                        shape: const CircleBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              images.length,
                              (index) => Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                width: currentPage == index ? 12 : 8,
                                height: currentPage == index ? 12 : 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      currentPage == index
                                          ? Colors.blue
                                          : Colors.grey,
                                ),
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
  }

  String extractYoutubeVideoId(String url) {
    Uri uri = Uri.parse(url);
    return uri.queryParameters['v'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController, // Attach ScrollController
            child: Column(
              children: [
                _buildHeroSection(),
                _buildMainContent(),
                const SizedBox(height: 20),
                const AutoSizeText(
                  "Similar and Most Popular Tours",
                  maxLines: 1,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  child: CustomDiscoverPlacesByCategoryGridView(
                    governMentName: widget.tourModel.category,
                  ),
                ),
              ],
            ),
          ),
          if (_isBookingInProgress)
            Container(
              color: Colors.black54,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          GestureDetector(
            onTap: _showImageGallery,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    widget.tourModel.images.isNotEmpty
                        ? widget.tourModel.images[0].url
                        : '',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black26, Colors.black54],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            left: 20,
            right: 20,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildHeroStat(
                    widget.tourModel.rating.toString(),
                    'Rating',
                    Icons.star,
                  ),
                  _buildHeroStat(
                    widget.tourModel.timeOfTour,
                    'Duration',
                    Icons.access_time,
                  ),
                  _buildHeroStat(
                    widget.tourModel.numberOfPeople,
                    'Max Group',
                    Icons.group,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroStat(String value, String label, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.cyan[300], size: 16),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              label,
              style: TextStyle(color: Colors.grey[300], fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 900;

        return Container(
          padding: const EdgeInsets.all(30),
          child:
              isDesktop
                  ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: _buildTourDetails()),
                      const SizedBox(width: 40),
                      Expanded(flex: 1, child: _buildBookingForm()),
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
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 6),
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
            const SizedBox(height: 20),
            _buildIncludedSection(),
            const SizedBox(height: 20),
            // Add Video Section
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 600;
                    final isTablet = constraints.maxWidth < 900;
                    final videoHeight =
                        isMobile
                            ? 200.0
                            : isTablet
                            ? 300.0
                            : 400.0;

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
      ),
    );
  }

  Widget _buildTourHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.tourModel.title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blue[900],
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[50]!, Colors.cyan[50]!],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue[100]!),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                Icons.access_time,
                widget.tourModel.timeOfTour,
                'Duration',
              ),
              _buildStatItem(
                Icons.calendar_month,
                widget.tourModel.availability,
                'Available',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[600]!, Colors.cyan[500]!],
            ),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue[900],
            fontSize: 12,
          ),
        ),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 10)),
      ],
    );
  }

  Widget _buildDescription() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff1a73e8), width: 1.5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ExpandedTile(
        title: const Text(
          'Description',
          style: TextStyle(
            color: Color(0xFF1a73e8),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          widget.tourModel.description,
          style: TextStyle(fontSize: 18, height: 1.5, color: Colors.grey[800]),
        ),
        controller: ExpandedTileController(),
        leading: const Icon(
          Icons.description,
          size: 24,
          color: Color(0xFF1a73e8),
        ),
      ),
    );
  }

  Widget _buildTourInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.grey[50]!, Colors.blue[50]!]),
        borderRadius: BorderRadius.circular(12),
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
          ),
          const SizedBox(height: 15),
          _buildInfoRow(
            'Return Time',
            widget.tourModel.returnTime != null
                ? 'Around ${formatTimeOfDay(widget.tourModel.returnTime!)}'
                : 'N/A',
            Icons.schedule_send,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[600]!, Colors.cyan[500]!],
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                  fontSize: 12,
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

        return isMobile
            ? Column(
              children: [
                _buildIncludedCard(
                  'Included',
                  included,
                  Colors.green,
                  Icons.check_circle,
                ),
                const SizedBox(height: 15),
                _buildIncludedCard(
                  'Not Included',
                  notIncluded,
                  Colors.red,
                  Icons.cancel,
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
                    Icons.check_circle,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildIncludedCard(
                    'Not Included',
                    notIncluded,
                    Colors.red,
                    Icons.cancel,
                  ),
                ),
              ],
            );
      },
    );
  }

  Widget _buildIncludedCard(
    String title,
    List<String> items,
    MaterialColor color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color[200]!, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color[600], size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Icon(
                    title == 'Included' ? Icons.check : Icons.close,
                    color: color[600],
                    size: 14,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(color: color[700], fontSize: 12),
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
    final price = (widget.tourModel.priceAdult - widget.tourModel.discount);
    final totalPrice =
        (adults * price + children * widget.tourModel.priceChild).toString();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.white, Colors.blue[50]!]),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '£${price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Per Person',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orange[600]!, Colors.red[500]!],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.bookmark,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Book This Adventure',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ..._buildFormFields(),
            _buildDateField(),
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
    );
  }

  List<Widget> _buildFormFields() {
    final fields = [
      {
        'key': 'name',
        'hint': 'John Doe',
        'icon': Icons.person,
        'label': 'Full Name',
      },
      {
        'key': 'email',
        'hint': 'john@example.com',
        'icon': Icons.email,
        'label': 'Email Address',
      },
      {
        'key': 'phone',
        'hint': '+201068561700',
        'icon': Icons.phone,
        'label': 'WhatsApp Number',
      },
      {
        'key': 'hotel',
        'hint': 'Hilton Waterfront',
        'icon': Icons.hotel,
        'label': 'Hotel Name',
      },
    ];

    return fields
        .map(
          (field) => Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  field['label'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _controllers[field['key']],
                  decoration: InputDecoration(
                    hintText: field['hint'] as String,
                    prefixIcon: Icon(
                      field['icon'] as IconData,
                      color: Colors.blue[600],
                      size: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
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
        Text(
          'Select Date',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
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
            );
            if (picked != null) setState(() => selectedDate = picked);
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[50],
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.blue[600], size: 16),
                const SizedBox(width: 10),
                Text(
                  selectedDate != null
                      ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                      : 'Select a date',
                  style: TextStyle(
                    color:
                        selectedDate != null ? Colors.black : Colors.grey[600],
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
        const SizedBox(width: 15),
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
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[50],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(value.toString(), textAlign: TextAlign.center),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () => onChanged(value + 1),
                    child: Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.green[600],
                      size: 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: value > 0 ? () => onChanged(value - 1) : null,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: value > 0 ? Colors.red[600] : Colors.grey[400],
                      size: 20,
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
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1a73e8), Color(0xFF1a73e8)],
        ),
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
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Text(
                '£$totalPrice',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Text('£', style: TextStyle(color: Colors.white, fontSize: 22)),
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
          backgroundColor: const Color(0xfffedc07),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 6,
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
                    Icon(Icons.rocket_launch, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Book Your Adventure',
                      style: TextStyle(
                        fontSize: 14,
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
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Column(
        children: [
          Text(
            'Why Choose Us?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.price_check, color: Colors.green[600], size: 14),
              const SizedBox(width: 6),
              const Expanded(child: Text('Best price guarantee')),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.support_agent, color: Colors.green[600], size: 14),
              const SizedBox(width: 6),
              const Expanded(child: Text('24/7 customer support')),
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
