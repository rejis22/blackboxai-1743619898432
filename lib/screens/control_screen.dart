import 'package:flutter/material.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key});

  @override
  _ControlScreenState createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  double _speed = 0.0;
  bool _isRunning = false;
  bool _highBeam = false;
  bool _lowBeam = false;
  bool _leftIndicator = false;
  bool _rightIndicator = false;
  bool _brakeLight = false;

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Widget _buildControlButton(
      String label, IconData icon, bool isActive, VoidCallback onPressed) {
    return Card(
      color: isActive ? Colors.blue[100] : null,
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: isActive ? Colors.blue : Colors.grey),
            const SizedBox(height: 8),
            Text(label),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Control'),
        actions: [
          IconButton(
            icon: Icon(_isRunning ? Icons.stop : Icons.play_arrow),
            onPressed: () {
              setState(() {
                _isRunning = !_isRunning;
                _speed = _isRunning ? 45.0 : 0.0;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Current Speed',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '${_speed.toStringAsFixed(1)} km/h',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16.0),
              childAspectRatio: 1.5,
              children: [
                _buildControlButton(
                  'High Beam',
                  Icons.highlight,
                  _highBeam,
                  () => setState(() => _highBeam = !_highBeam),
                ),
                _buildControlButton(
                  'Low Beam',
                  Icons.light_mode,
                  _lowBeam,
                  () => setState(() => _lowBeam = !_lowBeam),
                ),
                _buildControlButton(
                  'Single Wipe',
                  Icons.clean_hands,
                  false,
                  () => _showToast(context, 'Single wipe activated'),
                ),
                _buildControlButton(
                  'Continuous Wipe',
                  Icons.water_drop,
                  false,
                  () => _showToast(context, 'Continuous wipe activated'),
                ),
                _buildControlButton(
                  'Left Indicator',
                  Icons.turn_left,
                  _leftIndicator,
                  () => setState(() {
                    _leftIndicator = !_leftIndicator;
                    if (_leftIndicator) _rightIndicator = false;
                  }),
                ),
                _buildControlButton(
                  'Right Indicator',
                  Icons.turn_right,
                  _rightIndicator,
                  () => setState(() {
                    _rightIndicator = !_rightIndicator;
                    if (_rightIndicator) _leftIndicator = false;
                  }),
                ),
                _buildControlButton(
                  'Brake Light',
                  Icons.car_crash,
                  _brakeLight,
                  () => setState(() => _brakeLight = !_brakeLight),
                ),
                _buildControlButton(
                  'Open Bonnet',
                  Icons.car_repair,
                  false,
                  () => _showToast(context, 'Bonnet opened'),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.red,
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                setState(() {
                  _isRunning = false;
                  _speed = 0.0;
                  _highBeam = false;
                  _lowBeam = false;
                  _leftIndicator = false;
                  _rightIndicator = false;
                  _brakeLight = false;
                });
                _showToast(context, 'EMERGENCY STOP ACTIVATED');
              },
              child: const Text(
                'EMERGENCY STOP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}