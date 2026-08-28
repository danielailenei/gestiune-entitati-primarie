<?php
include("includes/auth.php");
include("includes/db.php");
include("includes/header.php");

// Rapoarte totalizatoare, alese prin parametrul GET "raport" (ex: ?raport=studii)

$raport_selectat = "";

if (isset($_GET["raport"])) {
    $raport_selectat = $_GET["raport"];
}
?>

<h2>Rapoarte totalizatoare</h2>

<p>Alege raportul pe care vrei să îl vizualizezi.</p>

<div class="report-menu">
    <h3>Rapoarte generale</h3>

    <a class="report-card" href="rapoarte.php?raport=general">Statistici generale</a>

    <h3>Rapoarte persoane</h3>

    <a class="report-card" href="rapoarte.php?raport=varsta">Persoane pe categorii de vârstă</a>
    <a class="report-card" href="rapoarte.php?raport=studii">Persoane după studii</a>
    <a class="report-card" href="rapoarte.php?raport=mediu">Persoane după mediu urban/rural</a>
    <a class="report-card" href="rapoarte.php?raport=stare_civila">Persoane după stare civilă</a>
    <a class="report-card" href="rapoarte.php?raport=ocupatie">Persoane după ocupație</a>

    <h3>Rapoarte firme</h3>

    <a class="report-card" href="rapoarte.php?raport=domenii">Firme după domeniu de activitate</a>
    <a class="report-card" href="rapoarte.php?raport=cifra_afaceri">Total cifră de afaceri pe domenii</a>
    <a class="report-card" href="rapoarte.php?raport=profit">Total profit pe domenii</a>
    <a class="report-card" href="rapoarte.php?raport=capital">Total capital social pe domenii</a>
    <a class="report-card" href="rapoarte.php?raport=profitabilitate">Firme profitabile vs firme pe pierdere</a>
    <a class="report-card" href="rapoarte.php?raport=vechime">Firme după vechime</a>
</div>

<hr>

<?php
// Raport: Statistici generale
if ($raport_selectat == "general") {
    $total_persoane = mysqli_fetch_assoc(
        mysqli_query($conn, "SELECT COUNT(*) AS total FROM persoane")
    );

    $total_firme = mysqli_fetch_assoc(
        mysqli_query($conn, "SELECT COUNT(*) AS total FROM firme")
    );

    $total_entitati = $total_persoane["total"] + $total_firme["total"];

    $media_angajati = mysqli_fetch_assoc(
        mysqli_query($conn, "SELECT AVG(numar_angajati) AS media FROM firme")
    );

    $min_angajati = mysqli_fetch_assoc(
        mysqli_query($conn, "SELECT MIN(numar_angajati) AS minim FROM firme")
    );

    $max_angajati = mysqli_fetch_assoc(
        mysqli_query($conn, "SELECT MAX(numar_angajati) AS maxim FROM firme")
    );
?>

<h3>Statistici generale</h3>

<table>
    <tr>
        <th>Indicator</th>
        <th>Valoare</th>
    </tr>
    <tr>
        <td>Total persoane</td>
        <td><?php echo $total_persoane["total"]; ?></td>
    </tr>
    <tr>
        <td>Total firme</td>
        <td><?php echo $total_firme["total"]; ?></td>
    </tr>
    <tr>
        <td>Total entități</td>
        <td><?php echo $total_entitati; ?></td>
    </tr>
    <tr>
        <td>Media angajaților</td>
        <td><?php echo round($media_angajati["media"], 2); ?></td>
    </tr>
    <tr>
        <td>Minim angajați</td>
        <td><?php echo $min_angajati["minim"]; ?></td>
    </tr>
    <tr>
        <td>Maxim angajați</td>
        <td><?php echo $max_angajati["maxim"]; ?></td>
    </tr>
</table>

<?php } ?>

