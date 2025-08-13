import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/components/custom/custom_input.dart';
import 'package:hr/core/helpers/notification_helper.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/data/models/lembur_model.dart';
import 'package:hr/data/services/lembur_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LemburEdit extends StatefulWidget {
  final LemburModel lembur;

  const LemburEdit({super.key, required this.lembur});

  @override
  State<LemburEdit> createState() => _LemburEditState();
}

class _LemburEditState extends State<LemburEdit> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _jamMulaiController = TextEditingController();
  final TextEditingController _jamSelesaiController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tanggalController.text = widget.lembur.tanggal;
    _jamMulaiController.text = widget.lembur.jamMulai;
    _jamSelesaiController.text = widget.lembur.jamSelesai;
    _deskripsiController.text = widget.lembur.deskripsi;
    _loadNamaUser();
  }

  void _loadNamaUser() async {
    final prefs = await SharedPreferences.getInstance();
    final nama = prefs.getString('nama') ?? '';
    if (mounted) {
      setState(() {
        _namaController.text = nama;
      });
    }
  }

  void _onTapIcon(TextEditingController controller) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && mounted) {
      final jam = pickedTime.hour.toString().padLeft(2, '0');
      final menit = pickedTime.minute.toString().padLeft(2, '0');
      final formattedTime = '$jam:$menit';

      setState(() {
        controller.text = formattedTime;
      });
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _tanggalController.dispose();
    _jamMulaiController.dispose();
    _jamSelesaiController.dispose();
    _deskripsiController.dispose();
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
            label: "Nama",
            hint: "",
            controller: _namaController,
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
            readOnly: true,
          ),
          CustomInputField(
            label: "Tanggal Lembur",
            hint: "dd / mm / yyyy",
            controller: _tanggalController,
            suffixIcon: Icon(Icons.calendar_today, color: AppColors.putih),
            onTapIcon: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null && mounted) {
                final formatted =
                    "${pickedDate.day.toString().padLeft(2, '0')} / "
                    "${pickedDate.month.toString().padLeft(2, '0')} / "
                    "${pickedDate.year}";
                setState(() {
                  _tanggalController.text = formatted;
                });
              }
            },
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "Jam Mulai",
            hint: "--:--",
            controller: _jamMulaiController,
            suffixIcon: Icon(Icons.access_time, color: AppColors.putih),
            onTapIcon: () => _onTapIcon(_jamMulaiController),
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "Jam Selesai",
            hint: "--:--",
            controller: _jamSelesaiController,
            suffixIcon: Icon(Icons.access_time, color: AppColors.putih),
            onTapIcon: () => _onTapIcon(_jamSelesaiController),
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "Keterangan",
            hint: "",
            controller: _deskripsiController,
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                try {
                  final success = await LemburService.createLembur(
                    tanggal: _tanggalController.text,
                    jamMulai: _jamMulaiController.text,
                    jamSelesai: _jamSelesaiController.text,
                    deskripsi: _deskripsiController.text,
                  );

                  if (!mounted) return;

                  if (success) {
                    NotificationHelper.showSnackBar(
                        context, 'Lembur berhasil diajukan');
                    if (mounted) {
                      Navigator.of(context).pop(true);
                    }
                  } else {
                    NotificationHelper.showSnackBar(
                        context, 'Gagal mengajukan lembur',
                        isSuccess: false);
                  }
                } catch (e) {
                  if (!mounted) return;
                  NotificationHelper.showSnackBar(
                      context, 'Terjadi kesalahan: $e',
                      isSuccess: false);
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
