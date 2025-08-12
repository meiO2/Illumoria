# Nama file: ClickableObject.gd
extends Area2D

# Sinyal yang akan dipancarkan saat objek ini diklik.
# Ia akan membawa 'object_id' agar skrip utama tahu objek mana yang diklik.
signal clicked(object_id)

# Variabel yang bisa diatur dari Inspector Godot
# Beri ID unik untuk objek ini (misal: "buku_harian", "telepon_rusak")
@export var object_id: String = "" 

# Path ke gambar baru jika ingin objek berubah saat diklik (opsional)
@export var new_texture_path: String = "" 


# Fungsi yang berjalan sekali saat objek siap
func _ready():
	# Menghubungkan sinyal bawaan Area2D ke fungsi kita.
	# "input_event" terpancar setiap kali mouse masuk/keluar/klik di dalam area collision.
	self.input_event.connect(_on_input_event)


# Fungsi ini akan dipanggil secara otomatis berkat koneksi di _ready()
func _on_input_event(viewport, event, shape_idx):
	# Kita hanya peduli pada event klik kiri mouse yang baru saja ditekan
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
		# 1. Pancarkan sinyal untuk memberitahu skrip utama (seperti Chapter1a.gd)
		emit_signal("clicked", object_id)
		
		# 2. Jalankan logika untuk mengubah gambar diri sendiri (jika diatur)
		if not new_texture_path.is_empty():
			# Dapatkan node Sprite2D yang merupakan anak dari Area2D ini
			# Pastikan nama node sprite Anda adalah "Sprite2D"
			var sprite = get_node("Sprite2D")
			if sprite:
				# Ganti tekstur sprite dengan gambar baru yang dimuat dari path
				sprite.texture = load(new_texture_path)
			else:
				# Pesan error jika node Sprite2D tidak ditemukan
				printerr("Node 'Sprite2D' tidak ditemukan di dalam '", self.name, "'")
