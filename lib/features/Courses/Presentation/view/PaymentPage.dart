import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:llearning/features/Courses/data/model/course_model.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

class PaymentPage extends ConsumerStatefulWidget {
  final CourseModel course;

  const PaymentPage({Key? key, required this.course}) : super(key: key);

  @override
  ConsumerState<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
  String? selectedPaymentMethod;

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _confirmPayment() {
    if (selectedPaymentMethod != null) {
      if (selectedPaymentMethod == 'PayPal') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => UsePaypal(
              sandboxMode: true,
              clientId: "AcnpbvL-nqay69eboBK-a2hcQLnkFTQZXbTF0f4UafVwhRYAXe11Z0B3PtFyWCTDH24INY6Cu2U0rhRC",
              secretKey: "EGZXWncK71BKAfqH7ClPpldekK6kSKvO9yIk0Loz36CkdM7uLC_vuE5mjbGjRhJhBT5BeOYyBB-_p6WW",
              returnURL: "https://samplesite.com/return",
              cancelURL: "https://samplesite.com/cancel",
              transactions: [
                {
                  "amount": {
                    "total": widget.course.price,
                    "currency": "USD",
                    "details": {
                      "subtotal": widget.course.price,
                      "shipping": '0',
                      "shipping_discount": 0,
                    },
                  },
                  "description": "The payment transaction description.",
                  "item_list": {
                    "items": [
                      {
                        "name": widget.course.title,
                        "quantity": 1,
                        "price": widget.course.price,
                        "currency": "USD",
                      },
                    ],

                  },
                },
              ],
              note: "Contact us for any questions on your order.",
              onSuccess: (Map params) async {
                if (mounted) {
                  setState(() {
                    // Handle successful payment
                  });
                }
                print("onSuccess: $params");
                // Handle successful payment
              },
              onError: (error) {
                if (mounted) {
                  setState(() {
                    // Handle successful payment
                  });
                }
                print("onError: $error");
                // Handle payment error
              },
              onCancel: (params) {
                if (mounted) {
                  setState(() {
                    // Handle successful payment
                  });
                }
                print('Cancelled: $params');
                // Handle payment cancellation
              },
            ),
          ),
        );
      } else {
        // Handle other payment methods
        print('Processing payment via $selectedPaymentMethod');
      }
    } else {
      print('Please select a payment method');
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Banner Image
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(
                    "http://10.0.2.2:3000/thumbnails/${widget.course.thumbnail}",
                  ),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Course Title
            Text(
              widget.course.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            // Course Description
            Text(
              widget.course.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),

            // Checkout Section
            _buildCheckoutSummary(),

            const SizedBox(height: 30),

            // Payment Options Header
            const Text(
              'Select Payment Method',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // Payment Methods
            _buildPaymentMethod(Icons.account_balance, 'Khalti', 'Pay via Khalti for quick transactions', screenWidth),
            _buildPaymentMethod(Icons.paypal, 'PayPal', 'Secure global payment through PayPal', screenWidth),

            const SizedBox(height: 30),

            // Confirm Payment Button
            Center(
              child: ElevatedButton(
                onPressed: _confirmPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  elevation: 6,
                ),
                child: const Text(
                  'Confirm Payment',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Checkout summary widget
  Widget _buildCheckoutSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Checkout Summary',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Course Price:', style: TextStyle(fontSize: 18)),
              Text(
                'Npr.${widget.course.price}',
                style: const TextStyle(fontSize: 18, color: Colors.green),
              ),
            ],
          ),
          const Divider(height: 20, color: Colors.black26),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total:', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text(
                'Npr.${widget.course.price}',
                style: const TextStyle(fontSize: 22, color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Payment method builder widget
  Widget _buildPaymentMethod(IconData icon, String method, String description, double screenWidth) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.purple, size: screenWidth * 0.08),
        title: Text(
          method,
          style: TextStyle(
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: screenWidth * 0.04,
          ),
        ),
        onTap: () {
          setState(() {
            selectedPaymentMethod = method;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected: $method')),
          );
        },
        tileColor: selectedPaymentMethod == method ? Colors.purple[50] : Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: selectedPaymentMethod == method ? Colors.purple : Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
        ),
      ),
    );
  }
}
