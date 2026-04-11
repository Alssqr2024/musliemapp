import 'package:flutter/material.dart';
import 'package:musliemapp/core/theme/app_theme.dart';

/// A unified wrapper for pages that provides the global background gradient and scaffold structure.
class MainScaffold extends StatelessWidget {
  final Widget? body;
  
  /// If provided, uses a CustomScrollView directly. 
  /// Ignored if [body] is provided.
  final List<Widget>? slivers;
  
  final ScrollController? scrollController;
  final ScrollPhysics? physics;
  
  const MainScaffold({
    super.key,
    this.body,
    this.slivers,
    this.scrollController,
    this.physics = const BouncingScrollPhysics(),
  }) : assert(body != null || slivers != null, 'Either body or slivers must be provided.');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Stack(
        children: [
          // Global Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: AppTheme.mainGradient,
            ),
          ),
          
          // Page Content
          if (body != null) body!,
          if (body == null && slivers != null)
            CustomScrollView(
              controller: scrollController,
              physics: physics,
              slivers: slivers!,
            ),
        ],
      ),
    );
  }
}
