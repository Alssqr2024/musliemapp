import 'package:get/get.dart';
import 'package:musliemapp/core/services/logger_service.dart';

/// Base controller with common functionality
/// Reduces code duplication across all controllers
abstract class BaseController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  /// Handle errors consistently across all controllers
  void handleError(Object error, [String? context]) {
    final errorMsg = error.toString();
    errorMessage.value = errorMsg;
    LoggerService.error(
      'Error in ${runtimeType}${context != null ? " - $context" : ""}',
      error,
      StackTrace.current,
      runtimeType.toString(),
    );
  }

  /// Clear error message
  void clearError() {
    errorMessage.value = '';
  }

  /// Set loading state
  void setLoading(bool value) {
    isLoading.value = value;
  }

  @override
  void onClose() {
    isLoading.close();
    errorMessage.close();
    super.onClose();
  }
}
