import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil Saya',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F766E),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F8F7),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF6F8F7),
          foregroundColor: Color(0xFF173B38),
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE0E9E6)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF0F766E), width: 1.5),
          ),
        ),
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _nameController = TextEditingController();
  final _picker = ImagePicker();
  Uint8List? _profileImageBytes;
  bool _isEditing = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (pickedFile == null || !mounted) return;

    final imageBytes = await pickedFile.readAsBytes();
    if (!mounted) return;

    setState(() => _profileImageBytes = imageBytes);
  }

  void _saveProfile() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama tidak boleh kosong')),
      );
      return;
    }

    setState(() {
      _nameController.text = name;
      _isEditing = false;
    });
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil berhasil disimpan')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil Saya',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () => setState(() => _isEditing = !_isEditing),
            tooltip: _isEditing ? 'Batal mengedit' : 'Edit profil',
            icon: Icon(_isEditing ? Icons.close : Icons.edit_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundColor: const Color(0xFFD8EEEA),
                    backgroundImage: _profileImageBytes == null
                        ? null
                        : MemoryImage(_profileImageBytes!),
                    child: _profileImageBytes == null
                        ? const Icon(
                            Icons.person_outline,
                            size: 68,
                            color: Color(0xFF0F766E),
                          )
                        : null,
                  ),
                  Material(
                    color: const Color(0xFF0F766E),
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: _pickImage,
                      customBorder: const CircleBorder(),
                      child: const Padding(
                        padding: EdgeInsets.all(11),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 21,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Center(
              child: Text(
                'Ketuk ikon kamera untuk mengganti foto',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF6B7F7B),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Informasi pribadi',
              style: theme.textTheme.titleMedium?.copyWith(
                color: const Color(0xFF173B38),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _nameController,
              enabled: _isEditing,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Nama lengkap',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 14),
            const TextField(
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'sapaaja@email.com',
                prefixIcon: Icon(Icons.mail_outline),
              ),
            ),
            if (_isEditing)
              Column(
                children: [
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _saveProfile,
                      icon: const Icon(Icons.check),
                      label: const Text('Simpan perubahan'),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF0F766E),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
