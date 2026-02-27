import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:second_chat_bot/core/services/api/api_consumer.dart';
import 'package:second_chat_bot/features/chat/data/models/chat_message_model.dart';
import 'package:second_chat_bot/features/chat/data/models/chat_message_part_model.dart';

import 'package:second_chat_bot/features/chat/data/repos/chat_repo_impl.dart';

void main() {
  late ChatRepoImpl chatRepoImpl;
  late MockApiConsumer mockApiConsumer;
  setUp(() {
    mockApiConsumer = MockApiConsumer();
    chatRepoImpl = ChatRepoImpl(apiConsumer: mockApiConsumer);
  });
  setUpAll(() {});
  group('send message input validation', () {
    test('should throw ArgumentError when messages list is empty', () {
      expect(
        () => chatRepoImpl.sendMessage(messages: []),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should throw ArgumentError when message text is empty', () {
      expect(
        () => chatRepoImpl.sendMessage(
          messages: [
            ChatMessageModel(
              parts: [ChatMessagePartModel(text: '')],
              role: 'user',
            ),
          ],
        ),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('send message output validation', () {
    test('should throw ArgumentError when API response is empty', () {
      when(
        () => mockApiConsumer.post(any(), data: any(named: 'data')),
      ).thenAnswer((_) async => {});
      expect(
        () => chatRepoImpl.sendMessage(messages: []),
        throwsA(isA<ArgumentError>()),
      );
    });
    test('should throw a stateError if response has invaild role', () {
      when(
        () => mockApiConsumer.post(any(), data: any(named: 'data')),
      ).thenAnswer(
        (_) async => {
          "role": "invalid_role",
          "parts": [
            {"text": "Hello, how can I assist you today?"},
          ],
        },
      );
      expect(
        () => chatRepoImpl.sendMessage(
          messages: [
            ChatMessageModel(
              parts: [ChatMessagePartModel(text: 'Hello')],
              role: 'user',
            ),
          ],
        ),
        throwsA(isA<StateError>()),
      );
    });
  });
  test(
    'should throw state if API Response error: Empty text in response parts.',
    () {
      when(() => mockApiConsumer.post(any(), data: any(named: 'data')));
      expect(
        () => chatRepoImpl.sendMessage(
          messages: [
            ChatMessageModel(
              parts: [ChatMessagePartModel(text: 'Hello')],
              role: 'user',
            ),
          ],
        ),
        throwsA(isA<StateError>()),
      );
    },
  );
}

class MockApiConsumer extends Mock implements ApiConsumer {}
