
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tabela Entradas</title>
    <link rel="stylesheet" href="./styleEntradas.css">
</head>
<body>
    <a href="home.html"><button id="btn-voltar">Voltar</button></a>
    
    <div class="table">
        <table action="consultaUser.php" method="post">
            <thead>
                <tr>
                    <th>Nome Doador</th>
                    <th>Tipo Produto</th>
                    <th>Nome Produto</th>
                    <th>Quantidade</th>
                    <th>Tipo Doador</th>
                </tr>
            </thead>

            <tbody class="dadosBD">
                <tr>
                    <td>Fulano</td>
                    <td>Carnes</td>
                    <td>carne moida</td>
                    <td>1</td>
                    <td>Pessoa Fisica</td>
                </tr>
                <tr>
                    <td>Ciclano</td>
                    <td>Alimento</td>
                    <td>arroz</td>
                    <td>3</td>
                    <td>Pessoa Fisica</td>
                </tr>

                <?php include 'consultaUser.php'; ?>
                
            </tbody>
        </table>
    </div>
        
    
</body>
</html>

