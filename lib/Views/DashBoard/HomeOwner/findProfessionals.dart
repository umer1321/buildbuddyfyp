import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class FindProfessionalsDashboard extends StatefulWidget {
  const FindProfessionalsDashboard({super.key});

  @override
  State<FindProfessionalsDashboard> createState() =>
      _FindProfessionalsDashboardState();
}

class _FindProfessionalsDashboardState
    extends State<FindProfessionalsDashboard> {
  String selectedProfession = '';
  String userLocation = 'Faisalabad, Punjab';
  Position? _currentPosition;
  LatLng _selectedLocation = LatLng(31.4504, 73.1350);
  bool isSearching = false;
  TextEditingController _searchController = TextEditingController();

  final Map<String, List<Professional>> professionals = {
    'Architects': [
      Professional(name: 'John Doe', role: 'Architect', rating: 4.5),
      Professional(name: 'Alice Green', role: 'Architect', rating: 4.7),
    ],
    'Contractors': [
      Professional(name: 'Jane Smith', role: 'Contractor', rating: 4.8),
      Professional(name: 'Robert Brown', role: 'Contractor', rating: 4.6),
    ],
  };

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, cannot request permissions.');
    }

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _selectedLocation = LatLng(position.latitude, position.longitude);
      _updateUserLocation(position.latitude, position.longitude);
    });
  }

  Future<void> _updateUserLocation(double latitude, double longitude) async {
    try {
      // Convert latitude and longitude to a human-readable address
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      setState(() {
        userLocation = "${place.locality}, ${place.administrativeArea}"; // Format address
      });
    } catch (e) {
      print("Error fetching address: $e");
    }
  }

  Future<void> _onMapTap(LatLng location) async {
    setState(() {
      _selectedLocation = location;
      _updateUserLocation(location.latitude, location.longitude);
    });
  }
  void _searchLocation(String query) {
    setState(() {
      userLocation = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Professionals'),
        backgroundColor: const Color(0xFF2196F3),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildLocationHeader(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildProfessionCard(
                  title: 'Architects',
                  icon: Icons.architecture,
                  color: Colors.blue,
                  onTap: () {
                    setState(() {
                      selectedProfession = 'Architects';
                    });
                  },
                ),
                _buildProfessionCard(
                  title: 'Contractors',
                  icon: Icons.engineering,
                  color: Colors.orange,
                  onTap: () {
                    setState(() {
                      selectedProfession = 'Contractors';
                    });
                  },
                ),
              ],
            ),
          ),
          _buildMap(),
          if (selectedProfession.isNotEmpty)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  itemCount: professionals[selectedProfession]?.length ?? 0,
                  itemBuilder: (context, index) {
                    final professional =
                    professionals[selectedProfession]![index];
                    return ProfessionalCard(
                      name: professional.name,
                      role: professional.role,
                      rating: professional.rating,
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLocationHeader() {
    return Container(
      color: Colors.blueGrey.withOpacity(0.1),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.redAccent),
          const SizedBox(width: 8),
          Expanded(
            //
            child: isSearching
                ? TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search Location...",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _searchLocation(_searchController.text);
                    setState(() {
                      isSearching = false; // Close search bar after search
                    });
                  },
                ),
              ),
            )

            ////
            : Text(
              userLocation,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          /////
          if (!isSearching)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  isSearching = true;
                });
              },
            ),
