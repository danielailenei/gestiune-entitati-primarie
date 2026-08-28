<?php
// Filtrare persoane/firme pe intervale numerice (vârstă, angajați, profit, cifră de afaceri)
include("includes/auth.php");
include("includes/db.php");
include("includes/header.php");

$persoane_interval = null;
$firme_interval_angajati = null;
$firme_interval_profit = null;
$firme_interval_cifra = null;

if (isset($_GET["filtru_varsta"])) {
    $varsta_min = $_GET["varsta_min"];
    $varsta_max = $_GET["varsta_max"];

    $stmt = mysqli_prepare($conn, "SELECT *, TIMESTAMPDIFF(YEAR, data_nasterii, CURDATE()) AS varsta
            FROM persoane
            WHERE TIMESTAMPDIFF(YEAR, data_nasterii, CURDATE())
            BETWEEN ? AND ?
            ORDER BY varsta ASC");
    mysqli_stmt_bind_param($stmt, "ii", $varsta_min, $varsta_max);
    mysqli_stmt_execute($stmt);
    $persoane_interval = mysqli_stmt_get_result($stmt);
}

if (isset($_GET["filtru_angajati"])) {
    $angajati_min = $_GET["angajati_min"];
    $angajati_max = $_GET["angajati_max"];

    $stmt = mysqli_prepare($conn, "SELECT *
            FROM firme
            WHERE numar_angajati BETWEEN ? AND ?
            ORDER BY numar_angajati ASC");
    mysqli_stmt_bind_param($stmt, "ii", $angajati_min, $angajati_max);
    mysqli_stmt_execute($stmt);
    $firme_interval_angajati = mysqli_stmt_get_result($stmt);
}

if (isset($_GET["filtru_profit"])) {
    $profit_min = $_GET["profit_min"];
    $profit_max = $_GET["profit_max"];

    $stmt = mysqli_prepare($conn, "SELECT *
            FROM firme
            WHERE profit BETWEEN ? AND ?
            ORDER BY profit DESC");
    mysqli_stmt_bind_param($stmt, "dd", $profit_min, $profit_max);
    mysqli_stmt_execute($stmt);
    $firme_interval_profit = mysqli_stmt_get_result($stmt);
}

if (isset($_GET["filtru_cifra"])) {
    $cifra_min = $_GET["cifra_min"];
    $cifra_max = $_GET["cifra_max"];

    $stmt = mysqli_prepare($conn, "SELECT *
            FROM firme
            WHERE cifra_afaceri BETWEEN ? AND ?
            ORDER BY cifra_afaceri DESC");
    mysqli_stmt_bind_param($stmt, "dd", $cifra_min, $cifra_max);
    mysqli_stmt_execute($stmt);
    $firme_interval_cifra = mysqli_stmt_get_result($stmt);
}
?>

<h2>Filtrări pe intervale</h2>

<p>Această pagină permite afișarea persoanelor și firmelor pe baza unor intervale numerice.</p>

<hr>

<h3>Filtrare persoane după interval de vârstă</h3>

<form method="GET" action="">
    <label>Vârstă minimă:</label>
    <input type="number" name="varsta_min" min="0" required>

    <label>Vârstă maximă:</label>
    <input type="number" name="varsta_max" min="0" required>

    <button type="submit" name="filtru_varsta">Afișează persoane</button>
</form>

<?php if ($persoane_interval && mysqli_num_rows($persoane_interval) > 0) { ?>
    <table>
        <tr>
            <th>CNP</th>
            <th>Nume</th>
            <th>Vârstă</th>
            <th>Studii</th>
            <th>Mediu</th>
            <th>Ocupație</th>
            <th>Telefon</th>
            <th>Email</th>
        </tr>

        <?php while ($row = mysqli_fetch_assoc($persoane_interval)) { ?>
            <tr>
                <td><?php echo htmlspecialchars($row["cnp"]); ?></td>
                <td><?php echo htmlspecialchars($row["nume"]); ?></td>
                <td><?php echo htmlspecialchars($row["varsta"]); ?></td>
                <td><?php echo htmlspecialchars($row["studii"]); ?></td>
                <td><?php echo htmlspecialchars($row["mediu"]); ?></td>
                <td><?php echo htmlspecialchars($row["ocupatie"]); ?></td>
                <td><?php echo htmlspecialchars($row["telefon"]); ?></td>
                <td><?php echo htmlspecialchars($row["email"]); ?></td>
            </tr>
        <?php } ?>
    </table>
<?php } elseif (isset($_GET["filtru_varsta"])) { ?>
    <div class="empty-state">
        <div class="empty-state-icon">🔍</div>
        <p>Nicio persoană în intervalul de vârstă selectat.</p>
    </div>
<?php } ?>

<hr>

<h3>Filtrare firme după interval de angajați</h3>

<form method="GET" action="">
    <label>Număr minim angajați:</label>
    <input type="number" name="angajati_min" min="0" required>

    <label>Număr maxim angajați:</label>
    <input type="number" name="angajati_max" min="0" required>

    <button type="submit" name="filtru_angajati">Afișează firme</button>
</form>

<?php if ($firme_interval_angajati && mysqli_num_rows($firme_interval_angajati) > 0) { ?>
    <table>
        <tr>
            <th>CUI</th>
            <th>Denumire</th>
            <th>Angajați</th>
            <th>Domeniu</th>
            <th>Cifră afaceri</th>
            <th>Profit</th>
        </tr>

        <?php while ($row = mysqli_fetch_assoc($firme_interval_angajati)) { ?>
            <tr>
                <td><?php echo htmlspecialchars($row["cui"]); ?></td>
                <td><?php echo htmlspecialchars($row["denumire"]); ?></td>
                <td><?php echo htmlspecialchars($row["numar_angajati"]); ?></td>
                <td><?php echo htmlspecialchars($row["domeniu_activitate"]); ?></td>
                <td><?php echo number_format($row["cifra_afaceri"], 2); ?></td>
                <td><?php echo number_format($row["profit"], 2); ?></td>
            </tr>
        <?php } ?>
    </table>
<?php } elseif (isset($_GET["filtru_angajati"])) { ?>
    <div class="empty-state">
        <div class="empty-state-icon">🔍</div>
        <p>Nicio firmă în intervalul de angajați selectat.</p>
    </div>
<?php } ?>

<hr>

<h3>Filtrare firme după interval de profit</h3>

<form method="GET" action="">
    <label>Profit minim:</label>
    <input type="number" name="profit_min" step="0.01" required>

    <label>Profit maxim:</label>
    <input type="number" name="profit_max" step="0.01" required>

    <button type="submit" name="filtru_profit">Afișează firme</button>
</form>

<?php if ($firme_interval_profit && mysqli_num_rows($firme_interval_profit) > 0) { ?>
    <table>
        <tr>
            <th>CUI</th>
            <th>Denumire</th>
            <th>Domeniu</th>
            <th>Angajați</th>
            <th>Profit</th>
        </tr>

        <?php while ($row = mysqli_fetch_assoc($firme_interval_profit)) { ?>
            <tr>
                <td><?php echo htmlspecialchars($row["cui"]); ?></td>
                <td><?php echo htmlspecialchars($row["denumire"]); ?></td>
                <td><?php echo htmlspecialchars($row["domeniu_activitate"]); ?></td>
                <td><?php echo htmlspecialchars($row["numar_angajati"]); ?></td>
                <td><?php echo number_format($row["profit"], 2); ?></td>
            </tr>
        <?php } ?>
    </table>
<?php } elseif (isset($_GET["filtru_profit"])) { ?>
    <div class="empty-state">
        <div class="empty-state-icon">🔍</div>
        <p>Nicio firmă în intervalul de profit selectat.</p>
    </div>
<?php } ?>

<hr>

<h3>Filtrare firme după interval de cifră de afaceri</h3>

<form method="GET" action="">
    <label>Cifră de afaceri minimă:</label>
    <input type="number" name="cifra_min" min="0" step="0.01" required>

    <label>Cifră de afaceri maximă:</label>
    <input type="number" name="cifra_max" min="0" step="0.01" required>

    <button type="submit" name="filtru_cifra">Afișează firme</button>
</form>

<?php if ($firme_interval_cifra && mysqli_num_rows($firme_interval_cifra) > 0) { ?>
    <table>
        <tr>
            <th>CUI</th>
            <th>Denumire</th>
            <th>Domeniu</th>
            <th>Angajați</th>
            <th>Cifră afaceri</th>
            <th>Profit</th>
        </tr>

        <?php while ($row = mysqli_fetch_assoc($firme_interval_cifra)) { ?>
            <tr>
                <td><?php echo htmlspecialchars($row["cui"]); ?></td>
                <td><?php echo htmlspecialchars($row["denumire"]); ?></td>
                <td><?php echo htmlspecialchars($row["domeniu_activitate"]); ?></td>
                <td><?php echo htmlspecialchars($row["numar_angajati"]); ?></td>
                <td><?php echo number_format($row["cifra_afaceri"], 2); ?></td>
                <td><?php echo number_format($row["profit"], 2); ?></td>
            </tr>
        <?php } ?>
    </table>
<?php } elseif (isset($_GET["filtru_cifra"])) { ?>
    <div class="empty-state">
        <div class="empty-state-icon">🔍</div>
        <p>Nicio firmă în intervalul de cifră de afaceri selectat.</p>
    </div>
<?php } ?>

<?php
include("includes/footer.php");
?>