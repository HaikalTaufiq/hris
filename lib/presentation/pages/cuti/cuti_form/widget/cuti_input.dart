import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/components/custom_dropdown.dart';
import 'package:hr/components/custom_input.dart';
import 'package:hr/core/helpers/notification_helper.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/data/services/cuti_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CutiInput extends StatefulWidget {
  const CutiInput({super.key});

  @override
  State<CutiInput> createState() => _CutiInputState();
}

class _CutiInputState extends State<CutiInput> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tipeCutiController = TextEditingController();
  final TextEditingController _tanggalMulaiController = TextEditingController();
  final TextEditingController _tanggalSelesaiController = TextEditingController();
  final TextEditingController _alasanController = TextEditingController();
  

  @override
  void initState() {
    super.initState();
    _loadNamaUser();
  }

  void _loadNamaUser() async {
    final prefs = await SharedPreferences.getInstance();
    final nama = prefs.getString('nama') ?? '';
    setState(() {
      _namaController.text = nama;
    });
  }


  @override
  Widget build(BuildContext context) {
    final inputStyle = InputDecoration(
      hintStyle: const TextStyle(color: Colors.white70),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    );

    final labelStyle = GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      color: putih,
      fontSize: 16,
    );

    final textStyle = GoogleFonts.poppins(
      color: Colors.white,
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
            label: "Nama",
            hint: "",
            controller: _namaController,
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomDropDownField(
            label: 'Tipe Cuti',
            hint: '',
            items: ['Tahunan', 'Cuti Sakit', 'Cuti Bersama', 'Izin'],
            labelStyle: labelStyle,
            textStyle: textStyle,
            dropdownColor: secondary,
            dropdownTextColor: putih,
            dropdownIconColor: putih,
            inputStyle: inputStyle,
            onChanged: (String? val) {
              if (val != null) {
                setState(() {
                  _tipeCutiController.text = val;
                });
              }
            },
          ),
          CustomInputField(
            label: "Tanggal Mulai",
            hint: "dd / mm / yyyy",
            controller: _tanggalMulaiController,
            suffixIcon: const Icon(Icons.calendar_today, color: Colors.white),
            onTapIcon: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                final formatted =
                    "${pickedDate.day.toString().padLeft(2, '0')} / "
                    "${pickedDate.month.toString().padLeft(2, '0')} / "
                    "${pickedDate.year}";
                setState(() {
                  _tanggalMulaiController.text = formatted;
                });
              }
            },
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "Tanggal Selesai",
            hint: "dd / mm / yyyy",
            controller: _tanggalSelesaiController,
            suffixIcon: const Icon(Icons.calendar_today, color: Colors.white),
            onTapIcon: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                final formatted =
                    "${pickedDate.day.toString().padLeft(2, '0')} / "
                    "${pickedDate.month.toString().padLeft(2, '0')} / "
                    "${pickedDate.year}";
                setState(() {
                  _tanggalSelesaiController.text = formatted;
                });
              }
            },
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "Alasan",
            hint: "",
            controller: _alasanController,
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final success = await CutiService.createCuti(
                  nama: _namaController.text,
                  tipeCuti: _tipeCutiController.text,
                  tanggalMulai: _tanggalMulaiController.text,
                  tanggalSelesai: _tanggalSelesaiController.text,
                  alasan: _alasanController.text,
                );
                if (success) {
                  if (context.mounted) {
                    NotificationHelper.showSnackBar(context, 'Lembur berhasil diajukan');
                    Navigator.of(context).pop();
                  }
                } else {
                  if (context.mounted) {
                    NotificationHelper.showSnackBar(context, 'Gagal mengajukan lembur', isSuccess: false);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Submit',
                style: GoogleFonts.poppins(
                  color: putih,
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