///////
          TextButton(
            onPressed: _getCurrentLocation,
            child: const Text(
              "Use Current Location",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.6), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(icon, size: 32, color: color),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMap() {
    return SizedBox(
      height: 300,
      child: FlutterMap(
        options: MapOptions(
          center: _selectedLocation,
          zoom: 13.0,
          onTap: (tapPosition, point) => _onMapTap(point),
        ),


children: [
          TileLayer(
            urlTemplate:
            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: _selectedLocation,
                builder: (ctx) => const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfessionalCard extends StatelessWidget {
  final String name;
  final String role;
  final double rating;

  const ProfessionalCard(
      {required this.name, required this.role, required this.rating, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Text(name[0], style: const TextStyle(color: Colors.white)),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(role),
        trailing:
        Text('$rating⭐', style: const TextStyle(color: Colors.orange)),
      ),
    );
  }
}

class Professional {
  final String name;
  final String role;
  final double rating;

  Professional({required this.name, required this.role, required this.rating});
}














/*
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class FindProfessionalsDashboard extends StatefulWidget {
  const FindProfessionalsDashboard({super.key});

  @override
  State<FindProfessionalsDashboard> createState() =>
      _FindProfessionalsDashboardState();
}

class _FindProfessionalsDashboardState
    extends State<FindProfessionalsDashboard> {
  String selectedProfession = '';
  String userLocation = 'Faisalabad, Pakistan';
  Position? _currentPosition;
  LatLng _selectedLocation = LatLng(31.4504, 73.1350);


  final Map<String, List<Professional>> professionals = {
    'Architects': [
      Professional(name: 'John Doe', role: 'Architect', rating: 4.5),
      Professional(name: 'Alice Green', role: 'Architect', rating: 4.7),
    ],
    'Contractors': [
      Professional(name: 'Jane Smith', role: 'Contractor', rating: 4.8),
      Professional(name: 'Robert Brown', role: 'Contractor', rating: 4.6),
    ],
  };

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, cannot request permissions.');
    }

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _selectedLocation = LatLng(position.latitude, position.longitude);
      userLocation =
      "Current Location: ${position.latitude}, ${position.longitude}";
    });
  }

  Future<void> _onMapTap(LatLng location) async {
    setState(() {
      _selectedLocation = location;
      userLocation =
      "Location Selected: ${location.latitude}, ${location.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Professionals'),
        backgroundColor: const Color(0xFF2196F3),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildLocationHeader(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildProfessionCard(
                  title: 'Architects',
                  icon: Icons.architecture,
                  color: Colors.blue,
                  onTap: () {
                    setState(() {
                      selectedProfession = 'Architects';
                    });
                  },
                ),
                _buildProfessionCard(
                  title: 'Contractors',
                  icon: Icons.engineering,
                  color: Colors.orange,
                  onTap: () {
                    setState(() {
                      selectedProfession = 'Contractors';
                    });
                  },
                ),
              ],
            ),
          ),
          _buildMap(),
          if (selectedProfession.isNotEmpty)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  itemCount: professionals[selectedProfession]?.length ?? 0,
                  itemBuilder: (context, index) {
                    final professional =
                    professionals[selectedProfession]![index];
                    return ProfessionalCard(
                      name: professional.name,
                      role: professional.role,
                      rating: professional.rating,
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLocationHeader() {
    return Container(
      color: Colors.blueGrey.withOpacity(0.1),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.redAccent),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              userLocation,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          TextButton(
            onPressed: _getCurrentLocation,
            child: const Text(
              "Use Current Location",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.6), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(icon, size: 32, color: color),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMap() {
    return SizedBox(
      height: 300,
      child: FlutterMap(
        options: MapOptions(
          center: _selectedLocation,
          zoom: 13.0,
          onTap: (tapPosition, point) => _onMapTap(point),
        ),
        children: [
          TileLayer(
            urlTemplate:
            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: _selectedLocation,
                builder: (ctx) => const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfessionalCard extends StatelessWidget {
  final String name;
  final String role;
  final double rating;

  const ProfessionalCard(
      {required this.name, required this.role, required this.rating, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Text(name[0], style: const TextStyle(color: Colors.white)),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(role),
        trailing:
        Text('$rating⭐', style: const TextStyle(color: Colors.orange)),
      ),
    );
  }
}

class Professional {
  final String name;
  final String role;
  final double rating;

  Professional({required this.name, required this.role, required this.rating});
}
*/


































