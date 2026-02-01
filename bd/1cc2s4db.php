<?php
    //PRODUCCION
    //$mysqli1 = new mysqli("localhost", "root", "Root1234*", "avm_unieeuu");
    
    //LOCAL
    $mysqli1 = new mysqli("localhost", "root", "Root1234*", "avm_unieeuu");

	if(mysqli_connect_error()) {
         die("Error de conexión: " . $mysqli1->connect_error);         
    }
    else {
        //echo "Conección exitosa";
    }
    
    $mysqli1->set_charset("utf8");
?>