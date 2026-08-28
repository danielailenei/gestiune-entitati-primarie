# Aplicație Primărie – Gestiune entități

Aplicație web pentru evidența persoanelor fizice și a firmelor dintr-o primărie:
introducere de date, căutare, filtrare pe intervale numerice și rapoarte
totalizatoare. Acces protejat prin autentificare cu sesiuni PHP.

## Tehnologii

- PHP (procedural, `mysqli`)
- MySQL
- HTML / CSS (responsive, `@media max-width: 700px`)
- JavaScript (validare formulare pe client)

## Funcționalități

| Pagină | Descriere |
|--------|-----------|
| `login.php` / `logout.php` | Autentificare pe baza tabelei `users`, sesiune `$_SESSION["user"]` |
| `dashboard.php` | Pagina principală după login, numărători entități |
| `adauga_persoana.php` | Formular POST + `INSERT` în `persoane` (prepared statements) |
| `adauga_firma.php` | Formular POST + `INSERT` în `firme` |
| `cautare.php` | Căutare liberă cu `LIKE` pe toate coloanele, persoane / firme / ambele |
| `filtrare.php` | Filtre pe interval (`BETWEEN`): vârstă, angajați, profit, cifră de afaceri |
| `rapoarte.php` | Rapoarte agregate: `COUNT` / `AVG` / `SUM` cu `GROUP BY` și bucketing `CASE` |

## Structura proiectului

```
includes/     db.php (conexiune), auth.php (gardă sesiune), header.php, footer.php
assets/css/   style.css
assets/js/    script.js  (validare CNP / CUI / număr angajați)
sql/          schema + date de test
```

## Rulare locală (XAMPP)

1. Pornește Apache + MySQL din XAMPP.
2. Importă `sql/primarie_db(1).sql` în phpMyAdmin (creează baza `primarie`).
3. Copiază proiectul în `htdocs/`.
4. Deschide `http://localhost/proiect_final_AM/`.

Credențialele de conexiune sunt în `includes/db.php` (implicit XAMPP: user `root`,
fără parolă).
