class JadwalShalat {
  bool? status;
  Request? request;
  Data? data;

  JadwalShalat({this.status, this.request, this.data});

  JadwalShalat.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    request =
        json['request'] != null ? new Request.fromJson(json['request']) : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.request != null) {
      data['request'] = this.request!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Request {
  String? path;

  Request({this.path});

  Request.fromJson(Map<String, dynamic> json) {
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    return data;
  }
}

class Data {
  int? id;
  String? lokasi;
  String? daerah;
  List<Jadwal>? jadwal;

  Data({this.id, this.lokasi, this.daerah, this.jadwal});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lokasi = json['lokasi'];
    daerah = json['daerah'];
    if (json['jadwal'] != null) {
      jadwal = <Jadwal>[];
      json['jadwal'].forEach((v) {
        jadwal!.add(new Jadwal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lokasi'] = this.lokasi;
    data['daerah'] = this.daerah;
    if (this.jadwal != null) {
      data['jadwal'] = this.jadwal!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jadwal {
  String? tanggal;
  String? imsak;
  String? subuh;
  String? terbit;
  String? dhuha;
  String? dzuhur;
  String? ashar;
  String? maghrib;
  String? isya;
  String? date;

  Jadwal(
      {this.tanggal,
      this.imsak,
      this.subuh,
      this.terbit,
      this.dhuha,
      this.dzuhur,
      this.ashar,
      this.maghrib,
      this.isya,
      this.date});

  Jadwal.fromJson(Map<String, dynamic> json) {
    tanggal = json['tanggal'];
    imsak = json['imsak'];
    subuh = json['subuh'];
    terbit = json['terbit'];
    dhuha = json['dhuha'];
    dzuhur = json['dzuhur'];
    ashar = json['ashar'];
    maghrib = json['maghrib'];
    isya = json['isya'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tanggal'] = this.tanggal;
    data['imsak'] = this.imsak;
    data['subuh'] = this.subuh;
    data['terbit'] = this.terbit;
    data['dhuha'] = this.dhuha;
    data['dzuhur'] = this.dzuhur;
    data['ashar'] = this.ashar;
    data['maghrib'] = this.maghrib;
    data['isya'] = this.isya;
    data['date'] = this.date;
    return data;
  }
}