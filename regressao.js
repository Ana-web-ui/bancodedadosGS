import { getConnection } from 'oracledb';
import express from 'express';
const app = express();
    
app.get('/grafico', async (req, res) => {
  let conn;
  try {
    conn = await getConnection({
      user: 'usuario',
      password: 'senha',
      connectString: 'localhost:1521/orcl'
    });

    const result = await conn.execute("SELECT data, energia_gerada FROM regressao_linear");
    
    // Transformar os dados para o formato necessário para o gráfico
    const labels = result.rows.map(row => row[0]);
    const data = result.rows.map(row => row[1]);

    res.json({
      labels: labels,
      datasets: [{
        label: 'Energia Gerada',
        data: data
      }]
    });
  } catch (err) {
    console.error(err);
    res.status(500).send("Erro ao recuperar dados do banco de dados.");
  } finally {
    if (conn) {
      try {
        await conn.close();
      } catch (err) {
        console.error(err);
      }
    }
  }
});

app.listen(3000, () => {
  console.log('Servidor rodando na porta 3000');
});
