<?php
// Distruge sesiunea activă și trimite userul înapoi la login
session_start();
session_destroy();

header("Location: login.php");
exit();
?>