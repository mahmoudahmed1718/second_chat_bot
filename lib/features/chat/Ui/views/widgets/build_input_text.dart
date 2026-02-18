import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:second_chat_bot/core/utils/app_styel.dart';
import 'package:second_chat_bot/features/chat/Ui/manger/cubit/chat_cubit.dart';
import 'package:second_chat_bot/features/chat/domain/entites/gemini_message_entity.dart';
import 'package:second_chat_bot/theme/app_colors.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class BuildInputText extends StatefulWidget {
  final List<GeminiMessageEntity> messages;
  const BuildInputText({super.key, required this.messages});

  @override
  State<BuildInputText> createState() => _BuildInputTextState();
}

class _BuildInputTextState extends State<BuildInputText> {
  late stt.SpeechToText _speech;
  bool isListening = false;

  final _formKey = GlobalKey<FormBuilderState>();
  final ValueNotifier<bool> hasText = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  void dispose() {
    _speech.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: FormBuilder(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    name: 'message',
                    decoration: InputDecoration(
                      hintText: "Write Your Message",
                      hintStyle: AppStyles.fontStyle13.copyWith(
                        color: const Color(0XFFA1A1A1),
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) async {
                      hasText.value = value != null && value.trim().isNotEmpty;
                    },
                  ),
                ),

                /// 🎤 Mic Button
                IconButton(
                  icon: Icon(
                    isListening ? Icons.mic : Icons.mic_none,
                    color: isListening ? Colors.red : Colors.grey,
                  ),
                  onPressed: _listen,
                ),

                /// 📤 Send Button
                ValueListenableBuilder<bool>(
                  valueListenable: hasText,
                  builder: (context, active, _) {
                    return IconButton(
                      icon: Icon(
                        Icons.send,
                        color: active ? AppColors.primaryColor : Colors.grey,
                      ),
                      onPressed: active
                          ? () {
                              final text = _formKey
                                  .currentState
                                  ?.fields['message']
                                  ?.value;

                              if (text != null && text.trim().isNotEmpty) {
                                var message = GeminiMessageEntity(
                                  text: text,
                                  isFromUser: true,
                                );
                                widget.messages.add(message);
                                context
                                    .read<SendMessageCubit>()
                                    .getGemineReponse(
                                      messages: widget.messages,
                                    );
                                _formKey.currentState?.reset();
                                hasText.value = false;
                              }
                            }
                          : null,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _listen() async {
    if (!isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => isListening = true);

        _speech.listen(
          onResult: (result) {
            final text = result.recognizedWords;

            _formKey.currentState?.fields['message']?.didChange(text);
            hasText.value = text.trim().isNotEmpty;
          },
        );
      }
    } else {
      setState(() => isListening = false);
      _speech.stop();
    }
  }
}
