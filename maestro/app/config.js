// Maestro web app config. The anon key is PUBLIC by design (Row-Level Security protects
// data) — it is safe to commit. Fill these from the product Supabase project, then deploy.
// See docs/PRODUCT-SETUP.md.
window.MAESTRO_CONFIG = {
  SUPABASE_URL: "https://cixmyhdzzbgbltmitzkb.supabase.co",
  SUPABASE_ANON_KEY:
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNpeG15aGR6emJnYmx0bWl0emtiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODA0MjYxMzEsImV4cCI6MjA5NjAwMjEzMX0.vjWESdexsMOLlqRAQXTV81gQ709ZN3v_K6HgtjCtulY",
  // The user's OWN per-user dashboard (same app, data scoped to their auth.uid()).
  // Relative + same-origin so it works wherever the app is hosted — and so it never
  // points a product user at anyone else's dashboard.
  DASHBOARD_URL: "./dashboard.html",
};
