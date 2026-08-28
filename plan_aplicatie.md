# Application Documentation — Town Hall Entity Management

## 1. Purpose

A small web application a town hall clerk uses to keep records of two kinds of
entities:

- **persons** (citizens / natural persons)
- **companies** (legal entities registered with the town hall)

For each kind the app supports: adding records, free-text search, range filtering
on numeric fields, and aggregate reports. Every page except the login screen
requires an authenticated session.

## 2. Tech stack

| Layer            | Choice                                                        |
|------------------|--------------------------------------------------------------|
| Language         | PHP (procedural style, `mysqli`)                             |
| Database         | MySQL / MariaDB                                              |
| Frontend         | Server-rendered HTML + CSS (responsive, breakpoint 700px)   |
| Client scripting | Plain JavaScript (form validation, inline error messages)   |
| Auth             | PHP sessions (`$_SESSION["user"]`)                          |
| Web server       | Apache (`mod_alias`, used by `.htaccess`)                   |

## 3. Database

Connection settings live in `includes/db.php`. Local default: host `localhost`,
user `root`, no password, database **`primarie`**.

### Table `users` — login accounts

| Column     | Type                     | Notes                                          |
|------------|--------------------------|------------------------------------------------|
| `id`       | int, PK, auto-increment  |                                                |
| `username` | varchar(50)              | unique                                         |
| `password` | varchar(255)             | **bcrypt hash** (`password_hash`), not plain   |

### Table `persoane` — persons

| Column          | Type                    | Notes                                  |
|-----------------|-------------------------|----------------------------------------|
| `id`            | int, PK, auto-increment |                                        |
| `cnp`           | varchar(13)             | unique — national ID, exactly 13 digits|
| `nume`          | varchar(100)            | full name, required                    |
| `data_nasterii` | date                    | date of birth                          |
| `studii`        | varchar(50)             | education level                        |
| `mediu`         | varchar(20)             | urban / rural                          |
| `stare_civila`  | varchar(30)             | marital status                         |
| `ocupatie`      | varchar(50)             | occupation                             |
| `adresa`        | varchar(255)            |                                        |
| `telefon`       | varchar(20)             |                                        |
| `email`         | varchar(100)            |                                        |
| `created_at`    | timestamp               | set automatically                      |

### Table `firme` — companies

| Column               | Type                    | Notes                             |
|----------------------|-------------------------|-----------------------------------|
| `id`                 | int, PK, auto-increment |                                   |
| `cui`                | varchar(20)             | unique — fiscal registration code |
| `denumire`           | varchar(100)            | company name, required            |
| `numar_angajati`     | int                     | employee count, >= 0              |
| `domeniu_activitate` | varchar(100)            | industry / field of activity      |
| `capital_social`     | decimal(12,2)           | share capital                     |
| `cifra_afaceri`      | decimal(14,2)           | turnover                          |
| `profit`             | decimal(14,2)           | may be negative                   |
| `an_infiintare`      | int                     | founding year                     |
| `adresa`             | varchar(255)            |                                   |
| `telefon`            | varchar(20)             |                                   |
| `email`              | varchar(100)            |                                   |
| `created_at`         | timestamp               | set automatically                 |

The dump `sql/primarie_db(1).sql` also contains a stored procedure
`populeaza_persoane_reale()` that inserts 100 sample persons, plus sample
company rows.

## 4. Files

### Entry and authentication

**`index.php`** — entry point. Starts the session; redirects to `dashboard.php`
if the visitor is logged in, otherwise to `login.php`.

**`login.php`** — login form (POST `username`, `password`).

- Looks up the user by `username` only, using a prepared statement.
- Verifies the password with `password_verify()` against the stored bcrypt hash
  (constant-time; the password is never compared inside SQL).
- On success: `session_regenerate_id(true)` (defends against session fixation),
  then sets `$_SESSION["user"]` and redirects to the dashboard.
- On failure: shows a generic error and keeps the typed username in the field
  (escaped with `htmlspecialchars`).

**`logout.php`** — destroys the session and redirects to `login.php`.

**`includes/auth.php`** — included at the top of every private page. Starts the
session; if `$_SESSION["user"]` is missing, redirects to `login.php` and stops.

### Main pages

**`dashboard.php`** — landing page after login. Shows counts (persons, companies,
total) and quick-access cards to the other pages.

**`adauga_persoana.php`** — add a person. On POST:

- Reads every field with `trim(... ?? "")`.
- Server-side validation (independent of the JS): `cnp` exactly 13 digits;
  `nume` required; `data_nasterii` in `YYYY-MM-DD` and not in the future;
  `studii` / `mediu` / `stare_civila` / `ocupatie` all required; `email` valid
  if provided.
- Collects all errors into a list and shows them together, or runs a prepared
  `INSERT` into `persoane`.

**`adauga_firma.php`** — add a company. Same shape, for `firme`:

- Validation: `cui` required and <= 20 chars; `denumire` required and <= 100
  chars; `numar_angajati` a non-negative integer; optional numeric fields
  (`capital_social`, `cifra_afaceri` >= 0; `profit` any number; `an_infiintare`
  between 1900 and the current year); `email` valid if provided.
