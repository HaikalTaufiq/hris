import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  // Contoh controller untuk text field (kalau mau simpan input)
  final TextEditingController _nameController =
      TextEditingController(text: "John Doe");
  final TextEditingController _emailController =
      TextEditingController(text: "john@example.com");
  final TextEditingController _phoneController =
      TextEditingController(text: "+62 8123456789");
  final TextEditingController _addressController =
      TextEditingController(text: "Jl. Contoh No. 123");

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = MediaQuery.of(context).size.width * 0.04;
    final double verticalPadding = MediaQuery.of(context).size.height * 0.01;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage(
                          'assets/images/profile_placeholder.png'), // Ganti dengan foto profile asli
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      // Tambahkan fungsi untuk edit foto profil di sini
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Edit foto profil clicked')),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child:
                          const Icon(Icons.edit, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildTextField(label: "Nama", controller: _nameController),
            const SizedBox(height: 20),
            _buildTextField(
                label: "Email",
                controller: _emailController,
                keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 20),
            _buildTextField(
                label: "No. Telepon",
                controller: _phoneController,
                keyboardType: TextInputType.phone),
            const SizedBox(height: 20),
            _buildTextField(
                label: "Alamat", controller: _addressController, maxLines: 3),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: handle submit
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1F1F1F),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.putih,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: TextStyle(color: AppColors.putih),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.secondary,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
