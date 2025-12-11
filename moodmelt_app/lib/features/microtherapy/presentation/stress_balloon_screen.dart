import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/moodmelt_button.dart';
import '../application/stress_balloon_controller.dart';
import '../domain/microtherapy_session.dart';

class StressBalloonScreen extends ConsumerStatefulWidget {
  const StressBalloonScreen({super.key});

  @override
  ConsumerState<StressBalloonScreen> createState() =>
      _StressBalloonScreenState();
}

class _StressBalloonScreenState extends ConsumerState<StressBalloonScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _thoughtController = TextEditingController();
  late AnimationController _balloonAnimationController;
  late Animation<double> _balloonScale;
  late Animation<double> _balloonOpacity;
  late Animation<Offset> _balloonPosition;

  @override
  void initState() {
    super.initState();
    _balloonAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _balloonScale = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _balloonAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _balloonOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _balloonAnimationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _balloonPosition = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -2),
    ).animate(
      CurvedAnimation(
        parent: _balloonAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _thoughtController.dispose();
    _balloonAnimationController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    ref.read(stressBalloonControllerProvider.notifier).submitThought(
          _thoughtController.text,
        );
    _balloonAnimationController.forward();
  }

  void _reset() {
    ref.read(stressBalloonControllerProvider.notifier).reset();
    _thoughtController.clear();
    _balloonAnimationController.reset();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(stressBalloonControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.primaryPurple),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.softGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title
                Text(
                  'Stress Balloon 🎈',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: AppTheme.primaryPurple,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  'Írd le, ami most feszít belül, és engedd el egy lufival.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black54,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Balloon Animation Area
                if (state.state != StressBalloonState.result)
                  _buildBalloonAnimation(state),

                const SizedBox(height: 40),

                // Input or Result
                if (state.state == StressBalloonState.result)
                  _buildResultCard(state)
                else
                  _buildInputSection(state),

                const SizedBox(height: 24),

                // Action Button
                _buildActionButton(state),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBalloonAnimation(StressBalloonStateModel state) {
    return SizedBox(
      height: 200,
      child: Center(
        child: AnimatedBuilder(
          animation: _balloonAnimationController,
          builder: (context, child) {
            return SlideTransition(
              position: _balloonPosition,
              child: Opacity(
                opacity: _balloonOpacity.value,
                child: Transform.scale(
                  scale: _balloonScale.value *
                      (state.state == StressBalloonState.loading ? 1.1 : 1.0),
                  child: Container(
                    width: 120,
                    height: 160,
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryPurple.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Balloon highlight
                        Positioned(
                          top: 30,
                          left: 30,
                          child: Container(
                            width: 30,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        // Balloon string
                        Positioned(
                          bottom: -30,
                          left: 57,
                          child: Container(
                            width: 2,
                            height: 30,
                            color: Colors.black26,
                          ),
                        ),
                        // Loading indicator
                        if (state.state == StressBalloonState.loading)
                          const Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInputSection(StressBalloonStateModel state) {
    return Column(
      children: [
        TextField(
          controller: _thoughtController,
          maxLines: 5,
          enabled: state.state != StressBalloonState.loading,
          decoration: InputDecoration(
            labelText: 'Mi jár most a fejedben?',
            hintText: 'Írd le a gondolataidat...',
            alignLabelWithHint: true,
            errorText: state.state == StressBalloonState.error
                ? state.errorMessage
                : null,
          ),
          textCapitalization: TextCapitalization.sentences,
        ),
        if (state.state == StressBalloonState.error) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.red.shade700),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    state.errorMessage ?? 'Hiba történt',
                    style: TextStyle(color: Colors.red.shade700),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildResultCard(StressBalloonStateModel state) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.primaryPurple.withOpacity(0.1),
              AppTheme.primaryPink.withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: AppTheme.primaryPurple,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              state.reframedText ?? '',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.secondaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.favorite,
                    color: AppTheme.primaryPink,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Ezt bármikor megteheted. Nem vagy egyedül.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.black87,
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(StressBalloonStateModel state) {
    if (state.state == StressBalloonState.result) {
      return MoodMeltButton(
        text: 'Újra próbálom',
        onPressed: _reset,
        isGradient: false,
        icon: Icons.refresh,
      );
    }

    return MoodMeltButton(
      text: 'Engedd el',
      onPressed: _handleSubmit,
      isLoading: state.state == StressBalloonState.loading,
      icon: Icons.send,
    );
  }
}
