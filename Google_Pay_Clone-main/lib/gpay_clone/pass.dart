import 'package:flutter/material.dart';
import 'package:gpay_clone/gpay_clone/payment_page.dart';

// Ensure you import the PaymentPage
// import 'payment_page.dart';

class UpiPinEntryScreen extends StatefulWidget {
  const UpiPinEntryScreen({super.key});

  @override
  _UpiPinEntryScreenState createState() => _UpiPinEntryScreenState();
}

class _UpiPinEntryScreenState extends State<UpiPinEntryScreen> {
  List<String> pin = ["", "", "", "", "", ""];

  get bankId => null;

  void _addDigit(String digit) {
    setState(() {
      for (int i = 0; i < pin.length; i++) {
        if (pin[i].isEmpty) {
          pin[i] = digit;
          break;
        }
      }
    });
  }

  void _deleteDigit() {
    setState(() {
      for (int i = pin.length - 1; i >= 0; i--) {
        if (pin[i].isNotEmpty) {
          pin[i] = "";
          break;
        }
      }
    });
  }

  void _submitPin() {
    // Navigate to PaymentPage
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Container(
              width: 420,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(0.0),
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(0.0),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'State Bank Of India',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'XXXX7278',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFf1f1f1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(0.0),
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(0.0),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'To:',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'PALAKURTHY RISHI KUMAR',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFf1f1f1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(0.0),
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(0.0),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sending:',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '₹ 1.00',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'ENTER 6-DIGIT UPI PIN',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    pin[index],
                    style: const TextStyle(fontSize: 24),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              decoration: const BoxDecoration(
                color: Color(0xFFf6e8bb),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const Icon(
                    Icons.error,
                    color: Color(0xFFf69c00),
                    size: 35,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'You are transferring money from\n your State Bank Of India account\n to $bankId',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: 500,
              height: 290,
              decoration: const BoxDecoration(
                color: Color(0xFFf1f1f1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(0.0),
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(0.0),
                ),
              ),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 5,
                  childAspectRatio: 2.0,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  if (index == 9) {
                    return GestureDetector(
                      onTap: _deleteDigit,
                      child: Container(
                        color: const Color(0xFFf1f1f1),
                        child: const Center(
                          child: Icon(
                            Icons.backspace,
                            color: Color(0xFF183088),
                          ),
                        ),
                      ),
                    );
                  } else if (index == 10) {
                    return GestureDetector(
                      onTap: () => _addDigit("0"),
                      child: Container(
                        color: const Color(0xFFf1f1f1),
                        child: const Center(
                          child: Text(
                            "0",
                            style: TextStyle(
                              fontSize: 34,
                              color: Color(0xFF183088),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (index == 11) {
                    return GestureDetector(
                      onTap: _submitPin,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  } else {
                    String digit = (index + 1).toString();
                    return GestureDetector(
                      onTap: () => _addDigit(digit),
                      child: Container(
                        color: const Color(0xFFf1f1f1),
                        child: Center(
                          child: Text(
                            digit,
                            style: const TextStyle(
                              fontSize: 34,
                              color: Color(0xFF183088),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}