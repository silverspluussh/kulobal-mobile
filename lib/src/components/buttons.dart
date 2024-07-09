import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constant/style.dart';

class MainButton extends StatefulWidget {
  const MainButton(
      {super.key, required this.action, required this.text, this.color});
  final void Function()? action;
  final String text;
  final Color? color;

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Semantics(
        child: GestureDetector(
          onTapUp: (details) => setState(() => isTapped = false),
          onTapDown: (details) => setState(() => isTapped = true),
          onTapCancel: () => setState(() => isTapped = false),
          onTap: widget.action,
          child: Transform.scale(
            scale: isTapped ? 0.95 : 1.0,
            child: AnimatedContainer(
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                color: isTapped
                    ? widget.color != null
                        ? widget.color?.withOpacity(0.5)
                        : KPrimary.withOpacity(0.5)
                    : widget.color ?? KPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              duration: 100.ms,
              child: Center(
                child: Text(
                  widget.text,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: KWhite, fontFamily: fontName[1], fontSize: 17),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MainButtonOutline extends StatefulWidget {
  const MainButtonOutline(
      {super.key, required this.action, required this.text});
  final void Function()? action;
  final String text;

  @override
  State<MainButtonOutline> createState() => _MainButtonOutlineState();
}

class _MainButtonOutlineState extends State<MainButtonOutline> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Semantics(
        child: GestureDetector(
          onTapUp: (details) => setState(() => isTapped = false),
          onTapDown: (details) => setState(() => isTapped = true),
          onTapCancel: () => setState(() => isTapped = false),
          onTap: widget.action,
          child: Transform.scale(
            scale: isTapped ? 0.95 : 1.0,
            child: AnimatedContainer(
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                  color: isTapped ? KPrimary.withOpacity(0.5) : KPrimary,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              duration: 100.ms,
              child: Text(
                widget.text,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: isTapped ? KPrimary.withOpacity(0.5) : KPrimary,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextBtn extends TextButton {
  TextBtn(
      {super.key,
      required VoidCallback onPressed,
      required String child,
      TextDecoration? deco,
      required BuildContext context})
      : super(
            child: Text(child,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    decoration: deco ?? TextDecoration.underline,
                    fontFamily: fontName[0])),
            onPressed: onPressed);
}
