# Publication Checklist

Sebelum repository dibuat public:

- [ ] Ganti `baseUrl` di `quartz.config.yaml`
- [ ] Ganti URL repository pada README/CITATION bila diperlukan
- [ ] Jalankan `python scripts/prepublish_check.py content`
- [ ] Pastikan tidak ada PDF/PPT/DOCX/source mentah
- [ ] Pastikan case library sudah anonim
- [ ] Review halaman Disclaimer dan Source Method
- [ ] Tentukan apakah lisensi CC BY-NC-SA 4.0 sudah sesuai
- [ ] Build lokal `npx quartz build`
- [ ] Cek tampilan mobile
- [ ] Cek search untuk istilah populer: Lachman, reflex, stroke, COPD, GMFM, 6MWT
- [ ] Cek broken links dari landing page
- [ ] Aktifkan branch protection jika menerima kontribusi publik
- [ ] Aktifkan GitHub Issues
- [ ] Deploy ke Cloudflare Pages atau GitHub Pages
