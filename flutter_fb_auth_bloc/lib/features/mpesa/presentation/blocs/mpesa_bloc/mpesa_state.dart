part of 'mpesa_bloc.dart';

abstract class MpesaState extends Equatable {
  const MpesaState();
  
  @override
  List<Object> get props => [];
}

final class MpesaInitial extends MpesaState {}
class MpesaLoadingState extends MpesaState{}
class MpesaLoadedState extends MpesaState{
  final String message;
  const MpesaLoadedState({required this.message});
  @override
  List<Object> get props => [message];
}
class MpesaErrorState extends MpesaState{
  final String message;

  const MpesaErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
class MpesaResetState extends MpesaState{}


