# Deploy ke Cloudflare Pages

1. Jalankan `scripts/bootstrap-quartz5.sh` dan push hasil repository ke GitHub.
2. Di Cloudflare dashboard pilih **Workers & Pages → Create application → Pages → Connect to Git**.
3. Pilih repository.
4. Production branch: `main`.
5. Framework preset: `None`.
6. Build command: `npx quartz plugin install && npx quartz build`.
7. Output directory: `public`.
8. Set `baseUrl` pada `quartz.config.yaml` ke domain final tanpa `https://`.

Setiap push ke `main` akan memicu build baru.
