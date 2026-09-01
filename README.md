# Physiotherapy Pocket Handbook

Open study notes fisioterapi dari basic science sampai clinical reasoning. Repo ini dirancang untuk dua cara penggunaan:

- **Pembaca umum:** buka website Quartz dan gunakan search/navigation.
- **Kontributor:** edit file Markdown di `content/` menggunakan Obsidian, VS Code, atau editor lain lalu ajukan Pull Request.

## Fitur

- 200+ Markdown notes yang saling terhubung
- assessment dan lab-skill cards
- special test cards per regio
- outcome measure procedures
- intervensi dengan parameter, progression, precaution, dan reassessment
- kondisi klinis MSK, Neuro, Kardiorespirasi, Pediatri, Geriatri, Sport/Wellness, dan Integument
- anonymized case-pattern library
- quick-reference tables
- full-text search, backlinks, graph, reader mode melalui Quartz 5

## Menjalankan sebagai website

Repository kit ini membawa **konten + konfigurasi publikasi**, bukan source code Quartz. Jalankan:

```bash
./scripts/bootstrap-quartz5.sh physiotherapy-pocket-handbook-site
cd physiotherapy-pocket-handbook-site
npx quartz build --serve
```

Prasyarat: Node >=22, npm >=10.9.2, Git, dan koneksi internet pada setup pertama.

Setelah repository Quartz terbentuk, ubah `baseUrl` di `quartz.config.yaml`, lalu push ke GitHub. Lihat `DEPLOY_CLOUDFLARE.md` atau `DEPLOY_GITHUB_PAGES.md`.

## Kontribusi

Baca [CONTRIBUTING.md](CONTRIBUTING.md), [STYLE_GUIDE.md](STYLE_GUIDE.md), dan [PRIVACY_AND_CONTENT_POLICY.md](PRIVACY_AND_CONTENT_POLICY.md).

## Lisensi

- Konten Markdown: CC BY-NC-SA 4.0
- Script/config/workflow: MIT

Materi sumber mentah tidak termasuk dalam repository publik.
