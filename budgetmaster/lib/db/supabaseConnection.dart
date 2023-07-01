import 'package:supabase/supabase.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();

  factory SupabaseService() {
    return _instance;
  }

  SupabaseClient? _client;

  SupabaseService._internal();

  Future<void> initialize() async {

    _client = SupabaseClient(
        'https://colsjgxpgxbwqqkpjduo.supabase.co',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNvbHNqZ3hwZ3hid3Fxa3BqZHVvIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODgwNTMyNTYsImV4cCI6MjAwMzYyOTI1Nn0.HZoiOuvAGCHn56gDXRVfwUixHGO6FJ1rSs5tiV_3FRY');

    final response = await _client!.from('usuario').select();
    if (response == null) {
      print('Error al conectar a Supabase');
    } else {
      print('Conexión a Supabase exitosa');
    }
  }

  SupabaseClient get client {
    assert(_client != null, 'La conexión a Supabase no ha sido inicializada.');
    return _client!;
  }
}