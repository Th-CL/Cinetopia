import 'package:flutter/material.dart';
import 'package:cine_topia/app/viewmodels/base_viewmodel.dart';

/// Widget base para Views seguindo MVVM pattern
abstract class BaseView<T extends BaseViewModel> extends StatefulWidget {
  const BaseView({super.key});
}

abstract class BaseViewState<T extends BaseViewModel, V extends BaseView<T>> 
    extends State<V> {
  
  late T viewModel;

  /// Método para criar o ViewModel
  T createViewModel();

  /// Constrói a UI baseada no estado
  Widget buildView(BuildContext context);

  /// Widget de loading customizável
  Widget buildLoading() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB370FF)),
          ),
          SizedBox(height: 16),
          Text(
            'Carregando...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  /// Widget de erro customizável
  Widget buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 64,
            ),
            const SizedBox(height: 16),
            const Text(
              'Oops! Algo deu errado',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => onRetry(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB370FF),
                foregroundColor: Colors.white,
              ),
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget de lista vazia customizável
  Widget buildEmpty() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.movie_outlined,
            color: Colors.white54,
            size: 64,
          ),
          SizedBox(height: 16),
          Text(
            'Nenhum resultado encontrado',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// Método chamado quando usuário tenta novamente
  void onRetry() {
    // Override em subclasses se necessário
  }

  @override
  void initState() {
    super.initState();
    viewModel = createViewModel();
    viewModel.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    viewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  void _onViewModelChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // Constrói a UI baseada no estado do ViewModel
    switch (viewModel.state) {
      case ViewState.loading:
        return buildLoading();
      case ViewState.error:
        return buildError(viewModel.errorMessage);
      case ViewState.empty:
        return buildEmpty();
      case ViewState.success:
      case ViewState.idle:
        return buildView(context);
    }
  }
}