import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../utils/ui/listen_error.dart';
import '../../../utils/ui/scaffold.dart';
import '../../../widgets/buttons/back_button.dart';
import '../../login/cubit/login_cubit.dart';
import '../widgets/widgets.dart';
import 'cubit/chat_detail_cubit.dart';
import 'cubit/chat_detail_state.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({
    super.key,
    required this.chatId,
    required this.chatWithUserId,
  });

  final String chatId;
  final String chatWithUserId;

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  late final _scrollController = ScrollController();
  late final ChatDetailCubit _cubit = GetIt.I<ChatDetailCubit>()
    ..init(
      widget.chatId,
      widget.chatWithUserId,
    );
  late final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controllerHandler();
  }

  void _controllerHandler() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    } else {
      Timer(const Duration(milliseconds: 50), _controllerHandler);
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext _) {
    return BlocProvider(
      create: (_) => _cubit,
      child: ListenError<ChatDetailCubit>(
        child: FScaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: Ui.screenPadding,
                child: _AppBar(),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        gapH32,
                        Expanded(
                          child: Padding(
                            padding: Ui.screenPaddingHorizontal,
                            child:
                                BlocBuilder<ChatDetailCubit, ChatDetailState>(
                              buildWhen: (previous, current) =>
                                  previous.status != current.status ||
                                  previous.messages != current.messages,
                              builder: (context, state) {
                                return ChatDetailContents(
                                  onRefresh: () => context
                                      .read<ChatDetailCubit>()
                                      .fetchMoreMessages(state.messages.first),
                                  messages: state.messages,
                                  myUserId: GetIt.I<LoginCubit>().state.user.id,
                                  controller: _scrollController,
                                  isLoading: state.status.isLoading,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: Ui.screenPadding,
                      child: SizedBox.fromSize(
                        size: const Size.fromHeight(80.0),
                        child: BlocBuilder<ChatDetailCubit, ChatDetailState>(
                          buildWhen: (_, __) => false,
                          builder: (context, state) {
                            return UserStatus(
                              userId: state.chatWithUserId!,
                              lastSeen: 0,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<ChatDetailCubit, ChatDetailState>(
                buildWhen: (_, __) => false,
                builder: (context, _) {
                  return SendMessageTextField(
                    onSubmitted: context.read<ChatDetailCubit>().sendMessage,
                    textEditingController: _textEditingController,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        gapH12,
        FBackButton(),
        gapH12,
        Text(
          'Chat',
          style: FTextStyles.heading2,
        )
      ],
    );
  }
}
