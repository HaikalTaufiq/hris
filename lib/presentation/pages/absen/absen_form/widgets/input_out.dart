import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/components/custom_dropdown.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/components/custom_input.dart';

class InputOut extends StatefulWidget {
  const InputOut({super.key});

  @override
  State<InputOut> createState() => _InputOutState();
}

class _InputOutState extends State<InputOut> {
  final TextEditingController _tanggalController = TextEditingController();

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
            label: "Nama",
            hint: "",
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "Tanggal",
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
            label: 'Tipe Absen',
            hint: '',
            items: ['Hadir', 'Telat', 'Izin'],
            labelStyle: labelStyle,
            textStyle: textStyle,
            dropdownColor: secondary,
            dropdownTextColor: putih,
            dropdownIconColor: putih,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "Jam Keluar",
            hint: "--:--",
            controller: _jamSelesaiController,
            suffixIcon: const Icon(Icons.access_time, color: Colors.white),
            onTapIcon: () => _onTapIcon(_jamSelesaiController),
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "Lokasi",
            hint: "",
            controller: null,
            suffixIcon: const Icon(Icons.location_history, color: Colors.white),
            onTapIcon: () {},
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "Photo",
            hint: "",
            controller: null,
            suffixIcon: const Icon(Icons.camera_alt, color: Colors.white),
            onTapIcon: () {},
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "Keterangan",
            hint: "",
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
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
