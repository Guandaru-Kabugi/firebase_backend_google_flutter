import 'package:flutter/material.dart';
import 'package:flutter_fb_auth_bloc/core/services/injections_imports.dart';
import 'package:flutter_fb_auth_bloc/features/myapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  runApp(const MyApp());
}