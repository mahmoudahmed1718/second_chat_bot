import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:second_chat_bot/features/chat/data/models/chat_message_model.dart';
import 'package:second_chat_bot/features/chat/data/models/chat_message_part_model.dart';

import 'package:second_chat_bot/features/chat/data/repos/chat_repo_impl.dart';
import 'package:second_chat_bot/features/chat/data/services/gemine_chat_service.dart';

void main() {
  late ChatRepoImpl chatRepoImpl;
  late MockGemenaiChatService mockApiConsumer;
  setUp(() {
    mockApiConsumer = MockGemenaiChatService();
    chatRepoImpl = ChatRepoImpl(gemenaiChatService: mockApiConsumer);
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
        () => mockApiConsumer.sendMessage(messages: any(named: 'messages')),
      ).thenAnswer((_) async => ChatMessageModel(parts: [], role: 'assistant'));
      expect(
        () => chatRepoImpl.sendMessage(messages: []),
        throwsA(isA<ArgumentError>()),
      );
    });
    test('should throw a StateError if response has invalid role', () {
      when(
        () => mockApiConsumer.sendMessage(messages: any(named: 'messages')),
      ).thenAnswer(
        (_) async => ChatMessageModel(
          parts: [ChatMessagePartModel(text: 'Hello')],
          role: 'invalid_role',
        ),
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
        throwsA(isA<ArgumentError>()),
      );
    });
    test(
      'should throw state if API Response error: Empty text in response parts.',
      () {
        when(
          () => mockApiConsumer.sendMessage(messages: any(named: 'messages')),
        ).thenAnswer(
          (_) async => ChatMessageModel(
            parts: [ChatMessagePartModel(text: '')],
            role: 'assistant',
          ),
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
          throwsA(isA<ArgumentError>()),
        );
      },
    );
  });
}

class MockGemenaiChatService extends Mock implements GemenaiChatService {}
