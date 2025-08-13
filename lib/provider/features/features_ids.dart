class FeatureIds {
  // ====================== Fitur Cuti ======================
  static const approveCuti = "approve_cuti";
  static const declineCuti = "decline_cuti";
  static const deleteCuti = "delete_cuti";
  static const editCuti = "edit_cuti";
  static const userDeleteCuti = "user_delete_cuti";
  static const userEditCuti = "user_edit_cuti";
  static const addCuti = "add_cuti";

  // ====================== Modul fitur ======================
  // Super Admin
  static const manageCuti = [
    approveCuti,
    declineCuti,
    deleteCuti,
    editCuti,
  ];
  //User
  static const userCuti = [
    addCuti,
    userDeleteCuti,
    userEditCuti,
  ];

  // Contoh paket lain bisa dibuat seperti ini
  // static const ManageLembur = [approveLembur, declineLembur];
}
