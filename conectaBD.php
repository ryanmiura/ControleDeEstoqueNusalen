<?php
/* DEVE ALTERAR OS VALORES DE CONEXAO COMO NOME DO USUARIO,NOME DO BD E A SENHA*/ 
try{

    $conexao = new PDO ("pgsql:host=localhost;dbname=NUSALEN", "postgres", "utfpr");

}catch(PDOException $e ){

    echo $e->getMessage();}

?>