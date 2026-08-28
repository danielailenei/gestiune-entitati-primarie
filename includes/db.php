<?php

// Conexiune MySQL, inclusă în toate paginile care fac operații cu baza de date
$host = "localhost";

// Credențiale XAMPP: root fără parolă
$username = "root";
$password = "";
$database = "primarie";

$conn = mysqli_connect($host, $username, $password, $database);

if (!$conn) {
    die("Conexiunea la baza de date a eșuat: " . mysqli_connect_error());
}

?>