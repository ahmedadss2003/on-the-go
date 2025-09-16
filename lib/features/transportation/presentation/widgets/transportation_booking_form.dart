import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:on_the_go/features/transportation/data/models/transportation_model.dart';
import 'package:on_the_go/features/transportation/presentation/manager/transportation_booking_cubit/transportation_booking_cubit.dart';

class TransportBookingForm extends StatefulWidget {
  const TransportBookingForm({super.key, required this.transportationModel});
  final TransportationModel transportationModel;
  static const routeName = '/transportation-booking-form';

  @override
  TransportBookingScreenState createState() => TransportBookingScreenState();
}

class TransportBookingScreenState extends State<TransportBookingForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _hotelNameController = TextEditingController();
  final _flightNumberController = TextEditingController();
  final _arrivalAirportController = TextEditingController();
  final _goingToController = TextEditingController();
  final _departureAirportController = TextEditingController();
  final _pickUpLocationController = TextEditingController();
  final _flightArrivalController = TextEditingController();
  final _flightDepartureController = TextEditingController();
  final _numberOfAdultsController = TextEditingController();
  final _numberOfChildrenController = TextEditingController();
  final _messageController = TextEditingController();
  DateTime? _flightArrivalDateTime;
  DateTime? _flightDepartureDateTime;
  String? _tripType = 'One Way'; // Default to One Way

  @override
  void initState() {
    super.initState();
    _numberOfAdultsController.text = '1';
    _numberOfChildrenController.text = '0';
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _hotelNameController.dispose();
    _flightNumberController.dispose();
    _arrivalAirportController.dispose();
    _goingToController.dispose();
    _departureAirportController.dispose();
    _pickUpLocationController.dispose();
    _flightArrivalController.dispose();
    _flightDepartureController.dispose();
    _numberOfAdultsController.dispose();
    _numberOfChildrenController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  double _calculateTotalPrice() {
    int numberOfAdults = int.tryParse(_numberOfAdultsController.text) ?? 0;
    int numberOfChildren = int.tryParse(_numberOfChildrenController.text) ?? 0;

    double adultsPrice = numberOfAdults * widget.transportationModel.price;
    double childrenPrice =
        numberOfChildren * widget.transportationModel.childPrice;
    double subtotal = adultsPrice + childrenPrice;

    return subtotal * (_tripType == 'Two Way' ? 2 : 1);
  }

  Map<String, double> _getPriceBreakdown() {
    int numberOfAdults = int.tryParse(_numberOfAdultsController.text) ?? 0;
    int numberOfChildren = int.tryParse(_numberOfChildrenController.text) ?? 0;

    double adultsPrice = numberOfAdults * widget.transportationModel.price;
    double childrenPrice =
        numberOfChildren * widget.transportationModel.childPrice;
    double subtotal = adultsPrice + childrenPrice;
    double multiplier = (_tripType == 'Two Way' ? 2 : 1);

    return {
      'adultsPrice': adultsPrice,
      'childrenPrice': childrenPrice,
      'subtotal': subtotal,
      'multiplier': multiplier,
      'total': subtotal * multiplier,
    };
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final bookingData = {
        'full_name': _fullNameController.text,
        'email': _emailController.text,
        'phone_number': _phoneController.text,
        'hotel_name': _hotelNameController.text,
        'flight_number': _flightNumberController.text,
        'trip_type': _tripType,
        'number_of_adults': int.tryParse(_numberOfAdultsController.text) ?? 0,
        'number_of_children':
            int.tryParse(_numberOfChildrenController.text) ?? 0,
        'total_passengers':
            (int.tryParse(_numberOfAdultsController.text) ?? 0) +
            (int.tryParse(_numberOfChildrenController.text) ?? 0),
        'message': _messageController.text,
        'transportation_id': widget.transportationModel.id,
        'transportation_type': widget.transportationModel.typeBus,
        'adult_price': widget.transportationModel.price,
        'child_price': widget.transportationModel.childPrice,
        'total_price': _calculateTotalPrice(),
        'timestamp': FieldValue.serverTimestamp(),
        // One Way fields
        if (_tripType == 'One Way') ...{
          'arrival_airport': _arrivalAirportController.text,
          'going_to': _goingToController.text,
          'flight_arrival': _flightArrivalDateTime?.toIso8601String(),
        },
        // Two Way fields
        if (_tripType == 'Two Way') ...{
          'departure_airport': _departureAirportController.text,
          'pick_up_location': _pickUpLocationController.text,
          'flight_departure': _flightDepartureDateTime?.toIso8601String(),
          'flight_arrival': _flightArrivalDateTime?.toIso8601String(),
        },
      };

      final cubit = context.read<TransportationBookingCubit>();
      await cubit.bookTransportation(bookingData);
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? Function(String?)? validator,
    bool readOnly = false,
    VoidCallback? onTap,
    IconData? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        ),
        validator:
            validator ??
            (value) =>
                (value?.isEmpty ?? true) ? 'This field is required.' : null,
      ),
    );
  }

  Widget _buildNumberField({
    required TextEditingController controller,
    required String label,
    required String price,
    required Color priceColor,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Required';
              int? number = int.tryParse(value!);
              if (number == null || number < 0) return 'Invalid number';
              return null;
            },
            onChanged: (value) {
              setState(() {}); // Refresh to update total price
            },
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              color: priceColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: priceColor.withOpacity(0.3)),
            ),
            child: Text(
              price,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: priceColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceBreakdown() {
    final breakdown = _getPriceBreakdown();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price Breakdown',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 12),
          if (breakdown['adultsPrice']! > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Adults (${_numberOfAdultsController.text} × £${widget.transportationModel.price.toStringAsFixed(2)})',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                Text(
                  '£${breakdown['adultsPrice']!.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          if (breakdown['childrenPrice']! > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Children (${_numberOfChildrenController.text} × £${widget.transportationModel.childPrice.toStringAsFixed(2)})',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                Text(
                  '£${breakdown['childrenPrice']!.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          if (breakdown['adultsPrice']! > 0 || breakdown['childrenPrice']! > 0)
            Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Text(
                '£${breakdown['subtotal']!.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          if (_tripType == 'Two Way')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Two Way (× 2)',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                Text(
                  '£${(breakdown['subtotal']! * 2).toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Price',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                '£${breakdown['total']!.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Transportation'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE0F7FA), Colors.white],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: BlocConsumer<TransportationBookingCubit, BookingState>(
                  listener: (context, state) {
                    if (state is BookingSuccess) {
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.scale,
                        title: "Success",
                        desc: "Transportation Booking Successfully",
                        dialogType: DialogType.success,
                        btnOkOnPress: () {
                          Navigator.pop(context);
                        },
                      ).show();
                    } else if (state is BookingFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Booking failed: ${state.message}'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.blue[50]!, Colors.blue[100]!],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  widget.transportationModel.typeBus,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[800],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Adult',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '£${widget.transportationModel.price.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            color: Colors.green[600],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Child',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '£${widget.transportationModel.childPrice.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            color: Colors.orange[600],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          _buildTextField(
                            controller: _fullNameController,
                            label: 'Full Name',
                            hint: 'John Doe',
                          ),
                          _buildTextField(
                            controller: _emailController,
                            label: 'Email Address',
                            hint: 'sample@yourcompany.com',
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'This field is required.';
                              }
                              if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(value!)) {
                                return 'Please enter a valid email address.';
                              }
                              return null;
                            },
                          ),
                          _buildTextField(
                            controller: _phoneController,
                            label: 'Phone Number',
                            hint: '+66-4353434',
                          ),
                          _buildTextField(
                            controller: _hotelNameController,
                            label: 'Hotel Name',
                            hint: 'Hilton Sharm El Sheikh',
                          ),
                          _buildTextField(
                            controller: _flightNumberController,
                            label: 'Flight Number',
                            hint: 'EG123',
                          ),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Trip Type',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            value: _tripType,
                            items:
                                ['One Way', 'Two Way'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _tripType = newValue;
                                // Reset fields when trip type changes
                                _arrivalAirportController.clear();
                                _goingToController.clear();
                                _departureAirportController.clear();
                                _pickUpLocationController.clear();
                                _flightArrivalController.clear();
                                _flightDepartureController.clear();
                                _flightArrivalDateTime = null;
                                _flightDepartureDateTime = null;
                              });
                            },
                            validator:
                                (value) =>
                                    value == null
                                        ? 'This field is required.'
                                        : null,
                          ),
                          SizedBox(height: 15),
                          if (_tripType == 'One Way') ...[
                            _buildTextField(
                              controller: _arrivalAirportController,
                              label: 'Arrival Airport',
                              hint: 'Cairo International Airport',
                            ),
                            _buildTextField(
                              controller: _goingToController,
                              label: 'Going To',
                              hint: 'Sharm El Sheikh',
                            ),
                          ],
                          if (_tripType == 'Two Way') ...[
                            _buildTextField(
                              controller: _departureAirportController,
                              label: 'Departure Airport',
                              hint: 'Sharm El Sheikh International Airport',
                            ),
                            _buildTextField(
                              controller: _pickUpLocationController,
                              label: 'Pick Up Location',
                              hint: 'Hilton Sharm El Sheikh',
                            ),
                          ],
                          _buildTextField(
                            controller: _flightArrivalController,
                            label: 'Flight Arrival',
                            hint: 'Select date and time',
                            readOnly: true,
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2026),
                              );
                              if (date != null) {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (time != null) {
                                  setState(() {
                                    _flightArrivalDateTime = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      time.hour,
                                      time.minute,
                                    );
                                    _flightArrivalController.text = DateFormat(
                                      'dd/MM/yyyy HH:mm',
                                    ).format(_flightArrivalDateTime!);
                                  });
                                }
                              }
                            },
                            suffixIcon: Icons.calendar_today,
                            validator:
                                (value) =>
                                    _flightArrivalDateTime == null
                                        ? 'This field is required.'
                                        : null,
                          ),
                          if (_tripType == 'Two Way')
                            _buildTextField(
                              controller: _flightDepartureController,
                              label: 'Flight Departure',
                              hint: 'Select date and time',
                              readOnly: true,
                              onTap: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2026),
                                );
                                if (date != null) {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (time != null) {
                                    setState(() {
                                      _flightDepartureDateTime = DateTime(
                                        date.year,
                                        date.month,
                                        date.day,
                                        time.hour,
                                        time.minute,
                                      );
                                      _flightDepartureController
                                          .text = DateFormat(
                                        'dd/MM/yyyy HH:mm',
                                      ).format(_flightDepartureDateTime!);
                                    });
                                  }
                                }
                              },
                              suffixIcon: Icons.calendar_today,
                              validator:
                                  (value) =>
                                      _flightDepartureDateTime == null
                                          ? 'This field is required for two-way trips.'
                                          : null,
                            ),
                          SizedBox(height: 20),
                          Text(
                            'Number of Passengers',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 15),
                          _buildNumberField(
                            controller: _numberOfAdultsController,
                            label: 'Adults',
                            price:
                                '£${widget.transportationModel.price.toStringAsFixed(2)}',
                            priceColor: Colors.green,
                          ),
                          SizedBox(height: 15),
                          _buildNumberField(
                            controller: _numberOfChildrenController,
                            label: 'Children',
                            price:
                                '£${widget.transportationModel.childPrice.toStringAsFixed(2)}',
                            priceColor: Colors.orange,
                          ),
                          SizedBox(height: 20),
                          _buildTextField(
                            controller: _messageController,
                            label: 'Message (Optional)',
                            hint: 'Enter any additional information...',
                            validator: (_) => null,
                          ),
                          SizedBox(height: 20),
                          _buildPriceBreakdown(),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed:
                                state is BookingLoading ? null : _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child:
                                    state is BookingLoading
                                        ? Center(
                                          child: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          ),
                                        )
                                        : Text(
                                          'Book Now - £${_calculateTotalPrice().toStringAsFixed(2)}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
