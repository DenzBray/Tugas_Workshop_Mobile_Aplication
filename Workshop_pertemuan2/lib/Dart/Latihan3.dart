class Produk {
  String nama;
  double _harga = 0; // Private property

  // Constructor utama
  Produk(this.nama, double hargaAwal) {
    harga = hargaAwal; // Memanggil setter untuk validasi
  }

  // Named constructor (Otomatis harga 0)
  Produk.gratis(this.nama) {
    _harga = 0;
  }

  // Getter
  double get harga => _harga;

  // Setter dengan validasi
  set harga(double value) {
    if (value < 0) {
      print('Error: Harga $nama tidak boleh negatif! Diset ke 0.');
      _harga = 0;
    } else {
      _harga = value;
    }
  }
}

void main() {
  var p1 = Produk('Keyboard Gaming', 60000); // Akan memicu pesan error
  print('${p1.nama} harganya Rp${p1.harga}');

  var p2 = Produk.gratis('Voucher Game');
  print('${p2.nama} harganya Rp${p2.harga}');
}