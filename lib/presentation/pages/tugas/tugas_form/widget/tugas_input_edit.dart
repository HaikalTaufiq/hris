// ignore_for_file: avoid_print, prefer_final_fields, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/components/custom/custom_dropdown.dart';
import 'package:hr/components/custom/custom_input.dart';
import 'package:hr/core/helpers/notification_helper.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/data/models/departemen_model.dart';
import 'package:hr/data/models/tugas_model.dart';
import 'package:hr/data/models/user_model.dart';
import 'package:hr/data/services/departemen_service.dart';
import 'package:hr/data/services/tugas_service.dart';
import 'package:hr/data/services/user_service.dart';

class TugasInputEdit extends StatefulWidget {
  final TugasModel tugas;
  const TugasInputEdit({super.key, required this.tugas});

  @override
  State<TugasInputEdit> createState() => _TugasInputEditState();
}

class _TugasInputEditState extends State<TugasInputEdit> {
  final TextEditingController _tanggalMulaiController = TextEditingController();
  final TextEditingController _tanggalSelesaiController = TextEditingController();
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
    // Isi controller dari data awal
    _judulTugasController.text = widget.tugas.namaTugas;
    _jamMulaiController.text = widget.tugas.jamMulai;
    _tanggalMulaiController.text = widget.tugas.tanggalMulai;
    _tanggalSelesaiController.text = widget.tugas.tanggalSelesai;
    _lokasiController.text = widget.tugas.lokasi;
    _noteController.text = widget.tugas.note;

    // Assignment mode
    if (widget.tugas.users.isNotEmpty) {
      if (widget.tugas.users.length == 1) {
        // Mode per orang
        _assignmentMode = 'Per Orang';
        _selectedUser = widget.tugas.users.first;
      } else {
        // Mode per departemen (atau multi-user)
        _assignmentMode = 'Per Departemen';
        // Ambil departemen dari user pertama (asumsi semua user dari departemen yang sama)
        _selectedDepartment = widget.tugas.users.first.departemen;
      }
    }


    // TODO: kalau ada lokasi & note
    // _lokasiController.text = widget.tugas.lokasi;
    // _noteController.text = widget.tugas.not  e;

    _loadDepartemen();
    _loadUsers();

  }

  Future<void> _loadUsers() async {
    try {
      final userData = await UserService.fetchUsers();
      setState(() {
        _userList = userData;
        _isLoadingUser = false;
      });
    } catch (e) {
      print("Error fetch users: $e");
      setState(() => _isLoadingUser = false);
    }
  }


  Future<void> _loadDepartemen() async {
    try {
      final departemenData = await DepartemenService.fetchDepartemen();
      setState(() {
        _departemenList = departemenData;
        _isLoadingDepartemen = false;
      });
    } catch (e) {
      print("Error fetch departemen: $e");
      setState(() => _isLoadingDepartemen = false);
    }
  }

  void _onTapIconTime(TextEditingController controller) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
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
    if (pickedDate != null) {
      controller.text =
          "${pickedDate.day.toString().padLeft(2, '0')} / ${pickedDate.month.toString().padLeft(2, '0')} / ${pickedDate.year}";
    }
  }

  @override
  void dispose() {
    _judulTugasController.dispose();
    _tanggalMulaiController.dispose();
    _tanggalSelesaiController.dispose();
    _jamMulaiController.dispose();
    _noteController.dispose();
    _lokasiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                ? const CircularProgressIndicator()
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
                        _selectedUser = _userList.firstWhere((user) => user.nama == val);
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
                ? const CircularProgressIndicator()
                : CustomDropDownField(
                    label: 'Departemen',
                    hint: 'Pilih departemen',
                    items:
                        _departemenList
                            .map((d) => d.namaDepartemen)
                            .where((name) => name.isNotEmpty)
                            .toList(),
                    value: _selectedDepartment?.namaDepartemen,
                    onChanged: (val) {
                      setState(() {
                        _selectedDepartment = _departemenList.firstWhere(
                          (d) => d.namaDepartemen == val,
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
            hint: '',
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
          const SizedBox(height: 5),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (_judulTugasController.text.isEmpty ||
                    _jamMulaiController.text.isEmpty ||
                    _tanggalMulaiController.text.isEmpty ||
                    _tanggalSelesaiController.text.isEmpty ||
                    _assignmentMode == null ||
                    _lokasiController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Harap isi semua data wajib")),
                  );
                  return;
                }

                final result = await TugasService.updateTugas(
                  id: widget.tugas.id,
                  judul: _judulTugasController.text,
                  jamMulai: _jamMulaiController.text,
                  tanggalMulai: _tanggalMulaiController.text,
                  tanggalSelesai: _tanggalSelesaiController.text,
                  assignmentMode: _assignmentMode!,
                  person: _assignmentMode == "Per Orang" ? _selectedUser?.id : null,
                  departmentId: _assignmentMode == "Per Departemen" ? _selectedDepartment?.id : null,
                  lokasi: _lokasiController.text,
                  note: _noteController.text,
                );

                if (!mounted) return;

                NotificationHelper.showSnackBar(
                  context,
                  result['message'],
                  isSuccess: result['success'],
                );

                if (result['success']) {
                  Navigator.pop(context, true); // kembalikan true agar halaman sebelumnya bisa refresh
                }
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
    );
  }
}
