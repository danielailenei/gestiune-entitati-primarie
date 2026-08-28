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
$username = "";   // reținut între submit-uri ca să nu se golească câmpul la eroare

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST["username"];
    $password = $_POST["password"];

    // Căutăm doar după username; parola o verificăm în PHP cu password_verify(),
    // fiindcă în DB e stocat un hash bcrypt, nu parola în clar.
    $stmt = mysqli_prepare($conn, "SELECT * FROM users WHERE username = ?");
    mysqli_stmt_bind_param($stmt, "s", $username);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);
    $user = mysqli_fetch_assoc($result);

    // password_verify() re-hashează parola introdusă cu salt-ul din hash-ul stocat
    // și compară în timp constant. Dacă userul nu există, $user e null -> respins.
    if ($user && password_verify($password, $user["password"])) {
        // Sesiune nouă la trecerea anonim -> autentificat: dacă un atacator a
        // "plantat" un ID de sesiune în browserul victimei (session fixation),
        // acel ID devine inutil. true = șterge și fișierul vechi de sesiune.
        session_regenerate_id(true);

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
            <input type="text" id="username" name="username" placeholder="Introduceți utilizatorul"
                   value="<?php echo htmlspecialchars($username); ?>" required autofocus>
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
