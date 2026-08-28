<?php
// Pagina principală după login: statistici sumare + carduri de acces rapid
include("includes/auth.php");
include("includes/db.php");
include("includes/header.php");

// Statistici sumare pentru dashboard
$total_persoane = mysqli_fetch_assoc(mysqli_query($conn, "SELECT COUNT(*) AS total FROM persoane"));
$total_firme    = mysqli_fetch_assoc(mysqli_query($conn, "SELECT COUNT(*) AS total FROM firme"));
$total_entitati = $total_persoane["total"] + $total_firme["total"];
?>

<div class="card">
    <h2>Dashboard</h2>
    <p class="dashboard-bun-venit">
        Bun venit, <strong><?php echo htmlspecialchars($_SESSION["user"]); ?></strong>.
        Gestionați persoanele și firmele înregistrate la primărie.
    </p>

    <!-- Statistici rapide -->
    <div class="stat-grid">
        <div class="stat-card">
            <div class="stat-card-val"><?php echo $total_persoane["total"]; ?></div>
            <div class="stat-card-label">Persoane</div>
        </div>
        <div class="stat-card amber">
            <div class="stat-card-val"><?php echo $total_firme["total"]; ?></div>
            <div class="stat-card-label">Firme</div>
        </div>
        <div class="stat-card">
            <div class="stat-card-val"><?php echo $total_entitati; ?></div>
            <div class="stat-card-label">Total entități</div>
        </div>
    </div>

    <!-- Carduri acces rapid -->
    <div class="dashboard-grid">
        <a href="adauga_persoana.php" class="dash-card">
            <div class="dash-card-icon">👤</div>
            <div class="dash-card-titlu">Adaugă persoană</div>
            <div class="dash-card-desc">Înregistrează o persoană fizică cu toate datele de identificare.</div>
        </a>

        <a href="adauga_firma.php" class="dash-card">
            <div class="dash-card-icon">🏢</div>
            <div class="dash-card-titlu">Adaugă firmă</div>
            <div class="dash-card-desc">Înregistrează o firmă cu date juridice și financiare.</div>
        </a>

        <a href="cautare.php" class="dash-card">
            <div class="dash-card-icon">🔍</div>
            <div class="dash-card-titlu">Căutare</div>
            <div class="dash-card-desc">Caută entități după CNP, CUI, nume, email sau alte criterii.</div>
        </a>

        <a href="rapoarte.php" class="dash-card">
            <div class="dash-card-icon">📊</div>
            <div class="dash-card-titlu">Rapoarte</div>
            <div class="dash-card-desc">Vizualizează statistici și filtrează pe intervale de vârstă sau angajați.</div>
        </a>
    </div>
</div>

<?php include("includes/footer.php"); ?>
