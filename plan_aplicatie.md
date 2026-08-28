# PLANUL APLICAȚIEI – GESTIUNE ENTITĂȚI PRIMĂRIE

## 1. Scopul aplicației

Aplicația web permite gestionarea entităților unei primării din două categorii:

- persoane
- firme

Pentru fiecare categorie se pot introduce date, realiza căutări după criterii diferite și genera rapoarte totalizatoare.

Aplicația este realizată folosind:

- PHP
- MySQL
- HTML
- CSS
- JavaScript
- sesiuni PHP pentru autentificare

---

## 2. Structura bazei de date

Baza de date utilizată este:

primarie_db

Tabele:

### users

Utilizată pentru autentificare.

Câmpuri:

- id
- username
- password

---

### persoane

Utilizată pentru gestionarea persoanelor fizice.

Câmpuri:

- id
- cnp
- nume
- data_nasterii
- adresa
- telefon
- email
- created_at

---

### firme

Utilizată pentru gestionarea firmelor.

Câmpuri:

- id
- cui
- denumire
- numar_angajati
- adresa
- telefon
- email
- created_at

---

## 3. Fișierele aplicației

### index.php

Pagină de intrare.

Verifică dacă utilizatorul este autentificat și redirecționează către:

- login.php
sau
- dashboard.php

---

### login.php

Pagina de autentificare.

Primește date prin metoda POST:

- username
- password

Verifică existența utilizatorului în tabela users.

Dacă autentificarea reușește:

creează sesiunea:

$_SESSION["user"]

și redirecționează către dashboard.php

---

### logout.php

Distruge sesiunea activă și trimite utilizatorul înapoi la login.

---

### dashboard.php

Pagina principală după autentificare.

Conține meniul principal către toate funcționalitățile aplicației.

---

### adauga_persoana.php

Permite introducerea unei persoane noi.

Primește prin POST:

- cnp
- nume
- data_nasterii
- adresa
- telefon
- email

Execută INSERT în tabela persoane.

---

### adauga_firma.php

Permite introducerea unei firme noi.

Primește prin POST:

- cui
- denumire
- numar_angajati
- adresa
- telefon
- email

Execută INSERT în tabela firme.

---

### cautare.php

Permite căutarea entităților după:

- tip entitate
- CNP / CUI
- nume / denumire
- adresă
- telefon
- email

Execută SELECT cu filtrare folosind LIKE.

---

### rapoarte.php

Generează rapoarte totalizatoare:

- total persoane
- total firme
- total entități
- media angajaților
- minim / maxim angajați

și filtrări pe intervale:

- persoane după interval de vârstă
- firme după interval de angajați

---

## 4. Fișiere auxiliare

### includes/db.php

Realizează conexiunea cu baza de date MySQL.

---

### includes/auth.php

Verifică existența sesiunii și protejează paginile private.

---

### includes/header.php

Conține partea comună superioară:

- HTML
- meniu
- încărcare CSS

---

### includes/footer.php

Conține partea comună inferioară:

- footer
- încărcare JavaScript

---

## 5. JavaScript

Fișier:

assets/js/script.js

Este utilizat pentru validarea formularelor:

- verificare CNP
- verificare CUI
- verificare număr angajați

și confirmări suplimentare.

---

## 6. CSS Responsive

Fișier:

assets/css/style.css

Conține stilizarea aplicației și regula:

@media (max-width: 700px)

pentru afișarea corectă pe ecrane mici.

---

## 7. Fluxul aplicației

index.php

↓

login.php

↓

dashboard.php

↓

- adauga_persoana.php
- adauga_firma.php
- cautare.php
- rapoarte.php
- filtrare.php

↓

logout.php