# Contributing

Terima kasih ingin membantu memperbaiki Physiotherapy Pocket Handbook.

## Bentuk kontribusi

- koreksi typo/struktur
- koreksi prosedur pemeriksaan
- tambahan differential diagnosis atau red flags
- tambahan outcome measure
- pembaruan evidence/guideline
- note kondisi baru
- perbaikan navigasi dan wikilink

## Sebelum Pull Request

1. Jangan upload PDF/PPT/DOCX buku, slide dosen, rekam medis, foto pasien, atau laporan klinik asli.
2. Anonimkan semua contoh kasus.
3. Bedakan fakta sumber dengan sintesis/interpretasi.
4. Gunakan template di folder `templates/`.
5. Jalankan `python scripts/prepublish_check.py content`.
6. Pastikan wikilink tidak putus.

## Struktur minimum condition note

Definisi → anatomi/fisiologi relevan → patofisiologi → manifestasi → assessment → outcome → ICF/problem list → intervention → progression → evaluation → red flags → related notes.

## Evidence update

Untuk claim baru yang mengubah clinical decision, sertakan sumber. Prioritaskan guideline, systematic review, consensus, textbook standar, atau primary literature yang relevan. Jangan mengganti terminologi materi kampus diam-diam; jelaskan bila bagian merupakan pembaruan evidence eksternal.
