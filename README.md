# PocketLedger — Expense Tracker

A responsive, static expense tracker designed for free GitHub Pages hosting. It supports income and expenses, long-term transaction history, budgets, reports, CSV export, JSON backup/restore, and optional cloud sync across devices using Supabase.

## Important: how data is stored

- **Local mode:** records are stored in this browser's `localStorage`. They remain after closing the browser, but are not automatically available on another device and can be lost if browser data is cleared.
- **Cloud mode:** connect a free Supabase project and sign in. Transactions and budgets are saved to your private cloud account, so you can access them from another browser/device. Do not put a Supabase service-role/secret key in this static app. Use only the project URL and public anon/publishable key.
- Keep regular JSON backups. This app is a personal tracker, not a bank or audited accounting system.

## Features

- Dashboard: all-time balance, monthly income/expenses, savings rate, six-month cash-flow chart
- Add, edit, delete transactions; expense/income types, categories, date, notes/merchant, payment method
- Search and filter history; selected month, all-time, last 30/90 days
- Monthly category budgets with progress and overspend warning
- Reports, category breakdown, average expense, CSV export
- JSON backup and restore
- Responsive desktop/mobile UI
- Local-first use; optional Supabase Auth + database sync
- Per-user Row Level Security policies in the included SQL schema

## Publish on GitHub Pages (free)

1. Create a GitHub repository, e.g. `pocketledger`.
2. Upload **all files in this folder** to the repository root: `index.html`, `styles.css`, `app.js`, `supabase-schema.sql`, `README.md`.
3. In the repository, open **Settings → Pages**.
4. Under **Build and deployment**, select **Deploy from a branch**, choose branch `main` and folder `/ (root)`, then Save.
5. Wait for GitHub Pages to publish. The URL will look like `https://YOUR-USERNAME.github.io/pocketledger/`.

No build step or paid hosting is needed.

## Enable cross-device cloud sync (free Supabase tier)

1. Create a project at [Supabase](https://supabase.com/).
2. Open **SQL Editor**, paste the contents of `supabase-schema.sql`, and run it.
3. In **Project Settings → API** (or **Data API / API Keys**, depending on dashboard version), copy the **Project URL** and the **public anon/publishable key**. Never use a service-role or secret key in the browser.
4. Open your published PocketLedger URL, choose **Settings & backup** (gear icon), paste URL and public key, then click **Connect cloud**.
5. Click **Sign in / create account**, enter your email and a password of at least 6 characters. Supabase may require you to confirm your email before signing in.
6. In Supabase Auth settings, configure the site's URL and redirect URL for your GitHub Pages URL if email confirmation is enabled.
7. Once signed in, cloud records load from Supabase and new/edited/deleted transactions and budgets sync to it. Open the same URL on another device, connect the same Supabase project, and sign in with the same account.

### Security notes

- The public anon/publishable key is intended for browser use; database Row Level Security is what protects user records. Run the included SQL and do not disable RLS.
- The cloud setup does not migrate pre-existing local records automatically on first connection. If you already entered local data, export a JSON backup first. Restore that backup after signing in to upload its records, or use the restore tool while connected.
- Avoid using the app on a shared/public computer, and sign out after use.
- This starter app is provided as-is. Test with sample transactions before relying on it for important records.

## Local preview

Open `index.html` directly in a browser for local mode. Cloud auth may require serving it from a web origin; GitHub Pages is the recommended way to use cloud mode.
