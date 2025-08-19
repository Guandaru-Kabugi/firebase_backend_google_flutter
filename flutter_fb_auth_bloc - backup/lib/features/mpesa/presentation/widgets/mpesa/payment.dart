import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/mpesa/presentation/blocs/mpesa_bloc/mpesa_bloc.dart';
//import 'package:flutter_fb_auth_bloc/features/auth/presentation/views/home/home.dart';

class MpesaFormWidget extends StatefulWidget {
  const MpesaFormWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MpesaFormState();
  }
}

class _MpesaFormState extends State<MpesaFormWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MpesaBloc>().state;
    final state2 = context.watch<MpesaBloc>().state;
    final isLoading = state is MpesaLoadingState;
    final resetController = state2 is MpesaResetState;
    if (resetController) {
      _amountController.clear();
      _phoneController.clear();
    }
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: "Phone Number"),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number';
                }
                if (!value.startsWith('254') || value.length != 12) {
                  return 'Please enter a valid phone number starting with 254';
                }
                return null;
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount (KES)',
                hintText: 'Enter amount',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.money),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid amount';
                }
                if (double.parse(value) <= 0) {
                  return 'Amount must be greater than 0';
                }
                return null;
              },
            ),
            const SizedBox(height: 30.0),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        final phoneNumber = _phoneController.text;
                        final amount = double.parse(_amountController.text);

                        context.read<MpesaBloc>().add(
                          MpesaSTKPushEvent(amount: amount, phoneNumber: phoneNumber)
                        );

                        // Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => Home(),));
                      }
                    },
              child: isLoading
                  ? const Text('Wait while we prompt you')
                  : const Text("Pay"),
            ),
          ],
        ),
      ),
    );
  }
}
