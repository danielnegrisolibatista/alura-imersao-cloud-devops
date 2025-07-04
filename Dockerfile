# Etapa 1: Definir a imagem base
# Usamos uma imagem slim do Python para manter o tamanho final pequeno.
FROM python:3.13.4-alpine3.22

# Etapa 2: Definir o diretório de trabalho dentro do contêiner
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências e instalá-las
# Copiamos primeiro o requirements.txt para aproveitar o cache do Docker.
# Se este arquivo não mudar, o Docker não reinstalará as dependências.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 4: Copiar o código da aplicação
COPY . .

# Etapa 5: Expor a porta que a aplicação usará
EXPOSE 8000

# Etapa 6: Comando para iniciar a aplicação
# Usamos uvicorn para rodar o objeto 'app' do arquivo 'app.py'.
# O host 0.0.0.0 torna a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]