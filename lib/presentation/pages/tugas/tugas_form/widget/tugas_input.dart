// ignore_for_file: avoid_print, prefer_final_fields, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/components/custom/custom_dropdown.dart';
import 'package:hr/components/custom/custom_input.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/data/models/departemen_model.dart';
import 'package:hr/data/services/departemen_service.dart';

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

  String? _assignmentMode;
  String? _selectedPerson;
  DepartemenModel? _selectedDepartment;

  bool _isLoadingDepartemen = true;
  List<DepartemenModel> _departemenList = [];

  @override
  void initState() {
    super.initState();
    _loadDepartemen();
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
    _tanggalMulaiController.dispose();
    _tanggalSelesaiController.dispose();
    _jamMulaiController.dispose();
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
                _selectedPerson = null;
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
            CustomDropDownField(
              label: 'Tugaskan Kepada',
              hint: '',
              items: ['Budi', 'Elon', 'Nelo'],
              value: _selectedPerson,
              onChanged: (val) {
                setState(() => _selectedPerson = val);
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
            hint: 'Masukkan lokasi tugas',
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "Note",
            hint: "",
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_assignmentMode == 'Per Orang') {
                  print("Mode: Per Orang");
                  print("User: $_selectedPerson");
                } else {
                  print("Mode: Per Departemen");
                  print("Departemen ID: ${_selectedDepartment?.id}");
                  print(
                      "Departemen Nama: ${_selectedDepartment?.namaDepartemen}");
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
