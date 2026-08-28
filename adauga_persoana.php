<?php
// Formular de adăugare persoană fizică — salvează datele din POST în tabela persoane
include("includes/auth.php");
include("includes/db.php");

$mesaj  = "";
$eroare = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // "?? """ evită warning-ul "Undefined array key" dacă un câmp lipsește din POST;
    // trim() scoate spațiile de la capete, ca un câmp cu doar spații să conteze gol
    $cnp          = trim($_POST["cnp"] ?? "");
    $nume         = trim($_POST["nume"] ?? "");
    $data_nasterii= trim($_POST["data_nasterii"] ?? "");
    $studii       = trim($_POST["studii"] ?? "");
    $mediu        = trim($_POST["mediu"] ?? "");
    $stare_civila = trim($_POST["stare_civila"] ?? "");
    $ocupatie     = trim($_POST["ocupatie"] ?? "");
    $adresa       = trim($_POST["adresa"] ?? "");
    $telefon      = trim($_POST["telefon"] ?? "");
    $email        = trim($_POST["email"] ?? "");

    // Validare pe server — nu ne bazăm pe validarea din JS, care poate fi
    // dezactivată sau ocolită (request POST direct). Adunăm toate erorile
    // într-o listă ca utilizatorul să le vadă pe toate deodată.
    $erori = [];

    if (!preg_match('/^\d{13}$/', $cnp)) {
        $erori[] = "CNP-ul trebuie să conțină exact 13 cifre.";
    }
    if ($nume === "") {
        $erori[] = "Numele este obligatoriu.";
    }
    if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $data_nasterii) || $data_nasterii > date("Y-m-d")) {
        $erori[] = "Data nașterii este obligatorie și nu poate fi în viitor.";
    }
    if ($studii === "" || $mediu === "" || $stare_civila === "" || $ocupatie === "") {
        $erori[] = "Toate câmpurile socio-demografice sunt obligatorii.";
    }
    if ($email !== "" && !filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $erori[] = "Adresa de email nu este validă.";
    }

    if (count($erori) > 0) {
        $eroare = implode("<br>", $erori);
    } else {
        // Prepared statement — toate valorile din POST sunt legate ca parametri, nu concatenate în SQL
        $stmt = mysqli_prepare($conn, "INSERT INTO persoane
                (cnp, nume, data_nasterii, studii, mediu, stare_civila, ocupatie, adresa, telefon, email)
                VALUES (?,?,?,?,?,?,?,?,?,?)");
        mysqli_stmt_bind_param($stmt, "ssssssssss",
            $cnp, $nume, $data_nasterii, $studii, $mediu, $stare_civila, $ocupatie, $adresa, $telefon, $email);

        if (mysqli_stmt_execute($stmt)) {
            $mesaj = "Persoana a fost adăugată cu succes!";
        } else {
            $eroare = "Eroare la adăugare: " . mysqli_stmt_error($stmt);
        }
    }
}

include("includes/header.php");
?>

<div class="card">
    <h2>Adaugă persoană</h2>

    <?php if ($mesaj != ""): ?>
        <div class="mesaj-succes"><?php echo $mesaj; ?></div>
    <?php endif; ?>

    <?php if ($eroare != ""): ?>
        <div class="mesaj-eroare"><?php echo $eroare; ?></div>
    <?php endif; ?>

    <form method="POST" action="" onsubmit="return valideazaPersoana();">

        <!-- Secțiunea: Date de identificare -->
        <div class="form-sectiune">
            <div class="form-sectiune-titlu">Date de identificare</div>

            <div class="form-grup">
                <label for="cnp">CNP <span style="color:var(--error)">*</span></label>
                <input type="text" id="cnp" name="cnp" maxlength="13" placeholder="13 cifre" required>
                <span class="camp-eroare" id="err-cnp">CNP-ul trebuie să conțină exact 13 cifre.</span>
            </div>

            <div class="form-grup">
                <label for="nume">Nume complet <span style="color:var(--error)">*</span></label>
                <input type="text" id="nume" name="nume" placeholder="ex: Popescu Ion" required>
                <span class="camp-eroare" id="err-nume">Numele este obligatoriu.</span>
            </div>

            <div class="form-grup">
                <label for="data_nasterii">Data nașterii <span style="color:var(--error)">*</span></label>
                <input type="date" id="data_nasterii" name="data_nasterii" required>
            </div>
        </div>

        <!-- Secțiunea: Date socio-demografice -->
        <div class="form-sectiune">
            <div class="form-sectiune-titlu">Date socio-demografice</div>

            <div class="form-grup">
                <label for="studii">Studii <span style="color:var(--error)">*</span></label>
                <select id="studii" name="studii" required>
                    <option value="">Selectează nivelul studiilor</option>
                    <option value="Gimnaziale">Gimnaziale</option>
                    <option value="Liceale">Liceale</option>
                    <option value="Postliceale">Postliceale</option>
                    <option value="Universitare">Universitare</option>
                    <option value="Masterat">Masterat</option>
                    <option value="Doctorat">Doctorat</option>
                </select>
            </div>

            <div class="form-grup">
                <label for="mediu">Mediu <span style="color:var(--error)">*</span></label>
                <select id="mediu" name="mediu" required>
                    <option value="">Selectează mediul</option>
                    <option value="Urban">Urban</option>
                    <option value="Rural">Rural</option>
                </select>
            </div>

            <div class="form-grup">
                <label for="stare_civila">Stare civilă <span style="color:var(--error)">*</span></label>
                <select id="stare_civila" name="stare_civila" required>
                    <option value="">Selectează starea civilă</option>
                    <option value="Necăsătorit/ă">Necăsătorit/ă</option>
                    <option value="Căsătorit/ă">Căsătorit/ă</option>
                    <option value="Divorțat/ă">Divorțat/ă</option>
                    <option value="Văduv/ă">Văduv/ă</option>
                </select>
            </div>

            <div class="form-grup">
                <label for="ocupatie">Ocupație <span style="color:var(--error)">*</span></label>
                <select id="ocupatie" name="ocupatie" required>
                    <option value="">Selectează ocupația</option>
                    <option value="Elev">Elev</option>
                    <option value="Student">Student</option>
                    <option value="Angajat">Angajat</option>
                    <option value="Șomer">Șomer</option>
                    <option value="Pensionar">Pensionar</option>
                    <option value="Antreprenor">Antreprenor</option>
                </select>
            </div>
        </div>

        <!-- Secțiunea: Date de contact -->
        <div class="form-sectiune">
            <div class="form-sectiune-titlu">Date de contact</div>

            <div class="form-grup">
                <label for="adresa">Adresă</label>
                <input type="text" id="adresa" name="adresa" placeholder="Stradă, număr, localitate">
            </div>

            <div class="form-grup">
                <label for="telefon">Telefon</label>
                <input type="text" id="telefon" name="telefon" placeholder="ex: 0712 345 678">
            </div>

            <div class="form-grup">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="ex: ion.popescu@email.ro">
            </div>
        </div>

        <button type="submit">💾 Salvează persoana</button>
    </form>
</div>

<?php include("includes/footer.php"); ?>
