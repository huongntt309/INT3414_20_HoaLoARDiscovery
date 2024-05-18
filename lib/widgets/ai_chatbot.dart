import 'package:flutter/material.dart';
import 'package:hoa_lo_ar_discovery/components/appbar_home.dart';
import 'package:hoa_lo_ar_discovery/components/navbar_home.dart';
import 'package:hoa_lo_ar_discovery/utils/language_manager.dart';
import 'package:intl/intl.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../models/message.dart';
import '../models/messages.dart';
import '../utils/size.dart';
import '../utils/style.dart';

class AIChatbotScreen extends StatefulWidget {
  final Map<String, dynamic> languageData;

  const AIChatbotScreen({super.key, required this.languageData});

  @override
  State<AIChatbotScreen> createState() => _AIChatbotScreenState();
}

class _AIChatbotScreenState extends State<AIChatbotScreen> {
  String selectedLanguage = LanguageManager().selectedLanguage; // Lấy ngôn ngữ
  final TextEditingController _userMessage = TextEditingController();
  bool isLoading = false;

  static const apiKey = "YOUR_API_KEY";
  // Get API key from https://aistudio.google.com/app/apikey
  final model =
      GenerativeModel(model: "gemini-1.5-flash-latest", apiKey: apiKey);
  final List<Message> _messages = [];

  void sendMessage() async {
    final message = _userMessage.text;
    _userMessage.clear();

    setState(() {
      _messages.add(Message(
        isUser: true,
        message: message,
        date: DateTime.now(),
      ));
      isLoading = true;
    });
    
    

    final promptCmd = widget.languageData[selectedLanguage]['prompt_cmd'];
    final promptHoalo = widget.languageData[selectedLanguage]['prompt_hoa_lo'];
    final promptTopic = widget.languageData[selectedLanguage]['prompt_topic'];
    final promptLengText = widget.languageData[selectedLanguage]['prompt_leng_text'];
    
    final promptFull = promptCmd + message + promptHoalo + promptTopic + promptLengText;
    final content = [Content.text(promptFull)];
    final response = await model.generateContent(content);

    /* 
      promptFull = promptCmd + message + promptHoalo + promptTopic + promptLengText
      - promptCmd: "Hãy tìm kiếm cho tôi thêm thông tin với từ khóa: "
      - message
      - promptHoalo: "ở trong chủ đề Nhà tù Hỏa Lò - Hà Nội - Việt Nam. "
      - promptTopic: "Nếu từ khóa không phù hợp với chủ đề Nhà tù Hỏa Lò, hãy hỏi kĩ lại ý kiến của người dùng. "
      - promptLengText: "Nội dung trả lời là một vài đoạn văn ngắn, giới hạn chỉ nên trong 100 đến 200 từ."
    */
    

    setState(() {
      _messages.add(Message(
        isUser: false,
        message: response.text ?? "",
        date: DateTime.now(),
      ));
    });
  }

  void onAnimatedTextFinished() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDEEDB),
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: 'Hoa Lo AI Chatbot'),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return Messages(
                      isUser: message.isUser,
                      message: message.message,
                      date: DateFormat('HH:mm').format(message.date),
                      onAnimatedTextFinished: onAnimatedTextFinished,
                      // onAnimatedTextFinished: onAnimatedTextFinished,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: medium, vertical: small),
                child: Expanded(
                  flex: 20,
                  child: TextFormField(
                    maxLines: 6,
                    minLines: 1,
                    controller: _userMessage,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.fromLTRB(medium, 0, small, 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(xlarge),
                      ),
                      hintText: widget.languageData[selectedLanguage]
                          ['hint_text'],
                      hintStyle: hintText,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          if (!isLoading && _userMessage.text.isNotEmpty) {
                            sendMessage();
                          }
                        },
                        child: isLoading
                            ? Container(
                                width: medium,
                                height: medium,
                                margin: const EdgeInsets.all(xsmall),
                                child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.brown),
                                  strokeWidth: 3,
                                ),
                              )
                            : Icon(
                                Icons.arrow_upward,
                                color: _userMessage.text.isNotEmpty
                                    ? Colors.brown
                                    : const Color(0x5A6C6C65),
                              ),
                      ),
                    ),
                    style: promptText,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: const CustomNavbar(currentIndex: 1),
    );
  }
}
