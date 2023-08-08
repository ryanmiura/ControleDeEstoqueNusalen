<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tabela de Doadores</title>
    <link rel="stylesheet" href="./styledoacoesfeitas.css">
</head>
<body>
    <a href="home.html"><button id="btn-voltar">Voltar</button></a>
    <h1>TABELA DE DOADORES</h1>
    <div class="table">
        <table action="score_doacoes.php" method="post">
            <thead>
                <tr>
                    <th>ID do Doador</th>
                    <th>Nome do Doador</th>
                    <th>Quantidade</th>
                </tr>
            </thead>

            <tbody class="dadosBD">
                <tr>
                    <td>1</td>
                    <td>Carnes</td>
                    <td>1</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Alimento</td>
                    <td>3</td>
                </tr>

                <?php include 'score_doacoes.php'; ?>
                
            </tbody>
        </table>
    </div>
        
    
</body>
</html>