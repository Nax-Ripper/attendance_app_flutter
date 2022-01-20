import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spring1_ui/Supervisor/getEmployeeData.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

void getExcel(String name, String address, String phone, String uid,
    String Tamount) async {
  final Workbook workbook = Workbook();
  final Worksheet sheet = workbook.worksheets[0];

  sheet.showGridlines = false;
  sheet.getRangeByName('A1').columnWidth = 4.82;
  sheet.getRangeByName('B1:C1').columnWidth = 13.82;
  sheet.getRangeByName('D1').columnWidth = 13.20;
  sheet.getRangeByName('E1').columnWidth = 13.50;
  sheet.getRangeByName('F1').columnWidth = 13.73;
  sheet.getRangeByName('G1').columnWidth = 10.82;
  sheet.getRangeByName('H1').columnWidth = 4.46;
  sheet.getRangeByName('A1:H1').cellStyle.backColor = '#333F4F';
  sheet.getRangeByName('A1:H1').merge();
  sheet.getRangeByName('B4:D6').merge();

  sheet.getRangeByName('B4').setText('TimeDesk');
  sheet.getRangeByName('B4').cellStyle.fontSize = 32;

  sheet.getRangeByName('B8').setText('PAYSLIP OF:');
  sheet.getRangeByName('B8').cellStyle.fontSize = 9;
  sheet.getRangeByName('B8').cellStyle.bold = true;

  sheet.getRangeByName('B9').setText(name.toString().toUpperCase());
  sheet.getRangeByName('B9').cellStyle.fontSize = 12;

  sheet.getRangeByName('B10').setText(address.toString());
  sheet.getRangeByName('B10').cellStyle.fontSize = 9;

  sheet.getRangeByName('B11').setText(phone.toString());
  sheet.getRangeByName('B11').cellStyle.fontSize = 9;
  sheet.getRangeByName('B11').cellStyle.hAlign = HAlignType.left;

  final Range range1 = sheet.getRangeByName('F8:G8');
  final Range range2 = sheet.getRangeByName('F9:G9');
  final Range range3 = sheet.getRangeByName('F10:G10');
  final Range range4 = sheet.getRangeByName('F11:G11');
  final Range range5 = sheet.getRangeByName('F12:G12');

  range1.merge();
  range2.merge();
  range3.merge();
  range4.merge();
  range5.merge();

  sheet.getRangeByName('F8').setText('Employee ID#');
  range1.cellStyle.fontSize = 8;
  range1.cellStyle.bold = true;
  range1.cellStyle.hAlign = HAlignType.right;

  sheet.getRangeByName('F9').setText(uid);
  range2.cellStyle.fontSize = 9;
  range2.cellStyle.hAlign = HAlignType.right;

  sheet.getRangeByName('F10').setText('DATE');
  range3.cellStyle.fontSize = 8;
  range3.cellStyle.bold = true;
  range3.cellStyle.hAlign = HAlignType.right;

  sheet.getRangeByName('F11').dateTime = DateTime.now();
  sheet.getRangeByName('F11').numberFormat =
      '[\$-x-sysdate]dddd, mmmm dd, yyyy';
  range4.cellStyle.fontSize = 9;
  range4.cellStyle.hAlign = HAlignType.right;

  range5.cellStyle.fontSize = 8;
  range5.cellStyle.bold = true;
  range5.cellStyle.hAlign = HAlignType.right;

  final Range range6 = sheet.getRangeByName('B15:G15');
  range6.cellStyle.fontSize = 10;
  range6.cellStyle.bold = true;

  // sheet.getRangeByIndex(15, 2).setText("No.");
  sheet.getRangeByIndex(15, 3).setText("Date");
  sheet.getRangeByIndex(15, 4).setText("Check IN");
  sheet.getRangeByIndex(15, 5).setText("Check OUT");
  sheet.getRangeByIndex(15, 6).setText("Amount");

  print(CIN.length);
  var count = CIN.length;
  for (var i = 0; i < count; i++) {
    // sheet.getRangeByName("B${i+17}").setText((i+1).toString());
    sheet
        .getRangeByName("C${i + 17}")
        .setText(CIN[i].toString().substring(2, 10));
    sheet
        .getRangeByName("D${i + 17}")
        .setText(CIN[i].toString().substring(11, 16));
    sheet
        .getRangeByName("E${i + 17}")
        .setText(COUT[i].toString().substring(11, 16));
    sheet.getRangeByName("F${i + 17}").setText(Current_Amount[i].toString());
  }
  // sheet.getRangeByName('E${count+18}:G${count+18}').merge();
  // sheet.getRangeByName('E${count+18}:G${count+18}').cellStyle.hAlign = HAlignType.right;
  // sheet.getRangeByName('E${count + 18 + 1}:G24${count + 18 + 2}').merge();
  final Range range7 = sheet.getRangeByName("F${count + 18}");
  final Range range8 = sheet.getRangeByName("F${count + 18 + 1}");
  range7.setText("TOTAL :");
  range7.cellStyle.fontSize = 10;
  range8.setText("RM " + Tamount.toString());
  range8.cellStyle.fontSize = 24;
  range8.cellStyle.hAlign = HAlignType.right;
  range8.cellStyle.bold = true;
  sheet.getRangeByName("A${count+23}").text =
        'BlitzUTM, UTMSkudai, Johor, +60 011-1128 0169 | blitz.utm.flutter66@gmail.com';
  final Range range9 = sheet.getRangeByName('A${count+23}:H${count+24}');
  range9.cellStyle.backColor = '#ACB9CA';
  range9.merge();
    range9.cellStyle.hAlign = HAlignType.center;
    range9.cellStyle.vAlign = VAlignType.center;
  // for (var i = 16; i < count; i++) {
  //   print(i - 16 + 1);
  //   sheet.getRangeByName("B$i").setText(CIN[i-16].toString().substring(2,10));
  // }

  // sheet.getRangeByName("B1").setText("Check IN");
  // sheet.getRangeByName("C1").setText("Check OUT");
  // sheet.getRangeByName("D1").setText("Amount (RM)");

  // print("The Length is : " + CIN.length.toString());
  // int count = CIN.length;

  // for (var i = 0; i < CIN.length; i++) {
  //   sheet.getRangeByName("B${i + 2}").setValue(CIN[i]);
  //   sheet.getRangeByName("C${i + 2}").setValue(COUT[i]);
  //   sheet.getRangeByName("D${i + 2}").setValue(Current_Amount[i]);
  // }

  final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();

  final String path = (await getApplicationSupportDirectory()).path;
  final String fileName = "$path/$name.xlsx";
  final File file = File(fileName);
  await file.writeAsBytes(bytes, flush: true);
  // if (CIN != null) {
  //   CIN.clear();
  //   COUT.clear();
  //   Current_Amount.clear();
  // }
  OpenFile.open(fileName);
}
