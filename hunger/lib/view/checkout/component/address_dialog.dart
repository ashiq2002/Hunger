import 'package:flutter/material.dart';
import 'package:hunger/provider/checkout_provider.dart';
import 'package:provider/provider.dart';

class AddressDialog extends StatefulWidget {
  const AddressDialog({Key? key}) : super(key: key);

  @override
  State<AddressDialog> createState() => _AddressDialogState();
}

class _AddressDialogState extends State<AddressDialog> {
  final TextEditingController _addressEditingController =
      TextEditingController();

  @override
  void dispose() {
    _addressEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CheckoutProvider>(context, listen: false);

    return AlertDialog(
      backgroundColor: Colors.brown[50],
      content: SizedBox(
        height: 150,
        child: Column(
          children: [
            Expanded(
              child: TextFormField(
                controller: _addressEditingController,
                decoration: const InputDecoration(
                    hintText: 'Enter address',
                    enabledBorder: OutlineInputBorder()),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (_addressEditingController.text.isNotEmpty) {
                    provider.setShippingAddress(_addressEditingController.text);
                  }
                  if(provider.shippingAddress.isNotEmpty){
                    provider.setIsShippingCompleted(true);
                  }
                  Navigator.pop(context);
                },
                child: const Text('Add'))
          ],
        ),
      ),
    );
  }
}
