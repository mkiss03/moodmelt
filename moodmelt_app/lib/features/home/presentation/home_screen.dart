import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/mood_slider.dart';
import '../../../routes/app_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _currentMood = 3.0;

  final List<MicroTherapyModule> _modules = [
    MicroTherapyModule(
      id: 'stress-balloon',
      title: 'Stress Balloon',
      description: 'Engedd el a stresszt egy lufival',
      icon: '🎈',
      route: AppRouter.stressBalloon,
      gradient: const LinearGradient(
        colors: [Color(0xFFA855F7), Color(0xFFEC4899)],
      ),
    ),
    MicroTherapyModule(
      id: 'thought-tornado',
      title: 'Thought Tornado',
      description: 'Dobd el a negatív gondolatokat',
      icon: '🌪️',
      route: AppRouter.thoughtTornado,
      gradient: const LinearGradient(
        colors: [Color(0xFF38BDF8), Color(0xFF0EA5E9)],
      ),
    ),
    MicroTherapyModule(
      id: 'mind-declutter',
      title: 'Mind Declutter',
      description: 'Mentális rendrakás',
      icon: '🧹',
      route: AppRouter.mindDeclutter,
      gradient: const LinearGradient(
        colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
      ),
    ),
    MicroTherapyModule(
      id: 'box-breathing',
      title: 'Box Breathing Melt',
      description: 'Nyugtató légzőgyakorlat',
      icon: '🧘',
      route: AppRouter.boxBreathing,
      gradient: const LinearGradient(
        colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.softGradient,
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // App Bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Szia! 👋',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              color: AppTheme.primaryPurple,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Hogy vagy ma?',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: Colors.black54,
                            ),
                      ),
                    ],
                  ),
                ),
              ),

              // Mood Slider Card
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: MoodSlider(
                        initialValue: _currentMood,
                        onMoodChanged: (value) {
                          setState(() {
                            _currentMood = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // Recommended Module
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ma kipróbálhatod',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: AppTheme.primaryPurple,
                            ),
                      ),
                      const SizedBox(height: 16),
                      _buildRecommendedModuleCard(_modules[0]),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // All Modules
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Összes gyakorlat',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppTheme.primaryPurple,
                        ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // Module Grid
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return _buildModuleCard(_modules[index]);
                    },
                    childCount: _modules.length,
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendedModuleCard(MicroTherapyModule module) {
    return InkWell(
      onTap: () => context.push(module.route),
      child: Container(
        decoration: BoxDecoration(
          gradient: module.gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryPurple.withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Text(
              module.icon,
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    module.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    module.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleCard(MicroTherapyModule module) {
    return InkWell(
      onTap: () => context.push(module.route),
      child: Container(
        decoration: BoxDecoration(
          gradient: module.gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              module.icon,
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 12),
            Text(
              module.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              module.description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class MicroTherapyModule {
  final String id;
  final String title;
  final String description;
  final String icon;
  final String route;
  final Gradient gradient;

  MicroTherapyModule({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.route,
    required this.gradient,
  });
}
