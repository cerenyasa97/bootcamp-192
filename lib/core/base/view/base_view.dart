import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swapy/core/base/view_model/base_view_model.dart';
import 'package:swapy/core/extension/context_extension.dart';

class BaseView<T extends BaseViewModel> extends StatelessWidget {
  final T vmBuilder;
  final Widget Function(BuildContext, T)? builder;

  const BaseView({Key? key, required this.vmBuilder, required this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => vmBuilder,
      builder: (context, _) => Consumer<T>(
        builder: _buildScreenContent,
      ),
    );
  }

  Widget _buildScreenContent(
          BuildContext context, T viewModel, Widget? child) =>
      !viewModel.isInitializeDone
          ? Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Stack(
            children: [
              if (builder != null) builder!(context, viewModel),
              Visibility(
                  visible: viewModel.isLoading,
                  child: Container(
                    color: Colors.white38,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ))
            ],
          );
}
