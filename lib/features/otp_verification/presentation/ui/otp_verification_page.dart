import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/core/base/base_page/base_page.dart';
import 'package:splittr/core/designs/designs.dart';
import 'package:splittr/core/global/presentation/blocs/global_bloc.dart';
import 'package:splittr/core/route_handler/route_handler.dart';
import 'package:splittr/features/otp_verification/presentation/blocs/otp_verification_bloc.dart';
import 'package:splittr/utils/utils.dart';

part 'otp_verification_form.dart';

class OtpVerificationPage extends BasePage<OtpVerificationBloc> {
  const OtpVerificationPage({
    super.key,
    required super.args,
  });

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OtpVerificationBloc, OtpVerificationState>(
        buildWhen: (_, __) {
          return false;
        },
        listener: _handleState,
        builder: _handleWidget,
      ),
    );
  }

  void _handleState(BuildContext context, OtpVerificationState state) {
    return switch (state) {
      UserAuthenticateSuccessful() => _onUserAuthenticateSuccessful(
          context: context,
          state: state,
        ),
      _ => null,
    };
  }

  Widget _handleWidget(BuildContext context, OtpVerificationState state) {
    return const _OtpVerificationForm();
  }

  void _showSnackBar(BuildContext context) {
    showSnackBar(context, 'Otp Verified');
  }

  void _onUserAuthenticateSuccessful({
    required BuildContext context,
    required UserAuthenticateSuccessful state,
  }) {
    getBloc<GlobalBloc>(context).userUpdated(state.user);

    _showSnackBar(context);

    _navigateToDashboard(context);
  }

  void _navigateToDashboard(BuildContext context) {
    RouteHandler.pushAndRemoveUntil(context, RouteId.dashboard);
  }
}