- Prepared `INSERT` with a typed bind string (`ssisdddisss`).

**`cautare.php`** — free-text search. Inputs: entity type (persons / companies /
both) and one search term. Builds `"%term%"` and passes it as a bound parameter
into a `LIKE` on every column of the chosen table(s) — 10 columns for persons,
11 for companies. Results render in tables; every value is escaped with
`htmlspecialchars`.

**`filtrare.php`** — numeric range filters (`BETWEEN`), four independent forms:

| Filter    | Table      | Field                                   |
|-----------|------------|-----------------------------------------|
| age       | `persoane` | age computed from `data_nasterii`       |
| employees | `firme`    | `numar_angajati`                        |
| profit    | `firme`    | `profit`                                |
| turnover  | `firme`    | `cifra_afaceri`                         |

Each form shows a result table, or an empty-state message when a submitted
filter returns no rows. All output is escaped.

**`rapoarte.php`** — aggregate reports, selected via `?raport=...`:

| `raport=`         | Report                                                     |
|-------------------|-----------------------------------------------------------|
| `general`         | totals: persons, companies, entities; avg/min/max employees |
| `varsta`          | persons grouped into age buckets (`CASE`)                 |
| `studii`          | persons by education level                                |
| `mediu`           | persons by urban / rural                                  |
| `stare_civila`    | persons by marital status                                 |
| `ocupatie`        | persons by occupation                                     |
| `domenii`         | companies by industry                                     |
| `cifra_afaceri`   | total turnover per industry (`SUM`)                       |
| `profit`          | total profit per industry (`SUM`)                         |
| `capital`         | total share capital per industry (`SUM`)                  |
| `profitabilitate` | count of profitable vs. loss-making companies             |
| `vechime`         | companies grouped into age buckets by `an_infiintare`     |

Text columns are escaped with `htmlspecialchars`.

### Shared includes

**`includes/db.php`** — opens the MySQL connection into `$conn`; stops with a
message if it fails.

**`includes/header.php`** — common top of every page: `<!DOCTYPE>`, CSS link,
site header, the nav menu (Dashboard, Add person, Add company, Search, Reports,
Filter, Logout) and the logged-in username. Starts the session if it is not
already running.

**`includes/footer.php`** — closes the layout, prints the footer with the current
year, loads `assets/js/script.js`.

### Assets

**`assets/css/style.css`** — all styling; responsive rule at
`@media (max-width: 700px)`.

**`assets/js/script.js`** — client-side checks that run before the add forms
submit:

- `valideazaPersoana()` — `cnp` is exactly 13 digits; `nume` is not empty.
- `valideazaFirma()` — `cui` is not empty; `numar_angajati` is not negative.
- Invalid fields get an `invalid` class and an inline message; the message
  clears as soon as the user edits the field.
- This is a convenience layer only — the authoritative validation is server-side
  (see the `adauga_*` pages).

### Configuration

**`.htaccess`** — `RedirectMatch 404 /\.git` so the `.git` directory and
`.gitignore` are not served over HTTP. Needs the Apache site config to allow
overrides for this directory (`AllowOverride FileInfo` or broader).

**`.gitignore`** — files kept out of version control.

## 5. Security measures

| Concern                | Handling                                                              |
|------------------------|---------------------------------------------------------------------- |
| SQL injection          | every query uses `mysqli_prepare` + bound parameters; no user value concatenated into SQL |
| Stored XSS             | every DB value printed into HTML goes through `htmlspecialchars`      |
| Password storage       | bcrypt via `password_hash` / `password_verify`; no plain-text passwords |
| Session fixation       | `session_regenerate_id(true)` on successful login                    |
| Unauthenticated access | `includes/auth.php` guards every private page                        |
| Client-side bypass     | all add-form rules are re-checked on the server                      |
| Source exposure        | `.htaccess` blocks web access to `.git`                              |

## 6. Request flow

```
index.php
   |-- not logged in --> login.php --> (valid credentials) --> dashboard.php
   \-- logged in ----------------------------------------------> dashboard.php

dashboard.php --> adauga_persoana.php
             --> adauga_firma.php
             --> cautare.php
             --> filtrare.php
             --> rapoarte.php
             --> logout.php --> login.php
```

Every page above except `login.php` includes `includes/auth.php` first, which
sends anonymous visitors back to the login screen.

## 7. Local setup

1. Start Apache and MySQL.
2. Import `sql/primarie_db(1).sql` — this creates the `primarie` database with
   the schema and sample data.
3. Place the project folder under the web root (for example
   `/var/www/html/proiect_final_AM`).
4. To use `.htaccess`, make sure the Apache config allows overrides for that
   directory (`AllowOverride FileInfo` or broader), then reload Apache.
5. Open `http://localhost/proiect_final_AM/`.
6. Default login: `admin` / `admin123` (the stored hash matches this password).

Connection settings: `includes/db.php`.
