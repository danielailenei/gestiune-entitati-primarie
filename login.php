<?php
// Autentificare: verifică user/parolă în tabela users, apoi creează sesiunea
session_start();
include("includes/db.php");

// Dacă utilizatorul este deja autentificat, îl trimitem direct la dashboard
if (isset($_SESSION["user"])) {
    header("Location: dashboard.php");
    exit();
}

$error = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST["username"];
    $password = $_POST["password"];

    // Căutăm userul cu username + parola introduse (prepared statement, fără concatenare în SQL)
    $stmt = mysqli_prepare($conn, "SELECT * FROM users WHERE username = ? AND password = ?");
    mysqli_stmt_bind_param($stmt, "ss", $username, $password);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);

    if (mysqli_num_rows($result) == 1) {
        $_SESSION["user"] = $username;
        header("Location: dashboard.php");
        exit();
    } else {
        $error = "Username sau parolă incorecte.";
    }
}
?>
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Autentificare — Primărie</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body class="login-page">

<div class="login-box">
    <div class="login-logo">
        <div class="login-logo-icon">🏛️</div>
        <h1>Primăria Municipiului</h1>
        <p>Sistem de gestiune entități</p>
    </div>

    <?php if ($error != ""): ?>
        <div class="mesaj-eroare"><?php echo $error; ?></div>
    <?php endif; ?>

    <form method="POST" action="">
        <div class="form-grup">
            <label for="username">Utilizator</label>
            <input type="text" id="username" name="username" placeholder="Introduceți utilizatorul" required autofocus>
        </div>

        <div class="form-grup">
            <label for="password">Parolă</label>
            <input type="password" id="password" name="password" placeholder="Introduceți parola" required>
        </div>

        <button type="submit">🔐 Autentificare</button>
    </form>
</div>

</body>
</html>
