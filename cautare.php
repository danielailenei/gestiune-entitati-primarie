<?php
// Căutare entități (persoane/firme/ambele) după criteriul introdus, pe mai multe coloane cu LIKE
include("includes/auth.php");
include("includes/db.php");
include("includes/header.php");

$tip      = "";
$criteriu = "";
$rezultate_persoane = false;
$rezultate_firme    = false;
$cautare_efectuata  = false;

if ($_SERVER["REQUEST_METHOD"] == "GET" && isset($_GET["cauta"])) {
    $tip             = $_GET["tip"];
    $criteriu        = $_GET["criteriu"];
    $cautare_efectuata = true;

    // "%...%" se construiește înainte de bind — parametrul rămâne mereu date, nu SQL
    $like = "%$criteriu%";

    if ($tip == "persoane" || $tip == "toate") {
        $stmt = mysqli_prepare($conn, "SELECT * FROM persoane
                         WHERE cnp LIKE ?
                         OR nume LIKE ?
                         OR data_nasterii LIKE ?
                         OR studii LIKE ?
                         OR mediu LIKE ?
                         OR stare_civila LIKE ?
                         OR ocupatie LIKE ?
                         OR adresa LIKE ?
                         OR telefon LIKE ?
                         OR email LIKE ?");
        mysqli_stmt_bind_param($stmt, str_repeat("s", 10), $like, $like, $like, $like, $like, $like, $like, $like, $like, $like);
        mysqli_stmt_execute($stmt);
        $rezultate_persoane = mysqli_stmt_get_result($stmt);
    }

    if ($tip == "firme" || $tip == "toate") {
        $stmt = mysqli_prepare($conn, "SELECT * FROM firme
                      WHERE cui LIKE ?
                      OR denumire LIKE ?
                      OR numar_angajati LIKE ?
                      OR domeniu_activitate LIKE ?
                      OR capital_social LIKE ?
                      OR cifra_afaceri LIKE ?
                      OR profit LIKE ?
                      OR an_infiintare LIKE ?
                      OR adresa LIKE ?
                      OR telefon LIKE ?
                      OR email LIKE ?");
        mysqli_stmt_bind_param($stmt, str_repeat("s", 11), $like, $like, $like, $like, $like, $like, $like, $like, $like, $like, $like);
        mysqli_stmt_execute($stmt);
        $rezultate_firme = mysqli_stmt_get_result($stmt);
    }
}
?>

<div class="card">
    <h2>Căutare entități</h2>

    <!-- Formular căutare -->
    <form method="GET" action="" class="cautare-form">
        <div class="form-grup">
            <label for="tip">Tip entitate</label>
            <select id="tip" name="tip">
                <option value="toate" <?php echo ($tip == "toate") ? "selected" : ""; ?>>Toate</option>
                <option value="persoane" <?php echo ($tip == "persoane") ? "selected" : ""; ?>>Persoane</option>
                <option value="firme" <?php echo ($tip == "firme") ? "selected" : ""; ?>>Firme</option>
            </select>
        </div>

        <div class="form-grup">
            <label for="criteriu">Criteriu căutare</label>
            <input type="text" id="criteriu" name="criteriu"
                   placeholder="CNP, CUI, nume, studii, domeniu, email..."
                   value="<?php echo htmlspecialchars($criteriu); ?>">
        </div>

        <button type="submit" name="cauta">🔍 Caută</button>
    </form>

    <?php if ($cautare_efectuata): ?>

        <!-- Rezultate persoane -->
        <?php if ($rezultate_persoane && mysqli_num_rows($rezultate_persoane) > 0): ?>
            <h3>👤 Rezultate persoane (<?php echo mysqli_num_rows($rezultate_persoane); ?>)</h3>
            <div class="tabel-container">
                <table>
                    <thead>
                        <tr>
                            <th>CNP</th>
                            <th>Nume</th>
                            <th>Data nașterii</th>
                            <th>Studii</th>
                            <th>Mediu</th>
                            <th>Stare civilă</th>
                            <th>Ocupație</th>
                            <th>Adresă</th>
                            <th>Telefon</th>
                            <th>Email</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php while ($row = mysqli_fetch_assoc($rezultate_persoane)): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($row["cnp"]); ?></td>
                            <td><?php echo htmlspecialchars($row["nume"]); ?></td>
                            <td><?php echo htmlspecialchars($row["data_nasterii"]); ?></td>
                            <td><?php echo htmlspecialchars($row["studii"]); ?></td>
                            <td><?php echo htmlspecialchars($row["mediu"]); ?></td>
                            <td><?php echo htmlspecialchars($row["stare_civila"]); ?></td>
                            <td><?php echo htmlspecialchars($row["ocupatie"]); ?></td>
                            <td><?php echo htmlspecialchars($row["adresa"]); ?></td>
                            <td><?php echo htmlspecialchars($row["telefon"]); ?></td>
                            <td><?php echo htmlspecialchars($row["email"]); ?></td>
                        </tr>
                        <?php endwhile; ?>
                    </tbody>
                </table>
            </div>
        <?php endif; ?>

        <!-- Rezultate firme -->
        <?php if ($rezultate_firme && mysqli_num_rows($rezultate_firme) > 0): ?>
            <h3>🏢 Rezultate firme (<?php echo mysqli_num_rows($rezultate_firme); ?>)</h3>
            <div class="tabel-container">
                <table>
                    <thead>
                        <tr>
                            <th>CUI</th>
                            <th>Denumire</th>
                            <th>Angajați</th>
                            <th>Domeniu</th>
                            <th>Capital social</th>
                            <th>Cifră afaceri</th>
                            <th>Profit</th>
                            <th>An înf.</th>
                            <th>Adresă</th>
                            <th>Telefon</th>
                            <th>Email</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php while ($row = mysqli_fetch_assoc($rezultate_firme)): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($row["cui"]); ?></td>
                            <td><?php echo htmlspecialchars($row["denumire"]); ?></td>
                            <td><?php echo htmlspecialchars($row["numar_angajati"]); ?></td>
                            <td><?php echo htmlspecialchars($row["domeniu_activitate"]); ?></td>
                            <td><?php echo number_format($row["capital_social"], 2); ?></td>
                            <td><?php echo number_format($row["cifra_afaceri"], 2); ?></td>
                            <td><?php echo number_format($row["profit"], 2); ?></td>
                            <td><?php echo htmlspecialchars($row["an_infiintare"]); ?></td>
                            <td><?php echo htmlspecialchars($row["adresa"]); ?></td>
                            <td><?php echo htmlspecialchars($row["telefon"]); ?></td>
                            <td><?php echo htmlspecialchars($row["email"]); ?></td>
                        </tr>
                        <?php endwhile; ?>
                    </tbody>
                </table>
            </div>
        <?php endif; ?>

        <!-- Niciun rezultat -->
        <?php
        $nicio_persoana = !$rezultate_persoane || mysqli_num_rows($rezultate_persoane) == 0;
        $nicio_firma    = !$rezultate_firme    || mysqli_num_rows($rezultate_firme) == 0;
        if ($nicio_persoana && $nicio_firma): ?>
            <div class="empty-state">
                <div class="empty-state-icon">🔍</div>
                <p>Nu au fost găsite rezultate pentru <strong>"<?php echo htmlspecialchars($criteriu); ?>"</strong>.</p>
                <p style="margin-top:8px;font-size:0.85rem;">Verificați criteriul de căutare sau tipul de entitate selectat.</p>
            </div>
        <?php endif; ?>

    <?php endif; ?>
</div>

<?php include("includes/footer.php"); ?>
