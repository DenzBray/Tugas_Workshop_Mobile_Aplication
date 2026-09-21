void main() {
  Map<String, dynamic> mahasiswa = {
    'nama': 'Deny',
    'nim': 'E41251206',
    'email': null, // Email diset null
  };

  String nama = mahasiswa['nama'];
  String nim = mahasiswa['nim'];
  String email = mahasiswa['email'] ?? 'Email tidak tersedia (Belum diisi)';

  print('Nama: $nama');
  print('NIM: $nim');
  print('Email: $email');
}