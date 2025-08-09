import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/components/custom_dropdown.dart';
import 'package:hr/components/custom_input.dart';
import 'package:hr/core/theme.dart';

class KaryawanInput extends StatefulWidget {
  const KaryawanInput({super.key});

  @override
  State<KaryawanInput> createState() => _KaryawanInputState();
}

class _KaryawanInputState extends State<KaryawanInput> {
  final TextEditingController _tanggalController = TextEditingController();

  final TextEditingController _jamMulaiController = TextEditingController();
  final TextEditingController _jamSelesaiController = TextEditingController();

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
            label: "Nama",
            hint: "",
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomDropDownField(
            label: 'Jabatan',
            hint: '',
            items: ['Staff', 'Supervisor', 'CEO'],
            labelStyle: labelStyle,
            textStyle: textStyle,
            dropdownColor: secondary,
            dropdownTextColor: putih,
            dropdownIconColor: putih,
            inputStyle: inputStyle,
          ),
          CustomDropDownField(
            label: 'Peran',
            hint: '',
            items: ['Super Admin', 'Admin Office', 'Technician'],
            labelStyle: labelStyle,
            textStyle: textStyle,
            dropdownColor: secondary,
            dropdownTextColor: putih,
            dropdownIconColor: putih,
            inputStyle: inputStyle,
          ),
          CustomDropDownField(
            label: 'Department',
            hint: '',
            items: ['HRD', 'Accounting', 'Sales'],
            labelStyle: labelStyle,
            textStyle: textStyle,
            dropdownColor: secondary,
            dropdownTextColor: putih,
            dropdownIconColor: putih,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "Gaji Pokok",
            hint: "",
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "NPWP",
            hint: "",
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "No. BPJS Ketenagakerjaan (Opsional)",
            hint: "",
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "No. BPJS Kesehatan (Opsional)",
            hint: "",
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomInputField(
            label: "Password HRIS Account",
            hint: "",
            labelStyle: labelStyle,
            textStyle: textStyle,
            inputStyle: inputStyle,
          ),
          CustomDropDownField(
            label: 'Status Pernikahan',
            hint: '',
            items: [
              'Married',
              'Not Married',
            ],
            labelStyle: labelStyle,
            textStyle: textStyle,
            dropdownColor: secondary,
            dropdownTextColor: putih,
            dropdownIconColor: putih,
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
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
