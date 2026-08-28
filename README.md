# Town Hall App – Entity Management

Web application for keeping records of persons and companies registered with a
town hall: data entry, search, numeric range filtering and aggregate reports.
Access is protected by PHP session authentication.

## Tech stack

- PHP (procedural, `mysqli`)
- MySQL / MariaDB
- HTML / CSS (responsive, `@media max-width: 700px`)
- JavaScript (client-side form validation)

## Features

| Page | Description |
|------|-------------|
| `login.php` / `logout.php` | Authentication against the `users` table, `$_SESSION["user"]` session |
| `dashboard.php` | Landing page after login, entity counts |
| `adauga_persoana.php` | POST form + `INSERT` into `persoane` (prepared statements, server-side validation) |
| `adauga_firma.php` | POST form + `INSERT` into `firme` (prepared statements, server-side validation) |
| `cautare.php` | Free-text search with `LIKE` across every column; persons / companies / both |
| `filtrare.php` | Range filters (`BETWEEN`): age, employees, profit, turnover |
| `rapoarte.php` | Aggregate reports: `COUNT` / `AVG` / `SUM` with `GROUP BY` and `CASE` bucketing |

## Project structure

```
includes/     db.php (connection), auth.php (session guard), header.php, footer.php
assets/css/   style.css
assets/js/    script.js  (CNP / CUI / employee-count validation)
sql/          schema + sample data
```

## Security

- SQL injection: all queries use prepared statements with bound parameters
- Stored XSS: all database values are escaped with `htmlspecialchars` on output
- Passwords: stored as bcrypt hashes (`password_hash` / `password_verify`)
- Session fixation: `session_regenerate_id(true)` on successful login
- Every private page is guarded by `includes/auth.php`

## Local setup

1. Start Apache and MySQL.
2. Import `sql/primarie_db(1).sql` (creates the `primarie` database with schema and sample data).
3. Place the project folder under the web root (e.g. `/var/www/html/proiect_final_AM`).
4. Open `http://localhost/proiect_final_AM/`.

Default login: `admin` / `admin123`. Connection settings are in `includes/db.php`
(local default: user `root`, no password).

See `DOCUMENTATION.md` for a full file-by-file and schema reference.
