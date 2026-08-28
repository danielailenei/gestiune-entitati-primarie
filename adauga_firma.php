<?php
// Formular de adăugare firmă — salvează datele din POST în tabela firme
include("includes/auth.php");
include("includes/db.php");

$mesaj  = "";
$eroare = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // "?? """ evită warning-ul "Undefined array key" dacă un câmp lipsește din POST;
    // trim() scoate spațiile de la capete, ca un câmp cu doar spații să conteze gol
    $cui               = trim($_POST["cui"] ?? "");
    $denumire          = trim($_POST["denumire"] ?? "");
    $numar_angajati    = trim($_POST["numar_angajati"] ?? "");
    $domeniu_activitate= trim($_POST["domeniu_activitate"] ?? "");
    $capital_social    = trim($_POST["capital_social"] ?? "");
    $cifra_afaceri     = trim($_POST["cifra_afaceri"] ?? "");
    $profit            = trim($_POST["profit"] ?? "");
    $an_infiintare     = trim($_POST["an_infiintare"] ?? "");
    $adresa            = trim($_POST["adresa"] ?? "");
    $telefon           = trim($_POST["telefon"] ?? "");
    $email             = trim($_POST["email"] ?? "");

    // Validare pe server — JS-ul (valideazaFirma) poate fi dezactivat sau ocolit
    // printr-un request POST direct. Adunăm toate erorile într-o listă.
    $erori = [];

    if ($cui === "" || strlen($cui) > 20) {
        $erori[] = "CUI-ul este obligatoriu (maxim 20 de caractere).";
    }
    if ($denumire === "" || strlen($denumire) > 100) {
        $erori[] = "Denumirea este obligatorie (maxim 100 de caractere).";
    }
    if (!ctype_digit($numar_angajati)) {
        $erori[] = "Numărul de angajați trebuie să fie un întreg mai mare sau egal cu 0.";
    }
    if ($an_infiintare !== "" && (!ctype_digit($an_infiintare) || $an_infiintare < 1900 || $an_infiintare > date("Y"))) {
        $erori[] = "Anul înființării trebuie să fie între 1900 și " . date("Y") . ".";
    }
    if ($capital_social !== "" && (!is_numeric($capital_social) || $capital_social < 0)) {
        $erori[] = "Capitalul social trebuie să fie un număr pozitiv.";
    }
    if ($cifra_afaceri !== "" && (!is_numeric($cifra_afaceri) || $cifra_afaceri < 0)) {
        $erori[] = "Cifra de afaceri trebuie să fie un număr pozitiv.";
    }
    if ($profit !== "" && !is_numeric($profit)) {
        $erori[] = "Profitul trebuie să fie un număr (poate fi și negativ).";
    }
    if ($email !== "" && !filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $erori[] = "Adresa de email nu este validă.";
    }

    if (count($erori) > 0) {
        $eroare = implode("<br>", $erori);
    } else {
        // Prepared statement — numerele merg cu tipul lor (i/d), textul cu "s"
        $stmt = mysqli_prepare($conn, "INSERT INTO firme
                (cui, denumire, numar_angajati, domeniu_activitate, capital_social, cifra_afaceri, profit, an_infiintare, adresa, telefon, email)
                VALUES (?,?,?,?,?,?,?,?,?,?,?)");
        mysqli_stmt_bind_param($stmt, "ssisdddisss",
            $cui, $denumire, $numar_angajati, $domeniu_activitate, $capital_social, $cifra_afaceri, $profit, $an_infiintare, $adresa, $telefon, $email);

        if (mysqli_stmt_execute($stmt)) {
            $mesaj = "Firma a fost adăugată cu succes!";
        } else {
            $eroare = "Eroare la adăugare: " . mysqli_stmt_error($stmt);
        }
    }
}

include("includes/header.php");
?>

