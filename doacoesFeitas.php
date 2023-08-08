
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tabela Doações Feitas</title>
    <link rel="stylesheet" href="./styledoacoesfeitas.css">
</head>
<body>
    <a href="home.html"><button id="btn-voltar">Voltar</button></a>
    <h1>TABELA DE DOAÇÕES FEITAS</h1>
    <div class="table">
        <table action="consultaUser.php" method="post">
            <thead>
                <tr>
                    <th>Nome do Comtemplado</th>
                    <th>Nome Produto</th>
                    <th>Tipo Produto</th>
                    <th>Quantidade</th>
                    <th>Data da Doação</th>
                </tr>
            </thead>

            <tbody class="dadosBD">
                <tr>
                    <td>Fulano</td>
                    <td>carne moida</td>
                    <td>Carnes</td>
                    <td>1</td>
                    <td>2023-06-15</td>
                </tr>
                <tr>
                    <td>Ciclano</td>
                    <td>arroz</td>
                    <td>Alimento</td>
                    <td>3</td>
                    <td>2023-06-15</td>
                </tr>

                <?php include 'consultaDoacoesFeitas.php'; ?>
                
            </tbody>
        </table>
    </div>
        
    
</body>
</html>

