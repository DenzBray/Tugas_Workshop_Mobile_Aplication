void main() {
  List<int> nilai = [80, 90, 65, 70, 95];

  // 1. Filter nilai >= 75
  var nilaiLulus = nilai.where((n) => n >= 75).toList();
  print('Nilai yang lulus: $nilaiLulus');

  // 2. Map ke predikat huruf dengan switch expression
  var predikat = nilai.map((n) {
    return switch (n) {
      >= 85 => 'A',
      >= 75 => 'B',
      _ => 'C',
    };
  }).toList();
  
  print('Predikat nilai: $predikat');
}