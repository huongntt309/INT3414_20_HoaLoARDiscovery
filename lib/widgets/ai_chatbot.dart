import 'package:flutter/material.dart';
import 'package:hoa_lo_ar_discovery/components/appbar_home.dart';
import 'package:hoa_lo_ar_discovery/components/navbar_home.dart';
import 'package:intl/intl.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../models/message.dart';
import '../models/messages.dart';
import '../utils/size.dart';
import '../utils/style.dart';

class AIChatbotScreen extends StatefulWidget {
  const AIChatbotScreen({Key? key}) : super(key: key);

  @override
  State<AIChatbotScreen> createState() => _AIChatbotScreenState();
}

class _AIChatbotScreenState extends State<AIChatbotScreen> {
  TextEditingController _userMessage = TextEditingController();
  bool isLoading = false;

  static const apiKey = "YOUR_API_KEY";

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
    const promptHoalo  = "Trong chủ đề Nhà tù Hỏa Lò - Hà Nội - Việt Nam, tôi muốn tìm hiểu về:";
    const promptLengText  = ". Giới hạn trả lời trong 100 đến 200 chữ ";
    final model =
        GenerativeModel(model: "gemini-1.5-flash-latest", apiKey: apiKey);
    final content = [Content.text(promptHoalo + message + promptLengText)];
    final response = await model.generateContent(content);

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
      backgroundColor: Color(0xFFFDEEDB),
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(),
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
                      hintText: 'What do you want to know about Hoa Lo?',
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
                                child: CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(Colors.brown),
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
      bottomNavigationBar: CustomNavbar(currentIndex: 1),
    );
  }
}
