import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
// ignore: unused_import
import 'package:permission_handler/permission_handler.dart';
import 'interests_screen.dart';
import '../utils/progress_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ProgressController().updateCurrentStep(1);
  }

  bool _isLoadingLocation = false;
  File? _selectedImage;
  Uint8List? _webImage;

  Future<String?> getCityFromGoogleAPI(double lat, double lng) async {
    const apiKey = 'AIzaSyBBRhGhiWrdklJ_QjTvwQLw4U9q_nAU5PQ';

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['status'] == 'OK') {
        final results = data['results'];
        if (results != null && results.isNotEmpty) {
          for (var result in results) {
            for (var component in result['address_components']) {
              final types = List<String>.from(component['types']);
              if (types.contains('locality') ||
                  types.contains('administrative_area_level_2') ||
                  types.contains('administrative_area_level_1')) {
                return component['long_name'];
              }
            }
          }
        }
      } else {
        print("Google API error: ${data['status']}");
      }
    } else {
      print("Failed to fetch from API. Code: ${response.statusCode}");
    }

    return null;
  }

  Future<void> _fetchLocationAndCity() async {
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      print("Checking location service...");
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showSnack("Please enable location services in device settings");
        return;
      }

      print("Checking permission...");
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showSnack("Location permission is required. Please grant it.");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showSnack(
          "Location permission permanently denied. Enable it in settings.",
        );
        return;
      }

      print("Getting position...");
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        timeLimit: const Duration(seconds: 20),
      );

      print("Got location: ${position.latitude}, ${position.longitude}");

      print("Calling Google Maps Geocoding API...");
      String? city = await getCityFromGoogleAPI(
        position.latitude,
        position.longitude,
      );

      if (mounted) {
        if (city != null) {
          setState(() {
            _cityController.text = city;
          });
          _showSnack("Location detected: $city");
        } else {
          _showSnack("Location found, but city name unavailable.");
        }
      }
    } on TimeoutException {
      _showSnack("Location request timed out. Try again.");
    } on LocationServiceDisabledException {
      _showSnack("Location services are disabled.");
    } catch (e, stack) {
      print("Error fetching location: $e");
      print("Stack: $stack");

      _showSnack("Error fetching location. Try manually.");
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingLocation = false;
        });
      }
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 177, 177, 177),
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              // padding: const EdgeInsets.fromLTRB(16, 40, 16, 20),
              width: double.infinity,
              child: Center(
                child: Text(
                  "Recofrend",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Chip(
                      labelPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      avatar: Icon(
                        Icons.access_time,
                        color: Colors.grey,
                        size: 20,
                      ),
                      label: Text(
                        "Takes less than a minute",
                        style: TextStyle(color: Colors.black87),
                      ),
                      backgroundColor: Color(0xFFF1F3F6),
                      shape: StadiumBorder(),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        LinearProgressIndicator(
                          value:
                              ProgressController().progress.currentStep /
                              ProgressController().progress.totalSteps,
                          minHeight: 7,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.lightBlue,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Start", style: TextStyle(fontSize: 14)),
                            Text("Finish", style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Personal Information",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: kIsWeb && _webImage != null
                          ? MemoryImage(_webImage!)
                          : (_selectedImage != null
                                ? FileImage(_selectedImage!)
                                : null),
                      child: (_selectedImage == null && _webImage == null)
                          ? Icon(Icons.person, size: 40, color: Colors.white)
                          : null,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          final picker = ImagePicker();
                          final picked = await picker.pickImage(
                            source: ImageSource.gallery,
                          );

                          if (picked != null) {
                            if (kIsWeb) {
                              final bytes = await picked.readAsBytes();
                              setState(() {
                                _webImage = bytes;
                              });
                            } else {
                              setState(() {
                                _selectedImage = File(picked.path);
                              });
                            }
                          }
                        },

                        icon: Icon(Icons.upload),
                        label: Text("Upload Photo"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 1,
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Coming Soon')),
                          );
                        },
                        icon: Icon(Icons.person),
                        label: Text("Generate Avatar"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 1,
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Display Name*",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _nameController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Display name is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "How should we call you?",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Email (optional)",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Your email address",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 20),
                            const SizedBox(width: 5),
                            const Text(
                              "Age (optional)",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            hintText: "Your age",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person),
                            const SizedBox(width: 5),
                            const Text(
                              "Sex (optional)",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          hint: Text("Select your sex"),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                          ),
                          dropdownColor: Colors.white,
                          items:
                              [
                                'Prefer not to say',
                                'Male',
                                'Female',
                                'Other',
                              ].map((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                          onChanged: (newValue) {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            const SizedBox(width: 5),
                            const Text(
                              "Location (optional)",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: TextField(
                                controller: _cityController,
                                decoration: InputDecoration(
                                  hintText: "Your Location",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton.icon(
                                onPressed: _isLoadingLocation
                                    ? null
                                    : _fetchLocationAndCity,
                                label: _isLoadingLocation
                                    ? SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.black,
                                              ),
                                        ),
                                      )
                                    : Icon(Icons.location_on_outlined),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 18),
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Bio (optional)",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          minLines: 4,
                          maxLines: 8,
                          decoration: InputDecoration(
                            hintText: "Tell us a bit about yourself",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const SizedBox(height: ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(219, 198, 227, 242),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color.fromARGB(255, 167, 188, 237),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Image(
                                image: AssetImage('assets/bulb.png'),
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  'Adding more information helps us provide more relevant and personalized recommendations just for you!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 23, 129, 250),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const InterestsScreen(),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text('Next'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
