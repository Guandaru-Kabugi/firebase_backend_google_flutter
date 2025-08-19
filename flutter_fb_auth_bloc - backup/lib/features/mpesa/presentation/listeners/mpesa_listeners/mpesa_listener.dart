import 'package:flutter/material.dart';
import 'package:flutter_fb_auth_bloc/features/mpesa/presentation/blocs/mpesa_bloc/mpesa_bloc.dart';

void mpesaListener(BuildContext context, MpesaState state){
  if (state is MpesaLoadedState) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
  }
  else if(state is MpesaErrorState){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
  }
  
}