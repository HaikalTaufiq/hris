// ignore_for_file: avoid_print, prefer_final_fields, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/components/custom/custom_dropdown.dart';
import 'package:hr/components/custom/custom_input.dart';
import 'package:hr/components/timepicker/time_picker.dart';
import 'package:hr/core/helpers/notification_helper.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/data/models/departemen_model.dart';
import 'package:hr/data/models/tugas_model.dart';
import 'package:hr/data/models/user_model.dart';
import 'package:hr/data/services/departemen_service.dart';
import 'package:hr/data/services/user_service.dart';
import 'package:hr/provider/function/tugas_provider.dart';
import 'package:provider/provider.dart';

class TugasInputEdit extends StatefulWidget {
  final TugasModel tugas;
  const TugasInputEdit({super.key, required this.tugas});

  @override
  State<TugasInputEdit> createState() => _TugasInputEditState();
}

class _TugasInputEditState extends State<TugasInputEdit> {
  final TextEditingController _tanggalMulaiController = TextEditingController();
  final TextEditingController _tanggalSelesaiController =
      TextEditingController();
  final TextEditingController _jamMulaiController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _judulTugasController = TextEditingController();
  int _selectedMinute = 0;
  int _selectedHour = 0;
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
    showModalBottomSheet(
      backgroundColor: AppColors.primary,
      useRootNavigator: true,
      context: context,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  ListTile(
                    title: Center(
                      child: Column(
                        children: [
                          Container(
                            height: 3,
                            width: 40,
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Pilih Waktu',
                            style: TextStyle(
                              color: AppColors.putih,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Pengajuan Lembur',
                            style: TextStyle(
                              color: AppColors.putih,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  NumberPickerWidget(
                    hour: _selectedHour,
                    minute: _selectedMinute,
                    onHourChanged: (value) {
                      setModalState(() {
                        _selectedHour = value;
                      });
                    },
                    onMinuteChanged: (value) {
                      setModalState(() {
                        _selectedMinute = value;
                      });
                    },
                  ),
                  FloatingActionButton.extended(
                    backgroundColor: AppColors.secondary,
                    onPressed: () {
                      // Format waktu menjadi HH:mm
                      final formattedHour =
                          _selectedHour.toString().padLeft(2, '0');
                      final formattedMinute =
                          _selectedMinute.toString().padLeft(2, '0');
                      final formattedTime = "$formattedHour:$formattedMinute";

                      // Simpan ke text field controller
                      controller.text = formattedTime;

                      Navigator.pop(context);
                    },
                    label: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: AppColors.putih,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _onTapIconDate(TextEditingController controller) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF1F1F1F), // Header & selected date
              onPrimary: Colors.white, // Teks tanggal terpilih
              onSurface: AppColors.hitam, // Teks hari/bulan
              secondary: AppColors.yellow, // Hari yang di-hover / highlight
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.hitam, // Tombol CANCEL/OK
              ),
            ),
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme.apply(
                    bodyColor: AppColors.hitam,
                    displayColor: AppColors.hitam,
                  ),
            ),
          ),
          child: child!,
        );
      },
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

      final result = await tugasProvider.updateTugas(
        id: widget.tugas.id,
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
    // Use Consumer to properly watch the provider
    return Consumer<TugasProvider>(
      builder: (context, tugasProvider, child) {
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
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Color(0x00FFFFFF),
                      ))
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
                          child: CircularProgressIndicator(),
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
      },
    );
  }
}
