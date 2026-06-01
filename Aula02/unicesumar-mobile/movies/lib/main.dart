import 'package:colorize_lumberdash/colorize_lumberdash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:movies/ui/theme/theme.dart';
import 'package:movies/ui/theme/themeWhite.dart';
import 'package:movies/utils/prefs.dart';
import 'package:movies/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  putLumberdashToWork(withClients: [
    ColorizeLumberdash(),
  ]);
  await dotenv.load(fileName: '.env');
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  bool isDarkMode = true;

  @override
  void initState() {                  
    super.initState();
    _carregarTema();                 
  }

  Future<void> _carregarTema() async { 
    final temaSalvo = await Prefs.getTheme(); 

    setState(() {
      isDarkMode = temaSalvo;         
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    final isDarkMode = ref.watch(themeProvider);
    return MaterialApp.router(
      routerConfig: router.config(),
      title: 'Movies',
      debugShowCheckedModeBanner: false,
      theme: isDarkMode             
          ? createTheme()
          : createThemeWhite(),
    );
  }
}