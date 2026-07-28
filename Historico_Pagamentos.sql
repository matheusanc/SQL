CREATE PROCEDURE Historico_Pagamentos
AS
BEGIN
    SELECT 
        pa.nome_paciente, 
        pa.cpf, 
        c.numero_consulta, 
        c.data_consulta,  
        pe.data_exame, 
        pe.valor_pagar, 
        e.codigo, 
        e.especificacao 
    FROM paciente AS pa 
    INNER JOIN consulta AS c ON pa.cpf = c.fk_paciente_cpf 
    INNER JOIN pedido_exame AS pe ON c.numero_consulta = pe.fk_consulta_numero_consulta 
    INNER JOIN exame AS e ON pe.fk_exame_codigo = e.codigo 
    ORDER BY pa.nome_paciente, pe.data_exame;
END;
GO

-- Execução:
EXECUTE Historico_Pagamentos;
GO
