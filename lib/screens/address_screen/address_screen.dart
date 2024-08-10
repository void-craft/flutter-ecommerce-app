import 'package:buy_it_app/screens/payment/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:buy_it_app/widgets/appbar/custom_appbar_widget.dart';

class AddressEntryScreen extends StatefulWidget {
  final double totalAmount;

  const AddressEntryScreen({Key? key, required this.totalAmount})
      : super(key: key);

  @override
  _AddressEntryScreenState createState() => _AddressEntryScreenState();
}

class _AddressEntryScreenState extends State<AddressEntryScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _billingNameController = TextEditingController();
  final TextEditingController _billingEmailController = TextEditingController();
  final TextEditingController _billingPhoneController = TextEditingController();
  final TextEditingController _billingAddressController =
      TextEditingController();
  final TextEditingController _billingCityController = TextEditingController();
  final TextEditingController _billingStateController = TextEditingController();
  final TextEditingController _billingZipCodeController =
      TextEditingController();

  final TextEditingController _shippingNameController = TextEditingController();
  final TextEditingController _shippingEmailController =
      TextEditingController();
  final TextEditingController _shippingPhoneController =
      TextEditingController();
  final TextEditingController _shippingAddressController =
      TextEditingController();
  final TextEditingController _shippingCityController = TextEditingController();
  final TextEditingController _shippingStateController =
      TextEditingController();
  final TextEditingController _shippingZipCodeController =
      TextEditingController();

  bool _sameAsBilling = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: true,
        isTitleCentered: true,
        title: "Your Address",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Billing Info
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade50,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 5.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Billing Address',
                            style: Theme.of(context).textTheme.titleLarge),
                      ),
                      _buildTextField(_billingNameController, 'Name'),
                      _buildTextField(_billingEmailController, 'Email'),
                      _buildTextField(_billingPhoneController, 'Phone'),
                      _buildTextField(
                          _billingAddressController, 'Address'),
                      _buildTextField(_billingCityController, 'City'),
                      _buildTextField(_billingStateController, 'State'),
                      _buildTextField(
                          _billingZipCodeController, 'Zip Code'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Shipping Info
                CheckboxListTile(
                  title: const Text('Same as billing address'),
                  value: _sameAsBilling,
                  onChanged: (bool? value) {
                    setState(() {
                      _sameAsBilling = value ?? false;
                      if (_sameAsBilling) {
                        _shippingNameController.text =
                            _billingNameController.text;
                        _shippingEmailController.text =
                            _billingEmailController.text;
                        _shippingPhoneController.text =
                            _billingPhoneController.text;
                        _shippingAddressController.text =
                            _billingAddressController.text;
                        _shippingCityController.text =
                            _billingCityController.text;
                        _shippingStateController.text =
                            _billingStateController.text;
                        _shippingZipCodeController.text =
                            _billingZipCodeController.text;
                      }
                    });
                  },
                ),
                if (!_sameAsBilling) ...[
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Shipping Address',
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                        _buildTextField(
                            _shippingNameController, 'Name'),
                        _buildTextField(
                            _shippingEmailController, 'Email'),
                        _buildTextField(
                            _shippingPhoneController, 'Phone'),
                        _buildTextField(
                            _shippingAddressController, 'Address'),
                        _buildTextField(
                            _shippingCityController, 'City'),
                        _buildTextField(
                            _shippingStateController, 'State'),
                        _buildTextField(
                            _shippingZipCodeController, 'Zip Code'),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(
                            billingName: _billingNameController.text,
                            billingEmail: _billingEmailController.text,
                            billingPhone: _billingPhoneController.text,
                            billingAddress: _billingAddressController.text,
                            billingCity: _billingCityController.text,
                            billingState: _billingStateController.text,
                            billingZipCode: _billingZipCodeController.text,
                            shippingName: _sameAsBilling
                                ? _billingNameController.text
                                : _shippingNameController.text,
                            shippingEmail: _sameAsBilling
                                ? _billingEmailController.text
                                : _shippingEmailController.text,
                            shippingPhone: _sameAsBilling
                                ? _billingPhoneController.text
                                : _shippingPhoneController.text,
                            shippingAddress: _sameAsBilling
                                ? _billingAddressController.text
                                : _shippingAddressController.text,
                            shippingCity: _sameAsBilling
                                ? _billingCityController.text
                                : _shippingCityController.text,
                            shippingState: _sameAsBilling
                                ? _billingStateController.text
                                : _shippingStateController.text,
                            shippingZipCode: _sameAsBilling
                                ? _billingZipCodeController.text
                                : _shippingZipCodeController.text,
                            totalAmount: widget.totalAmount,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple, // Custom button color
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Proceed to Payment', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.white, // Background color of the text field
        ),
        validator: (value) =>
            value == null || value.isEmpty ? 'Please enter $label' : null,
      ),
    );
  }
}
