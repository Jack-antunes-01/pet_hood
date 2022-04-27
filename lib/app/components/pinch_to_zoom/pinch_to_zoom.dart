import 'package:flutter/material.dart';

class PinchToZoom extends StatefulWidget {
  const PinchToZoom({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<PinchToZoom> createState() => _PinchToZoomState();
}

class _PinchToZoomState extends State<PinchToZoom>
    with SingleTickerProviderStateMixin {
  late TransformationController controller;
  late AnimationController animationController;
  Animation<Matrix4>? animation;

  final double minScale = 1;
  final double maxScale = 4;
  double scale = 1;
  OverlayEntry? entry;

  @override
  void initState() {
    super.initState();

    controller = TransformationController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )
      ..addListener(() => controller.value = animation!.value)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          removeOverlay();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildImage(),
    );
  }

  Widget _buildImage() {
    return Builder(
      builder: (context) => InteractiveViewer(
        transformationController: controller,
        minScale: minScale,
        maxScale: maxScale,
        clipBehavior: Clip.none,
        onInteractionUpdate: (details) {
          if (entry == null) return;
          scale = details.scale;
          entry!.markNeedsBuild();
        },
        onInteractionStart: (details) {
          if (details.pointerCount < 2) return;

          if (entry == null) {
            showOverlay(context);
          }
        },
        onInteractionEnd: (details) {
          if (details.pointerCount != 1) return;

          resetAnimation();
        },
        // clipBehavior: Clip.none,
        panEnabled: false,
        child: AspectRatio(
          aspectRatio: 1.2,
          child: widget.child,
        ),
      ),
    );
  }

  void showOverlay(BuildContext context) {
    final renderBox = context.findRenderObject()! as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = MediaQuery.of(context).size;

    entry = OverlayEntry(
      builder: (context) {
        final opacity = ((scale - 1) / (maxScale - 1)).clamp(0.2, 1.0);
        return Stack(children: [
          Positioned.fill(
            child: Opacity(
                opacity: opacity, child: Container(color: Colors.black)),
          ),
          Positioned(
            left: offset.dx,
            top: offset.dy,
            width: size.width,
            child: _buildImage(),
          ),
        ]);
      },
    );
    final overlay = Overlay.of(context)!;
    overlay.insert(entry!);
  }

  void removeOverlay() {
    entry?.remove();
    entry = null;
  }

  void resetAnimation() {
    animation = Matrix4Tween(
      begin: controller.value,
      end: Matrix4.identity(),
    ).animate(CurvedAnimation(parent: animationController, curve: Curves.ease));

    animationController.forward(from: 0);
  }
}