<div class="card">
    <h2>Adaugă firmă</h2>

    <?php if ($mesaj != ""): ?>
        <div class="mesaj-succes"><?php echo $mesaj; ?></div>
    <?php endif; ?>

    <?php if ($eroare != ""): ?>
        <div class="mesaj-eroare"><?php echo $eroare; ?></div>
    <?php endif; ?>

    <form method="POST" action="" onsubmit="return valideazaFirma();">

        <!-- Secțiunea: Date de identificare -->
        <div class="form-sectiune">
            <div class="form-sectiune-titlu">Date de identificare</div>

            <div class="form-grup">
                <label for="cui">CUI <span style="color:var(--error)">*</span></label>
                <input type="text" id="cui" name="cui" maxlength="20" placeholder="ex: RO12345678" required>
                <span class="camp-eroare" id="err-cui">CUI-ul este obligatoriu.</span>
            </div>

            <div class="form-grup">
                <label for="denumire">Denumire firmă <span style="color:var(--error)">*</span></label>
                <input type="text" id="denumire" name="denumire" placeholder="ex: Alfa Construct SRL" required>
            </div>

            <div class="form-grup">
                <label for="an_infiintare">An înființare</label>
                <input type="number" id="an_infiintare" name="an_infiintare" min="1900" max="<?php echo date('Y'); ?>" placeholder="ex: 2010">
            </div>

            <div class="form-grup">
                <label for="domeniu_activitate">Domeniu de activitate</label>
                <select id="domeniu_activitate" name="domeniu_activitate">
                    <option value="">Selectează domeniul</option>
                    <option value="Construcții">Construcții</option>
                    <option value="Comerț">Comerț</option>
                    <option value="IT">IT</option>
                    <option value="Transport">Transport</option>
                    <option value="Producție">Producție</option>
                    <option value="Servicii">Servicii</option>
                    <option value="Agricultură">Agricultură</option>
                    <option value="Medical">Medical</option>
                    <option value="Educație">Educație</option>
                    <option value="Altele">Altele</option>
                </select>
            </div>
        </div>

        <!-- Secțiunea: Date financiare -->
        <div class="form-sectiune">
            <div class="form-sectiune-titlu">Date financiare</div>

            <div class="form-grup">
                <label for="numar_angajati">Număr angajați <span style="color:var(--error)">*</span></label>
                <input type="number" id="numar_angajati" name="numar_angajati" min="0" placeholder="ex: 25" required>
                <span class="camp-eroare" id="err-angajati">Numărul de angajați nu poate fi negativ.</span>
            </div>

            <div class="form-grup">
                <label for="capital_social">Capital social (RON)</label>
                <input type="number" id="capital_social" name="capital_social" min="0" step="0.01" placeholder="ex: 200.00">
            </div>

            <div class="form-grup">
                <label for="cifra_afaceri">Cifră de afaceri (RON)</label>
                <input type="number" id="cifra_afaceri" name="cifra_afaceri" step="0.01" placeholder="ex: 150000.00">
            </div>

            <div class="form-grup">
                <label for="profit">Profit (RON)</label>
                <input type="number" id="profit" name="profit" step="0.01" placeholder="ex: 30000.00 (negativ dacă pierdere)">
            </div>
        </div>

        <!-- Secțiunea: Date de contact -->
        <div class="form-sectiune">
            <div class="form-sectiune-titlu">Date de contact</div>

            <div class="form-grup">
                <label for="adresa">Adresă sediu</label>
                <input type="text" id="adresa" name="adresa" placeholder="Stradă, număr, localitate">
            </div>

            <div class="form-grup">
                <label for="telefon">Telefon</label>
                <input type="text" id="telefon" name="telefon" placeholder="ex: 0212 345 678">
            </div>

            <div class="form-grup">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="ex: contact@firma.ro">
            </div>
        </div>

        <button type="submit">💾 Salvează firma</button>
    </form>
</div>

<?php include("includes/footer.php"); ?>
