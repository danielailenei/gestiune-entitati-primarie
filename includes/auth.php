<?php

// Protejează paginile private: fără sesiune activă, redirect la login
session_start();

if (!isset($_SESSION["user"])) {
    header("Location: login.php");
    exit();
}

?>