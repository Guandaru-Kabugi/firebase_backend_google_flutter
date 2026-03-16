import 'package:flutter/material.dart';
import 'package:flutter_fb_auth_bloc/core/services/injections_imports.dart';
import 'package:flutter_fb_auth_bloc/features/myapp.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env"); 
  
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  runApp(const MyApp());
}