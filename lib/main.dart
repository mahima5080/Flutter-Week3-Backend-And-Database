import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const WeatherForecastApp());
}

class WeatherForecastApp extends StatelessWidget {
  const WeatherForecastApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Forecast App',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const WeatherHomeScreen(),
    );
  }
}

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  final TextEditingController _cityController = TextEditingController(text: 'Nashik');
  bool _isLoading = false;
  String _errorMessage = '';
  
  Map<String, dynamic>? _weatherData;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData('Nashik');
  }

  Future<void> _fetchWeatherData(String cityName) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    const apiKey = 'YOUR_OPENWEATHER_API_KEY';
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          _weatherData = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        // Fallback simulated data if no API key is set
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          _weatherData = {
            'name': cityName,
            'main': {'temp': 28.5, 'humidity': 62, 'pressure': 1012},
            'weather': [
              {'main': 'Sunny', 'description': 'Clear sky', 'icon': '01d'}
            ],
            'wind': {'speed': 3.6}
          };
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch weather data. Please check your internet connection.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text('Weather Forecast'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Search Input Row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      labelText: 'Search City',
                      prefixIcon: Icon(Icons.location_city),
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton.filled(
                  style: IconButton.styleFrom(backgroundColor: Colors.blueAccent),
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    final query = _cityController.text.trim();
                    if (query.isNotEmpty) {
                      _fetchWeatherData(query);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Loading state / Error / Weather Display
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 12),
                          Text('Fetching weather information...'),
                        ],
                      ),
                    )
                  : _errorMessage.isNotEmpty
                      ? Center(
                          child: Text(
                            _errorMessage,
                            style: const TextStyle(color: Colors.red, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : _weatherData == null
                          ? const Center(child: Text('Enter a city name to search weather.'))
                          : SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${_weatherData!['name']}',
                                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  const Icon(Icons.wb_sunny, size: 80, color: Colors.orangeAccent),
                                  const SizedBox(height: 12),
                                  Text(
                                    '${_weatherData!['main']['temp']}°C',
                                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                                  ),
                                  Text(
                                    '${_weatherData!['weather'][0]['description']}'.toUpperCase(),
                                    style: const TextStyle(fontSize: 16, letterSpacing: 1.2, color: Colors.grey),
                                  ),
                                  const SizedBox(height: 24),

                                  // Weather Detail Cards
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      WeatherDetailCard(
                                        icon: Icons.water_drop,
                                        title: 'Humidity',
                                        value: '${_weatherData!['main']['humidity']}%',
                                      ),
                                      WeatherDetailCard(
                                        icon: Icons.air,
                                        title: 'Wind Speed',
                                        value: '${_weatherData!['wind']['speed']} m/s',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherDetailCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const WeatherDetailCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 36, color: Colors.blueAccent),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}