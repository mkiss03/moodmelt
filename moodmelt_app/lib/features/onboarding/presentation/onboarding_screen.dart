import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/moodmelt_button.dart';
import '../../../routes/app_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  String? _selectedGoal;
  double _overloadLevel = 3.0;

  final List<String> _goals = [
    '😌 Kevesebb stresszt szeretnék',
    '💭 Szorongás kezelése',
    '😴 Jobb alvás',
    '🧘 Nyugodtabb napokat',
  ];

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to home
      context.go(AppRouter.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.softGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Progress indicator
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: List.generate(3, (index) {
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 4,
                        decoration: BoxDecoration(
                          color: index <= _currentPage
                              ? AppTheme.primaryPurple
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              // PageView
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    _buildWelcomePage(),
                    _buildGoalSelectionPage(),
                    _buildOverloadLevelPage(),
                  ],
                ),
              ),

              // Bottom button
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: MoodMeltButton(
                  text: _currentPage == 2 ? 'Kezdjük' : 'Tovább',
                  onPressed: _canProceed() ? _nextPage : () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _canProceed() {
    if (_currentPage == 0) return true;
    if (_currentPage == 1) return _selectedGoal != null;
    return true;
  }

  Widget _buildWelcomePage() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo placeholder (melting drop)
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryPurple.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                '💧',
                style: TextStyle(fontSize: 60),
              ),
            ),
          ),
          const SizedBox(height: 40),

          Text(
            'Üdv a MoodMelt-ben 👋',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppTheme.primaryPurple,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          Text(
            'Itt 1–3 perces mini gyakorlatokkal tudod leolvasztani a napi feszültséget.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.black54,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          Text(
            'Melt away your stress in 2 minutes.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.primaryPink,
                  fontStyle: FontStyle.italic,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildGoalSelectionPage() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Miben segíthetünk leginkább?',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppTheme.primaryPurple,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),

          ..._goals.map((goal) {
            final isSelected = _selectedGoal == goal;
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedGoal = goal;
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: isSelected ? AppTheme.primaryGradient : null,
                    color: isSelected ? null : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : Colors.grey.shade200,
                      width: 2,
                    ),
                    boxShadow: [
                      if (isSelected)
                        BoxShadow(
                          color: AppTheme.primaryPurple.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                    ],
                  ),
                  child: Text(
                    goal,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildOverloadLevelPage() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Mennyire érzed magad most túlterheltnek?',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppTheme.primaryPurple,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),

          // Slider
          Column(
            children: [
              Text(
                _overloadLevel.round().toString(),
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: AppTheme.primaryPink,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: AppTheme.primaryPurple,
                  inactiveTrackColor: Colors.grey.shade200,
                  thumbColor: AppTheme.primaryPink,
                  overlayColor: AppTheme.primaryPink.withOpacity(0.2),
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 16,
                  ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 28,
                  ),
                ),
                child: Slider(
                  value: _overloadLevel,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  onChanged: (value) {
                    setState(() {
                      _overloadLevel = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Semmi gond',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    'Nagyon túlterhelt',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 60),

          Text(
            'Ez segít nekünk a legjobb gyakorlatokat ajánlani.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black54,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
