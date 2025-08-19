import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/mpesa/presentation/blocs/mpesa_bloc/mpesa_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/mpesa/presentation/listeners/mpesa_listeners/mpesa_listener.dart';
import 'package:flutter_fb_auth_bloc/features/mpesa/presentation/widgets/mpesa/payment.dart';

class MpesaPage extends StatefulWidget {
  const MpesaPage({super.key});

  @override
  State<MpesaPage> createState() => _MpesaPageState();
}

class _MpesaPageState extends State<MpesaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mpess Payment', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: BlocConsumer<MpesaBloc, MpesaState>(
        listener: mpesaListener,
        builder: (context, state) {
          return MpesaFormWidget();
        },
      ),
    );
  }
}
