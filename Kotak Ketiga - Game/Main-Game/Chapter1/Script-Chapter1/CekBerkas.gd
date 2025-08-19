extends Node

@onready var folder = $Folder

@onready var jumlahpinjaman = $"Clipboard/Sprite2D2/Jumlah Pinjaman"
@onready var nama = $Clipboard/Sprite2D2/Nama
@onready var tempat = $Clipboard/Sprite2D2/Tempat
@onready var tanggalLahir = $"Clipboard/Sprite2D2/Tanggal Lahir"
@onready var alamat = $Clipboard/Sprite2D2/Alamat
@onready var nomoranggota = $"Clipboard/Sprite2D2/Nomor Keanggotaan"
@onready var jangkaWaktu = $"Clipboard/Sprite2D2/Jangka Waktu"
@onready var keperluan = $Clipboard/Sprite2D2/Keperluan
@onready var catatan = $Clipboard/Sprite2D2/Catatan
@onready var pekerjaan = $Clipboard/Sprite2D2/Pekerjaan

func _ready():
	folder.visible = false
