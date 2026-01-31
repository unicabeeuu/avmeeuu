<?php
    //$mysqli1 = new mysqli("localhost", "u269250303_asist_virtual", "1s3st_V3rt51l", "u269250303_asist_virtual");
    $mysqli1 = new mysqli("localhost", "root", "Root1234*", "avm_unieeuu");

	if(mysqli_connect_error()) {
         die("Error de conexión: " . $mysqli1->connect_error);         
    }
    else {
        //echo "Conección exitosa";
    }
    
    $mysqli1->set_charset("utf8");
?>