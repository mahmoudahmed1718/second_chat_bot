import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:second_chat_bot/core/services/api/api_client.dart';
import 'package:second_chat_bot/features/chat/data/services/gemine_chat_service.dart';

class MockApiClient extends Mock implements DioApiClient {}

void main() {
  late MockApiClient mockApiClient;
  late GemenaiChatService gemenaiChatService;

  setUpAll(() {
    registerFallbackValue(Options());
  });

  setUp(() {
    mockApiClient = MockApiClient();
    gemenaiChatService = GemenaiChatService(apiClient: mockApiClient);
  });

  group('GemenaiChatService', () {
    test(
      'should throw Server error and NOT retry when server error occurs',
      () async {
        when(
          () => mockApiClient.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            response: Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 500,
            ),
            type: DioExceptionType.badResponse,
          ),
        );

        expect(
          () => gemenaiChatService.sendMessage(messages: []),
          throwsA(
            predicate(
              (e) => e is Exception && e.toString().contains("Server error"),
            ),
          ),
        );

        verify(
          () => mockApiClient.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).called(1);
      },
    );

    test(
      'should retry 3 times and throw No internet connection when connection error occurs',
      () async {
        when(
          () => mockApiClient.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
          ),
        );

        expect(
          () => gemenaiChatService.sendMessage(messages: []),
          throwsA(
            predicate(
              (e) =>
                  e is Exception &&
                  e.toString().contains("No internet connection"),
            ),
          ),
        );

        verify(
          () => mockApiClient.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).called(3);
      },
    );
  });
}
