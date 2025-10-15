import 'package:flutter/material.dart';

/// Estados possíveis da view
enum ViewState { idle, loading, success, error, empty }

/// Base ViewModel seguindo MVVM pattern
abstract class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  String _errorMessage = '';

  ViewState get state => _state;
  String get errorMessage => _errorMessage;
  
  bool get isLoading => _state == ViewState.loading;
  bool get hasError => _state == ViewState.error;
  bool get isEmpty => _state == ViewState.empty;
  bool get isSuccess => _state == ViewState.success;

  /// Atualiza o estado da view
  void setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  /// Define erro
  void setError(String message) {
    _errorMessage = message;
    _state = ViewState.error;
    notifyListeners();
  }

  /// Limpa erro
  void clearError() {
    _errorMessage = '';
    if (_state == ViewState.error) {
      _state = ViewState.idle;
      notifyListeners();
    }
  }
}