# Deploy ke GitHub Pages

Kit menyertakan `.github/workflows/deploy.yml` yang build Quartz dan deploy folder `public`.

1. Push repository hasil bootstrap ke GitHub.
2. Buka **Settings → Pages**.
3. Source: **GitHub Actions**.
4. Set `baseUrl` di `quartz.config.yaml`.
   - Custom domain: `notes.example.com`
   - Project Pages tanpa custom domain: `username.github.io/repository-name`
5. Push perubahan ke branch `main`.
