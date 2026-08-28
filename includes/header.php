<?php
// Header comun (DOCTYPE, CSS, logo + nav + userul logat) inclus pe toate paginile
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Detectăm pagina activă pentru marcarea linkului din nav
$pagina_curenta = basename($_SERVER['PHP_SELF']);
function nav_cls($fisier, $curent) {
    return $fisier === $curent ? ' class="activ"' : '';
}
?>
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aplicație Primărie</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>

<header>
    <div class="header-inner">
        <div class="header-icon">🏛️</div>
        <div class="header-titlu">
            <h1>Primăria Municipiului Iași</h1>
            <span>Sistem de gestiune entități</span>
        </div>
        <?php if (isset($_SESSION['user'])): ?>
        <div class="header-user">
            👤 <strong><?php echo htmlspecialchars($_SESSION['user']); ?></strong>
        </div>
        <?php endif; ?>
    </div>

    <nav>
    <a href="dashboard.php">Dashboard</a>
    <a href="adauga_persoana.php">Adaugă persoană</a>
    <a href="adauga_firma.php">Adaugă firmă</a>
    <a href="cautare.php">Căutare</a>
    <a href="rapoarte.php">Rapoarte</a>
    <a href="filtrare.php">Filtrare</a>
    <a href="logout.php">Logout</a>
</nav>
</header>

<main>
