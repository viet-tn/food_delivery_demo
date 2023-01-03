import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import '../../constants/constants.dart';
import '../../gen/assets.gen.dart';
import '../../utils/ui/scaffold.dart';
import '../../widgets/buttons/back_button.dart';
import '../chat/widgets/loading_indicator.dart';
import '../cubits/app/app_cubit.dart';
import 'cubit/notification_cubit.dart';
import 'widgets/notification_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late final NotificationCubit _cubit = GetIt.I<NotificationCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.fetchFirstNotificationBatch(GetIt.I<AppCubit>().state.user!.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: FScaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: Ui.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FBackButton(),
                  gapH12,
                  Text(
                    'Notification',
                    style: FTextStyles.heading1
                        .copyWith(color: FColors.metallicOrange),
                  ),
                  gapH12,
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<NotificationCubit, NotificationState>(
                buildWhen: (previous, current) =>
                    previous.notifications != current.notifications,
                builder: (context, state) {
                  return state.notifications.when(
                    error: (message, _) => Text(message),
                    loading: (_) => const Center(
                      child: FLoadingIndicator(),
                    ),
                    empty: (_) => Center(
                      child: SizedBox.square(
                        dimension: 300,
                        child: SvgPicture.asset(
                          Assets.images.illustrations.empty,
                        ),
                      ),
                    ),
                    data: (notifications) => ListView.separated(
                      padding: Ui.screenPaddingHorizontal,
                      itemCount: notifications.length,
                      separatorBuilder: (context, index) => gapH8,
                      itemBuilder: (context, index) => NotificationCard(
                        notification: notifications[index],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
