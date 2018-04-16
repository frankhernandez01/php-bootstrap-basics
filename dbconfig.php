<?php
  $host = "localhost";
  $user="root";
  $password="";
  $dbname = "company";
  $con=mysqli_connect($host, $user, $password, $dbname);
  if (mysqli_connect_errno()) {
    echo "Failed to connect to MariaDB: " . mysqli_connect_error();
    exit;
  }
?>