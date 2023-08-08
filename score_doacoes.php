<?php
    include_once('conectaBD.php');
    
    $sql = "SELECT * FROM doacoespordoador;
    ";
    $resultado = $conexao->query($sql);
    $registros = $resultado->fetchAll(PDO::FETCH_ASSOC);

    foreach ($registros as $registro) {
        echo "<tr>";
        echo "<td>" . $registro['doador_id'] . "</td>";
        echo "<td>" . $registro['nome'] . "</td>";
        echo "<td>" . $registro['quantidade'] . "</td>";
        echo "</tr>";
    }

?>