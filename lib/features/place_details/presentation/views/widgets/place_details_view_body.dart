import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:intl/intl.dart';

class PlaceDetailsViewBody extends StatefulWidget {
  const PlaceDetailsViewBody({super.key});

  @override
  PlaceDetailsViewBodyState createState() => PlaceDetailsViewBodyState();
}

class PlaceDetailsViewBodyState extends State<PlaceDetailsViewBody>
    with SingleTickerProviderStateMixin {
  // Demo data
  static const Map<String, dynamic> _demoPlace = {
    'title': 'Santorini Island Adventure',
    'description':
        'Experience the breathtaking beauty of Santorini with its iconic white-washed buildings, stunning sunsets, and crystal-clear waters. This full-day tour includes visits to Oia village, Fira town, and traditional wineries.',
    'images': [
      'https://images.unsplash.com/photo-1613395877344-13d4a8e0d49e?w=800',
      'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?w=800',
      'https://images.unsplash.com/photo-1533105079780-92b9be482077?w=800',
    ],
    'priceAdult': 120,
    'priceChild': 60,
    'discount': 20,
    'timeOfTour': '8 Hours',
    'numberOfPeople': 15,
    'ageRequirement': 12,
    'availability': 'All Year',
    'departureTime': '08:00:00',
    'returnTime': '18:00:00',
    'youtubeVideoUrl': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
    'includes': ['Professional Guide', 'Transportation', 'Lunch', 'Entry Fees'],
    'notIncludes': ['Personal Expenses', 'Tips', 'Travel Insurance', 'Drinks'],
  };

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
    _animController.forward();
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    _animController.dispose();
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
    final images = _demoPlace['images'] as List<String>;

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
                              // Navigation arrows
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
                        // Page indicators
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
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
                // Placeholder for similar tours
                Container(
                  height: 200,
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(child: Text('Similar Tours Section')),
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
                  image: NetworkImage(_demoPlace['images'][0]),
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
                  _buildHeroStat("4.5", 'Rating', Icons.star),
                  _buildHeroStat(
                    _demoPlace['timeOfTour'],
                    'Duration',
                    Icons.access_time,
                  ),
                  _buildHeroStat(
                    _demoPlace['numberOfPeople'].toString(),
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
          _demoPlace['title'],
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
                _demoPlace['timeOfTour'],
                'Duration',
              ),
              _buildStatItem(
                Icons.groups,
                '${_demoPlace['ageRequirement']}+',
                'Min Age',
              ),
              _buildStatItem(
                Icons.calendar_month,
                _demoPlace['availability'],
                'Available',
              ),
              _buildStatItem(
                Icons.people,
                _demoPlace['numberOfPeople'].toString(),
                'Group Size',
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
          _demoPlace['description'],
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
            'Around ${_formatTime(_demoPlace['departureTime'])}',
            Icons.schedule,
          ),
          const SizedBox(height: 15),
          _buildInfoRow(
            'Return Time',
            'Around ${_formatTime(_demoPlace['returnTime'])}',
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
        final includeList = _demoPlace['includes'] as List<String>;
        final notIncludeList = _demoPlace['notIncludes'] as List<String>;

        return isMobile
            ? Column(
              children: [
                _buildIncludedCard(
                  'Included',
                  includeList,
                  Colors.green,
                  Icons.check_circle,
                ),
                const SizedBox(height: 15),
                _buildIncludedCard(
                  'Not Included',
                  notIncludeList,
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
                    includeList,
                    Colors.green,
                    Icons.check_circle,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildIncludedCard(
                    'Not Included',
                    notIncludeList,
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
    final price = (_demoPlace['priceAdult'] - _demoPlace['discount']) as int;
    final totalPrice =
        (adults * price + children * _demoPlace['priceChild']).toString();

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
                  '£$price ',
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
                '£ $totalPrice',
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

  String _formatTime(String timeString) {
    try {
      final parsedTime = DateFormat("HH:mm:ss").parse(timeString);
      return DateFormat.jm().format(parsedTime);
    } catch (e) {
      return timeString;
    }
  }
}
