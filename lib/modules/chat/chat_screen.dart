import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../config/routes/coordinator.dart';
import '../../constants/ui/text_style.dart';
import '../../constants/ui/ui_parameters.dart';
import '../../utils/ui/listen_error.dart';
import '../../utils/ui/scaffold.dart';
import '../login/cubit/login_cubit.dart';
import 'cubit/chat_cubit.dart';
import 'widgets/widgets.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FCoordinator.goNamed(Routes.home.name);
        return false;
      },
      child: BlocProvider(
        create: (context) => GetIt.I<ChatCubit>(),
        child: ListenError<ChatCubit>(
          child: FScaffold(
            body: Column(
              children: [
                const _AppBar(),
                Expanded(
                  child: BlocBuilder<ChatCubit, ChatState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status ||
                        previous.chats != current.chats,
                    builder: (context, state) {
                      return ChatBody(
                        chats: state.chats,
                        myUserId: GetIt.I<LoginCubit>().state.user.id,
                      );
                    },
                  ),
                ),
              ],
            ),
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
    return const Padding(
      padding: Ui.screenPadding,
      child: SizedBox(
        height: 50.0,
        child: Center(
          child: Text(
            'Chat',
            style: FTextStyles.heading2,
          ),
        ),
      ),
    );
  }
}
