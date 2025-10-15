import 'package:flutter/material.dart';
import 'package:cine_topia/app/ui/components/buttons.dart';
import 'package:cine_topia/app/ui/screens/dashboard.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF000000),
              Color(0xFF1D0E44),
            ],
            begin: Alignment.topCenter,
          ), // LinearGradient
        ), // BoxDecoration
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/logo.png',
                height: 120,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.movie,
                      size: 60,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              
              // Splash Image
              Image.asset(
                'assets/splash.png',
                height: 200,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.local_movies,
                      size: 80,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              
              // Texto de descrição
              const Text(
                'O lugar ideal para buscar, salvar e organizar seus filmes favoritos!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 60),
              
              // Botão "Quero Começar"
              PrimaryButton(
                text: "Quero começar!",
                icon: Icons.arrow_forward,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Dashboard()
                  )
                ),
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}
