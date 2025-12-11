import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MoodSlider extends StatefulWidget {
  final Function(double) onMoodChanged;
  final double initialValue;

  const MoodSlider({
    super.key,
    required this.onMoodChanged,
    this.initialValue = 3.0,
  });

  @override
  State<MoodSlider> createState() => _MoodSliderState();
}

class _MoodSliderState extends State<MoodSlider> {
  late double _currentValue;

  final List<String> _moodEmojis = ['😢', '😕', '😐', '🙂', '😊'];
  final List<String> _moodLabels = [
    'Nagyon rosszul',
    'Rosszul',
    'Semleges',
    'Jól',
    'Nagyon jól'
  ];

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final int moodIndex = (_currentValue - 1).round();

    return Column(
      children: [
        // Emoji Display
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Text(
            _moodEmojis[moodIndex],
            key: ValueKey<int>(moodIndex),
            style: const TextStyle(fontSize: 72),
          ),
        ),
        const SizedBox(height: 16),

        // Mood Label
        Text(
          _moodLabels[moodIndex],
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.primaryPurple,
              ),
        ),
        const SizedBox(height: 24),

        // Slider
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppTheme.primaryPurple,
            inactiveTrackColor: Colors.grey.shade200,
            thumbColor: AppTheme.primaryPink,
            overlayColor: AppTheme.primaryPink.withOpacity(0.2),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
          ),
          child: Slider(
            value: _currentValue,
            min: 1,
            max: 5,
            divisions: 4,
            onChanged: (value) {
              setState(() {
                _currentValue = value;
              });
              widget.onMoodChanged(value);
            },
          ),
        ),
      ],
    );
  }
}
