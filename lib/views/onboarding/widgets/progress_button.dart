part of 'onboarding_body.dart';

/// {@template progress_button}
/// A circular button with an indicator around it.
///
/// It indicates how much of the onboarding process has passed.
///
/// It only goes forward.
///
/// Once the user has reached the last page, it morphs into
/// a normal button.
/// {@endtemplate}
class _ProgressButton extends StatelessWidget {
  /// {@macro progress_button}
  _ProgressButton({
    required int index,
    required String label,
  })  : _index = index.toDouble(),
        _label = label;

  final double _index;
  final String _label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedScale(
            scale: _index == 3 ? 0 : 1.0,
            duration: const Duration(milliseconds: 300),
            child: SizedBox(
              height: ViewsConstant.buttonHeight + 10,
              width: ViewsConstant.buttonHeight + 10,
              child: TweenAnimationBuilder(
                duration: const Duration(milliseconds: 200),
                tween: Tween<double>(begin: 0, end: _index / 3),
                builder: (context, value, _) => CircularProgressIndicator(
                  value: value,
                  strokeCap: StrokeCap.round,
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: ViewsConstant.buttonHeight,
            width: _index == 3 ? 200 : ViewsConstant.buttonHeight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(42),
                ),
              ),
              onPressed: () => context.read<OnboardingCubit>().proceed(
                  () => Navigator.pushReplacement(context, HomePage.route())),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: const Interval(0.5, 1.0),
                    ),
                  ),
                  child: child,
                ),
                child: _index == 3
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(_label),
                      )
                    : const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
