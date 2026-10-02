import streamlit as st
from src.db import consultar


st.title("Painel Brasa & Pão")
st.write("Teste de conexão!")

st.dataframe(consultar("SELECT * FROM Produtos"))