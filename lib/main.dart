import 'package:flutter/material.dart'; // Mengimpor paket Flutter untuk membuat antarmuka aplikasi.
import 'package:expressions/expressions.dart'; // Mengimpor paket untuk evaluasi ekspresi matematika.

void main() {
  runApp(const MyApp()); // Menjalankan aplikasi dengan widget MyApp sebagai titik masuk aplikasi.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Konstruktor untuk widget MyApp.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator iPhone', // Menetapkan judul aplikasi.
      theme: ThemeData(
        primaryColor: Colors.black, // Mengatur warna utama aplikasi menjadi hitam.
        scaffoldBackgroundColor: Colors.black, // Mengatur latar belakang scaffold menjadi hitam.
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // Mengatur warna teks menjadi putih.
        ),
      ),
      home: const Calculator(), // Menetapkan halaman utama aplikasi dengan widget Calculator.
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key}); // Konstruktor untuk widget Calculator.

  @override
  _CalculatorState createState() => _CalculatorState(); // Membuat state untuk widget Calculator.
}

class _CalculatorState extends State<Calculator> {
  String output = "0"; // Variabel untuk menyimpan hasil kalkulasi, dimulai dengan "0".

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        output = "0"; // Jika tombol C ditekan, reset output ke "0".
      } else if (buttonText == "=") {
        try {
          output = evaluateExpression(output); // Evaluasi ekspresi saat tombol "=" ditekan.
        } catch (e) {
          output = "Error"; // Jika terjadi kesalahan dalam evaluasi ekspresi, tampilkan "Error".
        }
      } else {
        if (output == "0") {
          output = buttonText; // Jika output masih "0", ganti dengan tombol yang ditekan.
        } else {
          output += buttonText; // Tambahkan teks tombol ke output.
        }
      }
    });
  }

  String evaluateExpression(String expression) {
    // Mengganti operator ÷ dengan / untuk evaluasi ekspresi.
    expression = expression.replaceAll('÷', '/'); 
    // Mengganti x dengan * untuk evaluasi ekspresi.
    expression = expression.replaceAll('x', '*'); 

    try {
      final expressionToEvaluate = Expression.parse(expression); // Parsing ekspresi string menjadi objek Expression.
      final evaluator = const ExpressionEvaluator(); // Membuat evaluator ekspresi.
      var result = evaluator.eval(expressionToEvaluate, {}); // Mengevaluasi ekspresi matematika.
      return result.toString(); // Mengembalikan hasil evaluasi sebagai string.
    } catch (e) {
      return "Error"; // Jika ada kesalahan dalam evaluasi, kembalikan "Error".
    }
  }

  Widget buildButton(String buttonText, Color color, {double widthFactor = 1.0}) {
    // Fungsi untuk membangun tombol kalkulator.
    return Expanded(
      flex: widthFactor.toInt(), // Menentukan lebar tombol berdasarkan faktor lebar yang diberikan.
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Memberikan padding pada tombol.
        child: ElevatedButton(
          onPressed: () => buttonPressed(buttonText), // Menentukan aksi saat tombol ditekan.
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 22), // Mengatur padding vertikal tombol.
            backgroundColor: color, // Mengatur warna latar belakang tombol.
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0), // Membuat tombol dengan sudut melengkung.
            ),
            elevation: 0, // Menghilangkan bayangan tombol.
          ),
          child: Text(
            buttonText, // Menampilkan teks tombol.
            style: const TextStyle(
              fontSize: 28, // Ukuran font tombol.
              fontWeight: FontWeight.w400, // Ketebalan font tombol.
              color: Colors.white, // Warna teks tombol.
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Fungsi untuk membangun tampilan UI kalkulator.
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Membuat elemen-elemen dalam kolom memenuhi lebar penuh.
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 24, bottom: 24), // Padding kanan dan bawah untuk hasil.
              alignment: Alignment.bottomRight, // Menempatkan hasil kalkulasi di kanan bawah.
              child: Text(
                output, // Menampilkan output kalkulasi.
                style: const TextStyle(fontSize: 80, color: Colors.white), // Gaya teks output.
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  buildButton("C", Colors.grey.shade600), // Tombol untuk menghapus input.
                  buildButton("+/-", Colors.grey.shade600), // Tombol untuk mengubah tanda angka.
                  buildButton("%", Colors.grey.shade600), // Tombol persen.
                  buildButton("÷", Colors.orange), // Tombol pembagian dengan simbol ÷.
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("7", Colors.grey.shade800), // Tombol angka 7.
                  buildButton("8", Colors.grey.shade800), // Tombol angka 8.
                  buildButton("9", Colors.grey.shade800), // Tombol angka 9.
                  buildButton("x", Colors.orange), // Tombol perkalian dengan simbol x.
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("4", Colors.grey.shade800), // Tombol angka 4.
                  buildButton("5", Colors.grey.shade800), // Tombol angka 5.
                  buildButton("6", Colors.grey.shade800), // Tombol angka 6.
                  buildButton("-", Colors.orange), // Tombol pengurangan.
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("1", Colors.grey.shade800), // Tombol angka 1.
                  buildButton("2", Colors.grey.shade800), // Tombol angka 2.
                  buildButton("3", Colors.grey.shade800), // Tombol angka 3.
                  buildButton("+", Colors.orange), // Tombol penjumlahan.
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("0", Colors.grey.shade800, widthFactor: 2), // Tombol angka 0, dengan lebar dua kali lebih besar.
                  buildButton(".", Colors.grey.shade800), // Tombol desimal.
                  buildButton("=", Colors.green), // Tombol untuk menghitung hasil.
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
