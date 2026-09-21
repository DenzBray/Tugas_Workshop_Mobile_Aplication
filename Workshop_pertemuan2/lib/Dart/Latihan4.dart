// Abstract Class
abstract class Kendaraan {
  void bunyiKlakson();
}

// Mixin
mixin BisaNgebut {
  void ngebut() {
    print('Wusss! Kendaraan melaju kencang pakai NOS!');
  }
}

// Class Motor (Hanya extends Kendaraan)
class Motor extends Kendaraan {
  @override
  void bunyiKlakson() {
    print('Motor: Tin tin!');
  }
}

// Class Mobil (Extends Kendaraan dan menggunakan Mixin BisaNgebut)
class Mobil extends Kendaraan with BisaNgebut {
  @override
  void bunyiKlakson() {
    print('Mobil: Din din!');
  }
}

void main() {
  var motorKu = Motor();
  motorKu.bunyiKlakson();
  // motorKu.ngebut(); // Error jika dijalankan karena Motor tidak punya mixin BisaNgebut

  var mobilKu = Mobil();
  mobilKu.bunyiKlakson();
  mobilKu.ngebut(); // Bisa dipanggil karena ada mixin
}