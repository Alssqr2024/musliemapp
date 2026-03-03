import 'package:flutter_test/flutter_test.dart';
import 'package:musliemapp/core/services/logger_service.dart';

void main() {
  group('LoggerService', () {
    test('لا يرمي استثناء عند استدعاء debug', () {
      expect(() => LoggerService.debug('test'), returnsNormally);
    });

    test('لا يرمي استثناء عند استدعاء info', () {
      expect(() => LoggerService.info('test'), returnsNormally);
    });

    test('لا يرمي استثناء عند استدعاء warning', () {
      expect(() => LoggerService.warning('test'), returnsNormally);
    });

    test('لا يرمي استثناء عند استدعاء error', () {
      expect(() => LoggerService.error('test'), returnsNormally);
    });
  });
}
