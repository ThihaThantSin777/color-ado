import 'package:color_ado/bloc/base_bloc.dart';
import 'package:color_ado/utils/enums.dart';
import 'package:color_ado/widgets/sample_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingStateWidget<T extends BaseBloc> extends StatelessWidget {
  const LoadingStateWidget({super.key, required this.loadingState, required this.widgetForSuccessState});

  final Widget widgetForSuccessState;
  final LoadingState loadingState;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingState == LoadingState.kError) {
        final bloc = context.read<T>();
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => SampleDialogWidget(
                  title: 'Error',
                  content: bloc.getErrorMessage ?? "",
                  buttonText: "OK",
                  onButtonPressed: () {
                    Navigator.of(context).pop();
                  },
                ));
      }
    });

    return switch (loadingState) {
      LoadingState.kLoading => const Center(
          child: CircularProgressIndicator(),
        ),
      LoadingState.kSuccess => widgetForSuccessState,
      _ => const SizedBox.shrink(),
    };
  }
}
