import express from 'express';
import { getConnection } from 'oracledb';

const app = express();
const port = 3000;

// Configurações do Oracle
const dbConfig = {
    user: 'seu_usuario',
    password: 'sua_senha',
    connectString: 'host:porta/SID',
};

// Endpoint para buscar dados
app.get('/dados', async (req, res) => {
    let connection;

    try {
        connection = await getConnection(dbConfig);
        const result = await connection.execute('SELECT data, valor FROM tabela ORDER BY data');

        // Formatar os dados para o front-end
        const labels = result.rows.map(row => row[0]); // Primeira coluna (datas)
        const valores = result.rows.map(row => row[1]); // Segunda coluna (valores)

        res.json({ labels, valores });
    } catch (err) {
        console.error(err);
        res.status(500).send('Erro ao buscar dados');
    } finally {
        if (connection) {
            await connection.close();
        }
    }
});

// Iniciar o servidor
app.listen(port, () => {
    console.log(`Servidor rodando na porta ${port}`);
});

