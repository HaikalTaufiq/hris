// ignore_for_file: avoid_print, prefer_final_fields, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/components/custom/custom_dropdown.dart';
import 'package:hr/components/custom/custom_input.dart';
import 'package:hr/core/helpers/notification_helper.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/data/models/departemen_model.dart';
import 'package:hr/data/models/user_model.dart';
import 'package:hr/data/services/departemen_service.dart';
import 'package:hr/data/services/user_service.dart';
import 'package:hr/provider/tugas_provider.dart';
import 'package:provider/provider.dart';

class TugasInput extends StatefulWidget {
  const TugasInput({super.key});

  @override
  State<TugasInput> createState() => _TugasInputState();
}

class _TugasInputState extends State<TugasInput> {
  final TextEditingController _tanggalMulaiController = TextEditingController();
  final TextEditingController _tanggalSelesaiController =
      TextEditingController();
  final TextEditingController _jamMulaiController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _judulTugasController = TextEditingController();

  String? _assignmentMode;
  UserModel? _selectedUser;
  DepartemenModel? _selectedDepartment;
  List<UserModel> _userList = [];
  List<DepartemenModel> _departemenList = [];
  bool _isLoadingUser = true;
  bool _isLoadingDepartemen = true;

  @override
  void initState() {
    super.initState();
    _loadDepartemen();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    try {
      final userData = await UserService.fetchUsers();
      if (mounted) {
        setState(() {
          _userList = userData;
          _isLoadingUser = false;
        });
      }
    } catch (e) {
      print("Error fetch users: $e");
      if (mounted) {
        setState(() => _isLoadingUser = false);
      }
    }
  }

  Future<void> _loadDepartemen() async {
    try {
      final departemenData = await DepartemenService.fetchDepartemen();
      if (mounted) {
        setState(() {
          _departemenList = departemenData;
          _isLoadingDepartemen = false;
        });
      }
    } catch (e) {
      print("Error fetch departemen: $e");
      if (mounted) {
        setState(() => _isLoadingDepartemen = false);
      }
    }
  }

