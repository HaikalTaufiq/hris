import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/components/custom_dropdown.dart';
import 'package:hr/components/custom_input.dart';
import 'package:hr/core/theme.dart';

class TugasInput extends StatefulWidget {
  const TugasInput({super.key});

  @override
  State<TugasInput> createState() => _TugasInputState();
}

class _TugasInputState extends State<TugasInput> {
  final TextEditingController _tanggalController = TextEditingController();

  final TextEditingController _jamMulaiController = TextEditingController();
  final TextEditingController _jamSelesaiController = TextEditingController();

  void _onTapIcon(TextEditingController controller) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        controller.text = pickedTime.format(context);
      });
    }
  }

  @override
  void dispose() {
    _tanggalController.dispose();
    _jamMulaiController.dispose();
    _jamSelesaiController.dispose();
    super.dispose();
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
            label: "Nama Tugas",
            hint: "",
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "Jam Mulai",
            hint: "--:--",
            controller: _jamMulaiController,
            suffixIcon: const Icon(Icons.access_time, color: Colors.white),
            onTapIcon: () => _onTapIcon(_jamMulaiController),
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "Jam Diterima",
            hint: "--:--",
            controller: _jamSelesaiController,
            suffixIcon: const Icon(Icons.access_time, color: Colors.white),
            onTapIcon: () => _onTapIcon(_jamSelesaiController),
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "Batas Waktu",
            hint: "dd / mm / yyyy",
            controller: _tanggalController,
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
                  _tanggalController.text = formatted;
                });
              }
            },
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomDropDownField(
            label: 'Department',
            hint: '',
            items: ['Logistik', 'Technician', 'HRD'],
            labelStyle: labelStyle,
            textStyle: textStyle,
            dropdownColor: secondary,
            dropdownTextColor: putih,
            dropdownIconColor: putih,
            inputStyle: inputStyle,
          ),
          CustomDropDownField(
            label: 'Tugaskan Kepada',
            hint: '',
            items: ['Budi', 'Elon', 'Nelo'],
            labelStyle: labelStyle,
            textStyle: textStyle,
            dropdownColor: secondary,
            dropdownTextColor: putih,
            dropdownIconColor: putih,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "Lokasi",
            hint: "eg, Jl. Raya No. 123",
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: handle submit
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