<?php
// Raport: Persoane pe categorii de vârstă
if ($raport_selectat == "varsta") {
    $result = mysqli_query($conn, "
        SELECT 
            CASE
                WHEN TIMESTAMPDIFF(YEAR, data_nasterii, CURDATE()) BETWEEN 0 AND 18 THEN '0-18 ani'
                WHEN TIMESTAMPDIFF(YEAR, data_nasterii, CURDATE()) BETWEEN 19 AND 30 THEN '19-30 ani'
                WHEN TIMESTAMPDIFF(YEAR, data_nasterii, CURDATE()) BETWEEN 31 AND 45 THEN '31-45 ani'
                WHEN TIMESTAMPDIFF(YEAR, data_nasterii, CURDATE()) BETWEEN 46 AND 60 THEN '46-60 ani'
                ELSE '60+ ani'
            END AS categorie_varsta,
            COUNT(*) AS total
        FROM persoane
        GROUP BY categorie_varsta
        ORDER BY 
            CASE categorie_varsta
                WHEN '0-18 ani' THEN 1
                WHEN '19-30 ani' THEN 2
                WHEN '31-45 ani' THEN 3
                WHEN '46-60 ani' THEN 4
                ELSE 5
            END
    ");
?>

<h3>Persoane pe categorii de vârstă</h3>

<table>
    <tr>
        <th>Categorie vârstă</th>
        <th>Număr persoane</th>
    </tr>

    <?php while ($row = mysqli_fetch_assoc($result)) { ?>
        <tr>
            <td><?php echo $row["categorie_varsta"]; ?></td>
            <td><?php echo $row["total"]; ?></td>
        </tr>
    <?php } ?>
</table>

<?php } ?>

<?php
// Raport: Persoane după studii
if ($raport_selectat == "studii") {
    $result = mysqli_query($conn, "
        SELECT studii, COUNT(*) AS total
        FROM persoane
        GROUP BY studii
        ORDER BY total DESC
    ");
?>

<h3>Persoane după nivelul studiilor</h3>

<table>
    <tr>
        <th>Studii</th>
        <th>Număr persoane</th>
    </tr>

    <?php while ($row = mysqli_fetch_assoc($result)) { ?>
        <tr>
            <td><?php echo $row["studii"]; ?></td>
            <td><?php echo $row["total"]; ?></td>
        </tr>
    <?php } ?>
</table>

<?php } ?>

<?php
// Raport: Persoane după mediu
if ($raport_selectat == "mediu") {
    $result = mysqli_query($conn, "
        SELECT mediu, COUNT(*) AS total
        FROM persoane
        GROUP BY mediu
    ");
?>

<h3>Persoane după mediu urban/rural</h3>

<table>
    <tr>
        <th>Mediu</th>
        <th>Număr persoane</th>
    </tr>

    <?php while ($row = mysqli_fetch_assoc($result)) { ?>
        <tr>
            <td><?php echo $row["mediu"]; ?></td>
            <td><?php echo $row["total"]; ?></td>
        </tr>
    <?php } ?>
</table>

<?php } ?>

<?php
// Raport: Persoane după stare civilă
if ($raport_selectat == "stare_civila") {
    $result = mysqli_query($conn, "
        SELECT stare_civila, COUNT(*) AS total
        FROM persoane
        GROUP BY stare_civila
        ORDER BY total DESC
    ");
?>

<h3>Persoane după stare civilă</h3>

<table>
    <tr>
        <th>Stare civilă</th>
        <th>Număr persoane</th>
    </tr>

    <?php while ($row = mysqli_fetch_assoc($result)) { ?>
        <tr>
            <td><?php echo $row["stare_civila"]; ?></td>
            <td><?php echo $row["total"]; ?></td>
        </tr>
    <?php } ?>
</table>

<?php } ?>

<?php
// Raport: Persoane după ocupație
if ($raport_selectat == "ocupatie") {
    $result = mysqli_query($conn, "
        SELECT ocupatie, COUNT(*) AS total
        FROM persoane
        GROUP BY ocupatie
        ORDER BY total DESC
    ");
?>

<h3>Persoane după ocupație</h3>

<table>
    <tr>
        <th>Ocupație</th>
        <th>Număr persoane</th>
    </tr>

    <?php while ($row = mysqli_fetch_assoc($result)) { ?>
        <tr>
            <td><?php echo $row["ocupatie"]; ?></td>
            <td><?php echo $row["total"]; ?></td>
        </tr>
    <?php } ?>
</table>

<?php } ?>

<?php
// Raport: Firme după domeniu
if ($raport_selectat == "domenii") {
    $result = mysqli_query($conn, "
        SELECT domeniu_activitate, COUNT(*) AS total
        FROM firme
        GROUP BY domeniu_activitate
        ORDER BY total DESC
    ");
?>

<h3>Firme după domeniu de activitate</h3>

<table>
    <tr>
        <th>Domeniu</th>
        <th>Număr firme</th>
    </tr>

    <?php while ($row = mysqli_fetch_assoc($result)) { ?>
        <tr>
            <td><?php echo $row["domeniu_activitate"]; ?></td>
            <td><?php echo $row["total"]; ?></td>
        </tr>
    <?php } ?>
</table>

<?php } ?>

<?php
// Raport: Cifră de afaceri pe domenii
if ($raport_selectat == "cifra_afaceri") {
    $result = mysqli_query($conn, "
        SELECT domeniu_activitate,
               SUM(cifra_afaceri) AS total_cifra
        FROM firme
        GROUP BY domeniu_activitate
        ORDER BY total_cifra DESC
    ");
?>

<h3>Total cifră de afaceri pe domenii</h3>

<table>
    <tr>
        <th>Domeniu</th>
        <th>Total cifră de afaceri</th>
    </tr>

    <?php while ($row = mysqli_fetch_assoc($result)) { ?>
        <tr>
            <td><?php echo $row["domeniu_activitate"]; ?></td>
            <td><?php echo number_format($row["total_cifra"], 2); ?></td>
        </tr>
    <?php } ?>
</table>

<?php } ?>

<?php
// Raport: Profit pe domenii
if ($raport_selectat == "profit") {
    $result = mysqli_query($conn, "
        SELECT domeniu_activitate,
               SUM(profit) AS total_profit
        FROM firme
        GROUP BY domeniu_activitate
        ORDER BY total_profit DESC
    ");
?>

<h3>Total profit pe domenii</h3>

<table>
    <tr>
        <th>Domeniu</th>
        <th>Total profit</th>
    </tr>

    <?php while ($row = mysqli_fetch_assoc($result)) { ?>
        <tr>
            <td><?php echo $row["domeniu_activitate"]; ?></td>
            <td><?php echo number_format($row["total_profit"], 2); ?></td>
        </tr>
    <?php } ?>
</table>

<?php } ?>

<?php
// Raport: Capital social pe domenii
if ($raport_selectat == "capital") {
    $result = mysqli_query($conn, "
        SELECT domeniu_activitate,
               SUM(capital_social) AS total_capital
        FROM firme
        GROUP BY domeniu_activitate
        ORDER BY total_capital DESC
    ");
?>

<h3>Total capital social pe domenii</h3>

<table>
    <tr>
        <th>Domeniu</th>
        <th>Total capital social</th>
    </tr>

    <?php while ($row = mysqli_fetch_assoc($result)) { ?>
        <tr>
            <td><?php echo $row["domeniu_activitate"]; ?></td>
            <td><?php echo number_format($row["total_capital"], 2); ?></td>
        </tr>
    <?php } ?>
</table>

<?php } ?>

<?php
// Raport: Firme profitabile / pe pierdere
if ($raport_selectat == "profitabilitate") {
    $profitabile = mysqli_fetch_assoc(
        mysqli_query($conn, "SELECT COUNT(*) AS total FROM firme WHERE profit > 0")
    );

    $pierdere = mysqli_fetch_assoc(
        mysqli_query($conn, "SELECT COUNT(*) AS total FROM firme WHERE profit <= 0")
    );
?>

<h3>Firme profitabile vs firme pe pierdere</h3>

<table>
    <tr>
        <th>Tip firmă</th>
        <th>Număr firme</th>
    </tr>
    <tr>
        <td>Firme profitabile</td>
        <td><?php echo $profitabile["total"]; ?></td>
    </tr>
    <tr>
        <td>Firme pe pierdere</td>
        <td><?php echo $pierdere["total"]; ?></td>
    </tr>
</table>

<?php } ?>

<?php
// Raport: Firme după vechime
if ($raport_selectat == "vechime") {
    $result = mysqli_query($conn, "
        SELECT
            CASE
                WHEN YEAR(CURDATE()) - an_infiintare BETWEEN 0 AND 5 THEN '0-5 ani'
                WHEN YEAR(CURDATE()) - an_infiintare BETWEEN 6 AND 10 THEN '6-10 ani'
                WHEN YEAR(CURDATE()) - an_infiintare BETWEEN 11 AND 20 THEN '11-20 ani'
                ELSE '20+ ani'
            END AS categorie_vechime,
            COUNT(*) AS total
        FROM firme
        GROUP BY categorie_vechime
        ORDER BY
            CASE categorie_vechime
                WHEN '0-5 ani' THEN 1
                WHEN '6-10 ani' THEN 2
                WHEN '11-20 ani' THEN 3
                ELSE 4
            END
    ");
?>

<h3>Firme după vechime</h3>

<table>
    <tr>
        <th>Vechime firmă</th>
        <th>Număr firme</th>
    </tr>

    <?php while ($row = mysqli_fetch_assoc($result)) { ?>
        <tr>
            <td><?php echo $row["categorie_vechime"]; ?></td>
            <td><?php echo $row["total"]; ?></td>
        </tr>
    <?php } ?>
</table>

<?php } ?>

<?php if ($raport_selectat == "") { ?>
    <p>Selectează un raport din lista de mai sus pentru a afișa rezultatele.</p>
<?php } ?>

<?php
include("includes/footer.php");
?>