import React, { useEffect, useState } from 'react';
import { Line } from 'react-chartjs-2';
import axios from 'axios';

const ChartComponent = () => {
    const [chartData, setChartData] = useState(null);

    useEffect(() => {
        const fetchData = async () => {
            try {
                const response = await axios.get('http://localhost:3000/dados'); // URL do back-end
                const { labels, valores } = response.data;

                // Configurar os dados para o Chart.js
                setChartData({
                    labels,
                    datasets: [
                        {
                            label: 'Valores ao longo do tempo',
                            data: valores,
                            borderColor: 'rgba(75, 192, 192, 1)',
                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                            borderWidth: 2,
                        },
                    ],
                });
            } catch (error) {
                console.error('Erro ao buscar dados:', error);
            }
        };

        fetchData();
    }, []);

    return (
        <div>
            {chartData ? (
                <Line data={chartData} options={{ responsive: true }} />
            ) : (
                <p>Carregando gráfico...</p>
            )}
        </div>
    );
};

export default ChartComponent;
