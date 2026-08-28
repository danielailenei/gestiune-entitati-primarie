// Validare formulare și interacțiuni UI — mesaje de eroare inline, fără alert()

/* ── Utilitar: marchează un câmp ca invalid ── */
function marcheazaInvalid(idCamp, idEroare) {
    var camp = document.getElementById(idCamp);
    var err  = document.getElementById(idEroare);
    if (camp) camp.classList.add("invalid");
    if (err)  err.classList.add("vizibil");
}

/* ── Utilitar: curăță erorile de pe un câmp ── */
function curataCamp(idCamp, idEroare) {
    var camp = document.getElementById(idCamp);
    var err  = document.getElementById(idEroare);
    if (camp) camp.classList.remove("invalid");
    if (err)  err.classList.remove("vizibil");
}

/* ── Validare formular Adaugă Persoană ── */
function valideazaPersoana() {
    var valid = true;

    // Curățăm erorile anterioare
    curataCamp("cnp", "err-cnp");
    curataCamp("nume", "err-nume");

    var cnp  = document.getElementById("cnp").value.trim();
    var nume = document.getElementById("nume").value.trim();

    // Validare CNP: exact 13 cifre
    if (cnp.length !== 13 || !/^\d{13}$/.test(cnp)) {
        marcheazaInvalid("cnp", "err-cnp");
        valid = false;
    }

    // Validare nume: obligatoriu
    if (nume === "") {
        marcheazaInvalid("nume", "err-nume");
        valid = false;
    }

    return valid;
}

/* ── Validare formular Adaugă Firmă ── */
function valideazaFirma() {
    var valid = true;

    // Curățăm erorile anterioare
    curataCamp("cui", "err-cui");
    curataCamp("numar_angajati", "err-angajati");

    var cui      = document.getElementById("cui").value.trim();
    var angajati = parseInt(document.getElementById("numar_angajati").value, 10);

    // Validare CUI: obligatoriu
    if (cui === "") {
        marcheazaInvalid("cui", "err-cui");
        valid = false;
    }

    // Validare angajați: nu poate fi negativ
    if (isNaN(angajati) || angajati < 0) {
        marcheazaInvalid("numar_angajati", "err-angajati");
        valid = false;
    }

    return valid;
}

/* ── Confirmare ștergere (pentru extinderi viitoare) ── */
function confirmareStergere() {
    return confirm("Sigur vrei să ștergi această înregistrare? Acțiunea este ireversibilă.");
}

/* ── Curățare eroare la input (feedback imediat) ── */
document.addEventListener("DOMContentLoaded", function () {
    var campuri = document.querySelectorAll("input, select");
    campuri.forEach(function (camp) {
        camp.addEventListener("input", function () {
            this.classList.remove("invalid");
            var idEroare = "err-" + this.id;
            var eroare = document.getElementById(idEroare);
            if (eroare) eroare.classList.remove("vizibil");
        });
    });
});
