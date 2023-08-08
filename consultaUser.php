<?php
    include_once('conectaBD.php');
    
    $sql = "SELECT * FROM entrada";
    $resultado = $conexao->query($sql);
    $registros = $resultado->fetchAll(PDO::FETCH_ASSOC);

    foreach ($registros as $registro) {
        echo "<tr>";
        echo "<td>" . $registro['nome_doador'] . "</td>";
        echo "<td>" . $registro['tipo'] . "</td>";
        echo "<td>" . $registro['prodnome'] . "</td>";
        echo "<td>" . $registro['quantidade'] . "</td>";
        echo "<td>" . $registro['tipo_doador'] . "</td>";
        echo "</tr>";
    }

?>