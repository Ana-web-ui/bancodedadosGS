import oracledb
import matplotlib.pyplot as plt 

# Configurações de conexão com o Oracle
username = 'seu_usuario'
password = 'sua_senha'
dsn = 'host:porta/SID'

# Conectando ao banco de dados com oracledb
oracledb.init_oracle_client()  # Somente necessário se estiver usando Oracle Instant Client
connection = oracledb.connect(user=username, password=password, dsn=dsn)
cursor = connection.cursor()

# Consultando os dados
# Supondo que você tenha colunas 'mes', 'valor1' e 'valor2' para duas séries de dados
cursor.execute("SELECT mes, valor1, valor2 FROM sua_tabela ORDER BY mes")

# Extraindo os dados para o gráfico
meses = []
valor1 = []
valor2 = []

for row in cursor:
    meses.append(row[0])    # Meses ou datas
    valor1.append(row[1])   # Primeira série de dados
    valor2.append(row[2])   # Segunda série de dados

# Fechando a conexão
cursor.close()
connection.close()

# Criando o gráfico
plt.figure(figsize=(10, 5))

# Linha para a primeira série de dados
plt.plot(meses, valor1, color='blue', marker='o', label='Série 1')
# Linha para a segunda série de dados
plt.plot(meses, valor2, color='green', marker='o', label='Série 2')

# Configurações do gráfico
plt.title("Gráfico de Dados do Oracle SQL")
plt.xlabel("Meses")
plt.ylabel("Valores")
plt.legend(loc='upper left')
plt.grid(True)

# Exibindo o gráfico
plt.show()