  void _onTapIconTime(TextEditingController controller) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null && mounted) {
      controller.text = pickedTime.format(context);
    }
  }

  void _onTapIconDate(TextEditingController controller) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && mounted) {
      controller.text =
          "${pickedDate.day.toString().padLeft(2, '0')} / ${pickedDate.month.toString().padLeft(2, '0')} / ${pickedDate.year}";
    }
  }

  Future<void> _handleSubmit() async {
    // Validate required fields
    if (_judulTugasController.text.isEmpty ||
        _jamMulaiController.text.isEmpty ||
        _tanggalMulaiController.text.isEmpty ||
        _tanggalSelesaiController.text.isEmpty ||
        _assignmentMode == null ||
        _lokasiController.text.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Harap isi semua data wajib")),
        );
      }
      return;
    }

    // Validate assignment selection
    if (_assignmentMode == "Per Orang" && _selectedUser == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pilih karyawan terlebih dahulu")),
        );
      }
      return;
    }

    if (_assignmentMode == "Per Departemen" && _selectedDepartment == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pilih departemen terlebih dahulu")),
        );
      }
      return;
    }

    try {
      final tugasProvider = context.read<TugasProvider>();

      final result = await tugasProvider.createTugas(
        judul: _judulTugasController.text,
        jamMulai: _jamMulaiController.text,
        tanggalMulai: _tanggalMulaiController.text,
        tanggalSelesai: _tanggalSelesaiController.text,
        assignmentMode: _assignmentMode!,
        person: _assignmentMode == "Per Orang" ? _selectedUser?.id : null,
        departmentId: _assignmentMode == "Per Departemen"
            ? _selectedDepartment?.id
            : null,
        lokasi: _lokasiController.text,
        note: _noteController.text,
      );

      if (!mounted) return;

      final bool isSuccess = result['success'] == true;
      final String message = result['message'] ?? '';

      NotificationHelper.showSnackBar(
        context,
        message,
        isSuccess: isSuccess,
      );

      if (isSuccess) {
        // Clear form after successful submission
        _judulTugasController.clear();
        _jamMulaiController.clear();
        _tanggalMulaiController.clear();
        _tanggalSelesaiController.clear();
        _lokasiController.clear();
        _noteController.clear();

        setState(() {
          _assignmentMode = null;
          _selectedUser = null;
          _selectedDepartment = null;
        });

        // Navigate back with success result
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        NotificationHelper.showSnackBar(
          context,
          'Terjadi kesalahan: $e',
          isSuccess: false,
        );
      }
    }
  }

  @override
  void dispose() {
    _tanggalMulaiController.dispose();
    _tanggalSelesaiController.dispose();
    _jamMulaiController.dispose();
    _lokasiController.dispose();
    _noteController.dispose();
    _judulTugasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use Consumer to properly watch the provider
    final tugasProvider = context.read<TugasProvider>();

    final isLoading = tugasProvider.isLoading;

    final inputStyle = InputDecoration(
      hintStyle: TextStyle(color: AppColors.putih),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.grey),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.putih),
      ),
    );

    final labelStyle = GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      color: AppColors.putih,
      fontSize: 16,
    );

    final textStyle = GoogleFonts.poppins(
      color: AppColors.putih,
      fontSize: 14,
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Fix the expanding issue
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomInputField(
            label: "Judul Tugas",
            hint: "",
            controller: _judulTugasController,
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "Jam Mulai",
            hint: "--:--",
            controller: _jamMulaiController,
            suffixIcon: Icon(Icons.access_time, color: AppColors.putih),
            onTapIcon: () => _onTapIconTime(_jamMulaiController),
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "Tanggal Mulai",
            hint: "dd / mm / yyyy",
            controller: _tanggalMulaiController,
            suffixIcon: Icon(Icons.calendar_today, color: AppColors.putih),
            onTapIcon: () => _onTapIconDate(_tanggalMulaiController),
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "Batas Tanggal Penyelesaian",
            hint: "dd / mm / yyyy",
            controller: _tanggalSelesaiController,
            suffixIcon: Icon(Icons.calendar_today, color: AppColors.putih),
            onTapIcon: () => _onTapIconDate(_tanggalSelesaiController),
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomDropDownField(
            label: 'Tipe Penugasan',
            hint: 'Pilih tipe penugasan',
            items: ['Per Orang', 'Per Departemen'],
            value: _assignmentMode,
            onChanged: (val) {
              setState(() {
                _assignmentMode = val!;
                _selectedUser = null;
                _selectedDepartment = null;
              });
            },
            labelStyle: labelStyle,
            textStyle: textStyle,
            dropdownColor: AppColors.secondary,
            dropdownTextColor: AppColors.putih,
            dropdownIconColor: AppColors.putih,
            inputStyle: inputStyle,
          ),
          const SizedBox(height: 10),
          if (_assignmentMode == 'Per Orang')
            _isLoadingUser
                ? const Center(child: CircularProgressIndicator())
                : CustomDropDownField(
                    label: 'Karyawan',
                    hint: 'Pilih user',
                    items: _userList
                        .map((user) => user.nama)
                        .where((name) => name.isNotEmpty)
                        .toList(),
                    value: _selectedUser?.nama,
                    onChanged: (val) {
                      setState(() {
                        _selectedUser = _userList.firstWhere(
                          (user) => user.nama == val,
                          orElse: () => _userList.first,
                        );
                      });
                    },
                    labelStyle: labelStyle,
                    textStyle: textStyle,
                    dropdownColor: AppColors.secondary,
                    dropdownTextColor: AppColors.putih,
                    dropdownIconColor: AppColors.putih,
                    inputStyle: inputStyle,
                  )
          else if (_assignmentMode == 'Per Departemen')
            _isLoadingDepartemen
                ? const Center(child: CircularProgressIndicator())
                : CustomDropDownField(
                    label: 'Departemen',
                    hint: 'Pilih departemen',
                    items: _departemenList
                        .map((d) => d.namaDepartemen)
                        .where((name) => name.isNotEmpty)
                        .toList(),
                    value: _selectedDepartment?.namaDepartemen,
                    onChanged: (val) {
                      setState(() {
                        _selectedDepartment = _departemenList.firstWhere(
                          (d) => d.namaDepartemen == val,
                          orElse: () => _departemenList.first,
                        );
                      });
                    },
                    labelStyle: labelStyle,
                    textStyle: textStyle,
                    dropdownColor: AppColors.secondary,
                    dropdownTextColor: AppColors.putih,
                    dropdownIconColor: AppColors.putih,
                    inputStyle: inputStyle,
                  ),
          CustomInputField(
            label: "Lokasi",
            hint: 'Masukkan lokasi tugas',
            controller: _lokasiController,
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "Note",
            hint: "",
            controller: _noteController,
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50, // Fixed height to prevent expanding
            child: ElevatedButton(
              onPressed: isLoading ? null : _handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F1F1F),
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                disabledBackgroundColor:
                    const Color(0xFF1F1F1F).withOpacity(0.6),
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
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
    );
  }
}
