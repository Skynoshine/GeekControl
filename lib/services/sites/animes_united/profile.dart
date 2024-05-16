import 'package:flutter/material.dart';

class FitnessProfileApp extends StatelessWidget {
  const FitnessProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FitnessProfileScreen(),
    );
  }
}

class FitnessProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A2B34),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.arrow_back, color: Colors.white),
              const SizedBox(height: 16.0),
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      NetworkImage('https://via.placeholder.com/150'),
                ),
              ),
              const SizedBox(height: 16.0),
              const Center(
                child: Column(
                  children: [
                    Text(
                      'Welcome back,',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      'Alisha!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Montreal, CA. Female. 30s',
                      style: TextStyle(color: Colors.white54, fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatCard('491', 'workout', Icons.fitness_center),
                  _buildStatCard(
                      '84k', 'calories', Icons.local_fire_department),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatCard('16.1k', 'minutes', Icons.timer),
                  _buildStatCard('59', 'kilograms', Icons.monitor_weight),
                ],
              ),
              const SizedBox(height: 24.0),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8E1A3),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Steps',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildStepPeriod('day', true),
                            _buildStepPeriod('week', false),
                            _buildStepPeriod('month', false),
                            _buildStepPeriod('year', false),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: _buildStepGraph(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF6B9D9B),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(height: 8.0),
          Text(
            value,
            style: const TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.white54, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildStepPeriod(String period, bool isSelected) {
    return Text(
      period,
      style: TextStyle(
        fontSize: 16,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildStepGraph() {
    return Container(
      color: Colors.black,
      // Placeholder for the step graph. Implement your own custom graph here.
    );
  }
}
