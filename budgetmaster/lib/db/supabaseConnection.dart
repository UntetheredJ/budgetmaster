import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

Future<Supabase> Connection() async {
  WidgetsFlutterBinding.ensureInitialized();
  var supabase = await Supabase.initialize(
      url: 'https://colsjgxpgxbwqqkpjduo.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNvbHNqZ3hwZ3hid3Fxa3BqZHVvIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODgwNTMyNTYsImV4cCI6MjAwMzYyOTI1Nn0.HZoiOuvAGCHn56gDXRVfwUixHGO6FJ1rSs5tiV_3FRY',
  );
  return supabase;
}