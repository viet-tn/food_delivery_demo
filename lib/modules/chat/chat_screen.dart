import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/modules/cubits/app/app_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../config/routes/coordinator.dart';
import '../../constants/ui/text_style.dart';
import '../../constants/ui/ui_parameters.dart';
import '../../gen/assets.gen.dart';
import '../../utils/ui/listen_error.dart';
import '../../utils/ui/scaffold.dart';
import '../login/cubit/login_cubit.dart';
import 'cubit/chat_cubit.dart';
import 'widgets/widgets.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().init(context.read<AppCubit>().state.user!.id);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FCoordinator.goNamed(Routes.home.name);
        return false;
      },
      child: ListenError<ChatCubit>(
        // bloc: _cubit,
        child: FScaffold(
          body: Column(
            children: [
              const _AppBar(),
              Expanded(
                child: BlocBuilder<ChatCubit, ChatState>(
                  // bloc: _cubit,
                  buildWhen: (previous, current) =>
                      previous.status != current.status ||
                      previous.chats != current.chats,
                  builder: (context, state) {
                    return state.chats.isEmpty
                        ? SizedBox.square(
                            dimension: 300.0,
                            child: SvgPicture.asset(
                              Assets.images.illustrations.chat,
                            ),
                          )
                        : ChatBody(
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
