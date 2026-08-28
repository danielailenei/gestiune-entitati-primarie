<?php
// Punct de intrare: redirecționează spre dashboard dacă userul e logat, altfel spre login
session_start();

if (isset($_SESSION["user"])) {
    header("Location: dashboard.php");
} else {
    header("Location: login.php");
}

exit();
?>