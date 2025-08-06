# 📊 E-Commerce Data Pipeline: End-to-End Analytics Solution

![Project Architecture](images/architecture.png)  
*Figura 1: Diagrama da arquitetura do projeto*

## 🔍 Visão Geral
Pipeline completo de engenharia de dados que processa informações de e-commerce brasileiro, desde a ingestão até visualizações analíticas.

## 🛠️ Stack Tecnológica
| Camada          | Tecnologia          |
|-----------------|---------------------|
| **Extração**    | Python + Kaggle API |
| **Armazenamento**| DuckDB             |
| **Transformação**| dbt (Data Build Tool) |
| **Visualização** | Power BI           |

## 📂 Estrutura do Projeto
- **projeto_engenharia_dados/**
  - **data/**
    - raw/ *(Dados brutos originais)*
    - processed/ *(Dados processados para BI)*
  - **notebooks/**
    - download_data.ipynb
    - setup_duckdb.ipynb
    - export_data_BI.ipynb
  - **olist_project/** *(Projeto dbt)*
    - models/
    - seeds/
    - docs/
  - **venv/** *(Ambiente virtual)*
  - ecommerce.db *(Banco DuckDB)*


## 🚀 Como Executar
**Pré-requisitos**
```bash
# Instalação mínima
pip install duckdb==0.8.0 dbt-core==1.5.0 pandas jupyter
```
1. **Preparação:**
```bash
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
```
2. **Pipeline:**
```bash
# 1. Extração
jupyter notebook notebooks/01_download.ipynb

# 2. Carga
jupyter notebook notebooks/02_duckdb_setup.ipynb

# 3. Transformação
cd dbt_project
dbt run
dbt test
dbt docs generate
dbt docs serve

# 4. Visualização
jupyter notebook ../notebooks/03_export_bi.ipynb

```
## 📈 Resultados

Documentação dbt
https://images/dbt_lineage.png
Figura 2: Linhagem de dados no dbt docs

Dashboard Power BI
https://images/powerbi_dashboard.png
Figura 3: Visualização analítica final

## 📌 Melhores Práticas Implementadas

- Versionamento de dados com DuckDB
- Testes de qualidade com dbt
- Modelagem dimensional para analytics
- Documentação automatizada

## 📚 Recursos
- [Dataset Original](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- [Documentação DuckDB](https://duckdb.org/docs/)
- [Guia dbt](https://docs.getdbt.com/guides/)

  
