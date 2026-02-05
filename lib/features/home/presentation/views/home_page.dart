// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
// import 'package:second_chat_bot/features/home/presentation/views/widgets/build_chat_app_bar.dart';
// import 'package:second_chat_bot/features/home/presentation/views/widgets/build_input_text.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   // Expert Tip: Add a ScrollController to manage the chat position
//   final ScrollController _scrollController = ScrollController();

//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildChatAppBar(context),
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: BlocBuilder<HomeBloc, HomeState>(
//           bloc: HomeBloc.to,
//           builder: (context, state) {
//             // Trigger scroll when a new message arrives
//             _scrollToBottom();

//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child:
//                         state
//                             .messages!
//                             .isNotEmpty // Use the history list
//                         ? ListView.builder(
//                             controller: _scrollController,
//                             itemCount: state.messages!.length,
//                             padding: const EdgeInsets.only(top: 10),
//                             itemBuilder: (context, index) {
//                               final chatMessage = state.messages![index];
//                               return ChatBubble(
//                                 isUser: chatMessage.isUser,
//                                 message: chatMessage.text, // Simple and clean
//                               );
//                             },
//                           )
//                         : const Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 16),
//                             child: SingleChildScrollView(
//                               child: BuildSuggetionWidget(),
//                             ),
//                           ),
//                   ),
//                   const BuildInputText(),
//                   const Gap(16),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
