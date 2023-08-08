<?php
    include_once('conectaBD.php');

    $prodnome = $_POST['produto'];
    $tipo = $_POST['select_produto'];
    $quantidade =$_POST['quantidade'];
    $nome =$_POST['name'];
    $tipo_doador =$_POST['Pes'];

    $query = "INSERT INTO Entrada(prodnome,tipo,quantidade,nome_doador,tipo_doador) VALUES ('$prodnome','$tipo','$quantidade','$nome','$tipo_doador')";

    $conexao->query($query);


?>
 
 <!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CONTROLE DE ESTOQUE NUSELON</title>
    <link rel="stylesheet" href="./stylehome.css">
</head>
    <h1>CONTROLE DE ESTOQUE E DOAÇÔES - NUSALEN</h1>
    <div class="painel">
        <a href="cadastrarDoacao.html"><button>Cadastrar Doação</button></a>
        <a href="entradas.php"><button>Ver Entradas</button></a>
        <a href="doacoesFeitas.php"><button>Ver Doação FEITAS</button></a>
    </div>
</body>