CREATE PROCEDURE Resumo_Pagamentos 
    @nome_pac VARCHAR(40)
AS
BEGIN
    SELECT 
        pa.nome_paciente, 
        SUM(pe.valor_pagar) AS total_pagar
    FROM paciente AS pa 
    INNER JOIN consulta AS c ON pa.cpf = c.fk_paciente_cpf 
    INNER JOIN pedido_exame AS pe ON c.numero_consulta = pe.fk_consulta_numero_consulta 
    WHERE pa.nome_paciente = @nome_pac
    GROUP BY pa.nome_paciente;
END;
GO

-- Exemplos de Execução:
EXECUTE Resumo_Pagamentos 'Leonardo Ribeiro';[cite: 4, 6]
EXECUTE Resumo_Pagamentos 'Maria Pereira';[cite: 6]
GO
