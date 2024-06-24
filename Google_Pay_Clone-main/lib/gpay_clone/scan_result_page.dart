import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pass.dart';

class ScanResultPage extends StatefulWidget {
  final String scannedData;

  const ScanResultPage({Key? key, required this.scannedData}) : super(key: key);

  @override
  _ScanResultPageState createState() => _ScanResultPageState();
}

class _ScanResultPageState extends State<ScanResultPage> {
  String bankingName = 'ASHWITHA MANNE';
  final TextEditingController _controller = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    final processedData = _processScannedData(widget.scannedData);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.black),
            onPressed: () {
              // Handle info action
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // Handle more options
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 130),
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.purple,
                  child: Icon(Icons.person, color: Colors.white, size: 40),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Paying ******3556',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  'Banking name: $bankingName',
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  'UPI ID: $processedData',
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 20),
                _buildNumericInputField(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Handle add note action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text('Add a note'),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Container(
                  width: 55.0,
                  height: 55.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD6E5FC),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 30,
                    color: Colors.blue,
                  ),
                ),
                onPressed: () {
                  _showPaymentSheet(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _processScannedData(String data) {
    String processedData = data.length > 13 ? data.substring(13) : '';
    int atIndex = processedData.indexOf('@');
    if (atIndex != -1 && processedData.length > atIndex + 4) {
      processedData = processedData.substring(0, atIndex + 4);
    }
    return processedData;
  }

  Widget _buildNumericInputField() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(8),
              ],
              style: const TextStyle(color: Colors.black, fontSize: 30),
              onChanged: (text) {
                setState(() {});
              },
            ),
            const Positioned(
              left: 10,
              child: Icon(
                Icons.currency_rupee,
                color: Colors.black,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: PaymentSheetContent(amount: _controller.text),
          ),
        );
      },
    );
  }
}

class PaymentSheetContent extends StatelessWidget {
  final String amount;

  const PaymentSheetContent({Key? key, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Amount: ₹$amount',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.attach_money),
            label: const Text('Pay'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  const UpiPinEntryScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: const Size(double.infinity, 50),
              textStyle: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}