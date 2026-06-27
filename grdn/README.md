# GRDN marketing site

A static, responsive marketing site and blog for GRDN, a mindful productivity app
by irons | design. No build step, no dependencies. Just HTML and one CSS file.

## Structure

```
grdn/
  index.html              Marketing home (hero, features, philosophy, social-feel, CTA, footer)
  styles.css              Shared stylesheet for every page
  blog/
    index.html            Blog index. Renders cards automatically from posts.js
    posts.js              The post manifest. One entry per post, newest first
    _template.html        Starter template for a new post
    tend-dont-grind.html
    quiet-accountability.html
    let-fields-lie-fallow.html
    pulling-weeds.html
  README.md
```

## How to add a new blog post

It takes two small steps.

1. **Create the post page.** Copy `blog/_template.html` to `blog/your-slug.html`
   and write it. Fill in the title, meta description, date, tag, read time, hero
   gradient, and body. Keep the GRDN voice: gentle, useful, anti-hustle, gardening
   metaphors where they earn their place. No em dashes in the copy.

2. **List it on the index.** Open `blog/posts.js` and add one object to the TOP of
   the array (newest first):

   ```js
   {
     slug: "your-slug",          // matches your-slug.html
     title: "Your Title",
     tag: "Focus",                // Mindset, Focus, Rest, Attention, etc.
     date: "2026-07-01",          // YYYY-MM-DD
     readtime: "5 min read",
     excerpt: "One or two sentences that pull the reader in.",
     gradient: "linear-gradient(150deg,#7FB069,#68B0AA)"
   }
   ```

The blog index builds its cards from that array, so there is nothing else to edit.

## Brand notes

- **Wordmark:** GRDN, with each letter on its own pastel gradient (blue G, green R,
  gold D, coral N), matching the app icon. It is built in CSS, so it stays crisp at
  any size. See `.wordmark` in `styles.css`.
- **Palette:** warm charcoal-green surfaces, cream type, sage and teal accents, with
  gold and coral as warm highlights. CSS variables live at the top of `styles.css`.
- **Type:** Fraunces (a soft, organic serif) for headings, Inter for body.
- **Voice:** calm, intentional, anti-burnout. Productivity reframed as gardening.

## Deploy

Static files. Served from GitHub Pages at `giddyuptiger.github.io/grdn/`.
Primary CTA points to the App Store listing; the canonical product domain is
grdnapp.com. To publish, copy this folder to the Pages repo, commit, and push.
