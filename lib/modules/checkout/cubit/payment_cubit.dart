import 'dart:async';
import 'dart:developer';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_it/get_it.dart';

import '../../../base/cubit.dart';
import '../../../base/state.dart';
import '../../../repositories/payment/payment_model.dart';
import '../../../repositories/payment/payment_repository.dart';

part 'payment_state.dart';

class PaymentCubit extends FCubit<PaymentState> {
  PaymentCubit()
      : super(
          const PaymentState(status: ScreenStatus.value),
        );

  /// amount: dollar
  void onCheckoutPressed(int amount,
      {required void Function() onPaymentSuccessful}) async {
    emitLoading();

    late StreamSubscription subscription;
    subscription = GetIt.I<PaymentRepository>()
        .createCheckoutSession(
          FPayment(
            amount: amount,
          ),
        )
        .listen(null)
      ..onData(
        (stripe) async {
          try {
            await Stripe.instance.initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                customerId: stripe.customerId,
                customerEphemeralKeySecret: stripe.ephemeralKeySecret,
                paymentIntentClientSecret: stripe.paymentIntentClientSecret,
                merchantDisplayName: 'Ninja App',
                googlePay: const PaymentSheetGooglePay(
                  merchantCountryCode: 'USA',
                  currencyCode: 'USD',
                  testEnv: true,
                ),
              ),
            );
            await Stripe.instance.presentPaymentSheet();
          } catch (e) {
            if (e is StripeException) {
              emitError(e.error.message.toString());
              return;
            }
            emitError(e.runtimeType.toString());
            return;
          }
          emitValue(state.copyWith(isSuccess: true));
          final intent = await Stripe.instance
              .retrievePaymentIntent(stripe.paymentIntentClientSecret!);
          log(intent.status.name);
          onPaymentSuccessful();
          subscription.cancel();
        },
      )
      ..onError((e, st) {
        emitError(e.runtimeType.toString());
      });
  }
}
