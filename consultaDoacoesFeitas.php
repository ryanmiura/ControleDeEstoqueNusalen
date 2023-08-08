<?php
    include_once('conectaBD.php');
    
    $sql = "SELECT contemplados.nome, saida.prodNome, saida.tipo, saida.quantidade, saida.data_saida
    FROM saida
    JOIN contemplados ON saida.contem_id = contemplados.contem_id;
    ";
    $resultado = $conexao->query($sql);
    $registros = $resultado->fetchAll(PDO::FETCH_ASSOC);

    foreach ($registros as $registro) {
        echo "<tr>";
        echo "<td>" . $registro['nome'] . "</td>";
        echo "<td>" . $registro['prodnome'] . "</td>";
        echo "<td>" . $registro['tipo'] . "</td>";
        echo "<td>" . $registro['quantidade'] . "</td>";
        echo "<td>" . $registro['data_saida'] . "</td>";
        echo "</tr>";
    }

?>