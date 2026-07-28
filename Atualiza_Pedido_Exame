USE clinica_medica;
GO

-- Limpa a tabela e reinicia a contagem de ID para garantir a sincronização com os testes
DELETE FROM pedido_exame;
DBCC CHECKIDENT('pedido_exame', RESEED, 2199);
GO

-- Criação da Trigger
CREATE TRIGGER Atualiza_Pedido_Exame
ON pedido_exame
AFTER INSERT
AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @num_ped AS INT;
    DECLARE @num_cons AS INT;
    DECLARE @cod_ex AS INT;
    DECLARE @prc AS MONEY;
    DECLARE @cpf_pac AS VARCHAR(20);
    DECLARE @tp_plan AS VARCHAR(20);

    -- Captura os dados do registro recém-inserido (tabela inserted)
    SELECT @num_ped = numero_pedido, 
           @num_cons = fk_consulta_numero_consulta, 
           @cod_ex = fk_exame_codigo 
    FROM inserted;

    -- Busca o preço base do exame
    SELECT @prc = preco FROM exame WHERE codigo = @cod_ex;

    -- Busca o CPF e o tipo de plano do paciente associado à consulta
    SELECT @cpf_pac = fk_paciente_cpf FROM consulta WHERE numero_consulta = @num_cons;
    SELECT @tp_plan = tipo_plano FROM paciente WHERE cpf = @cpf_pac;

    -- Aplicação das regras de desconto conforme o plano
    IF @tp_plan = 'Especial'
    BEGIN
        UPDATE pedido_exame 
        SET valor_pagar = @prc - (@prc * 100 / 100) 
        WHERE numero_pedido = @num_ped;
    END

    IF @tp_plan = 'Padrão'
    BEGIN
        UPDATE pedido_exame 
        SET valor_pagar = @prc - (@prc * 30 / 100) 
        WHERE numero_pedido = @num_ped;
    END

    IF @tp_plan = 'Básico'
    BEGIN
        UPDATE pedido_exame 
        SET valor_pagar = @prc - (@prc * 10 / 100) 
        WHERE numero_pedido = @num_ped;
    END

    PRINT 'Trigger (Atualiza Pedido de Exame) Encerrada';
END;
GO
