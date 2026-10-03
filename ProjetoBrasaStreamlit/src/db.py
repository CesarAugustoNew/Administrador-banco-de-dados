import streamlit as st
import pandas as pd
import re

from sqlalchemy import create_engine, text
from urllib.parse import quote_plus

SERVIDOR = r""
BANCO = "HamburgueriaBrasa"
DRIVER = "ODBC Driver 18 for SQL Server"


def conectar():
    # Autenticação via windows utilizando ODBC
    
    odbc = (
        f"DRIVER={{{DRIVER}}};SERVER={SERVIDOR};DATABASE={BANCO};"
        "Trusted_Connection=yes;TrustServerCertificate=yes"
    )
    
    return create_engine("mssql+pyodbc:///?odbc_connect="+ quote_plus(odbc))


def consultar(sql):
    """Executa a consulta no sql server e devolve o resultado como tabela"""
    with conectar().connect() as conexao:
        return pd.read_sql(text(sql), conexao)