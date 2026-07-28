-- ============================================================================
-- 1. CRIAÇÃO E SELEÇÃO DO BANCO DE DADOS (DDL)
-- ============================================================================
CREATE DATABASE clinica_medica;
GO

USE clinica_medica;
GO

-- ============================================================================
-- 2. CRIAÇÃO DAS TABELAS (DDL)
-- ============================================================================

CREATE TABLE paciente (
    cpf VARCHAR(14) PRIMARY KEY,
    nome_paciente VARCHAR(40),
    telefone VARCHAR(14),
    numero_plano INT,
    nome_plano VARCHAR(20),
    tipo_plano VARCHAR(10)
);

CREATE TABLE medico (
    crm INT PRIMARY KEY,
    nome_medico VARCHAR(30),
    especialidade VARCHAR(20)
);

CREATE TABLE exame (
    codigo INT PRIMARY KEY,
    especificacao VARCHAR(20),
    preco MONEY
);

CREATE TABLE consulta (
    numero_consulta INT IDENTITY(22000,1) PRIMARY KEY,
    data_consulta DATE,
    horario_consulta TIME,
    fk_paciente_cpf VARCHAR(14),
    fk_medico_crm INT
);

CREATE TABLE pedido_exame (
    numero_pedido INT IDENTITY(2200,1) PRIMARY KEY,
    resultado VARCHAR(40), 
    data_exame DATE,
    valor_pagar MONEY,
    fk_consulta_numero_consulta INT,
    fk_exame_codigo INT
);

-- ============================================================================
-- 3. ADIÇÃO DE RESTRIÇÕES DE CHAVE ESTRANGEIRA / INTEGRIDADE (DDL)
-- ============================================================================

ALTER TABLE consulta ADD CONSTRAINT FK_consulta_paciente
    FOREIGN KEY (fk_paciente_cpf)
    REFERENCES paciente (cpf)
    ON DELETE CASCADE;

ALTER TABLE consulta ADD CONSTRAINT FK_consulta_medico
    FOREIGN KEY (fk_medico_crm)
    REFERENCES medico (crm)
    ON DELETE CASCADE;

ALTER TABLE pedido_exame ADD CONSTRAINT FK_pedido_exame_consulta
    FOREIGN KEY (fk_consulta_numero_consulta)
    REFERENCES consulta (numero_consulta)
    ON DELETE CASCADE;

ALTER TABLE pedido_exame ADD CONSTRAINT FK_pedido_exame_exame
    FOREIGN KEY (fk_exame_codigo)
    REFERENCES exame (codigo);

-- ============================================================================
-- 4. INCLUSÃO DE DADOS (DML - INSERT)
-- ============================================================================

-- Inserindo Pacientes
INSERT INTO paciente VALUES('012.345.678-90', 'Leonardo Ribeiro', '(11)91234-5678', 123456, 'Inovamed', 'Padrão');
INSERT INTO paciente VALUES('123.456.789-12', 'Bruna Alvez', '(15)92345-6789', 234567, 'Ultramed', 'Básico');
INSERT INTO paciente VALUES('234.567.890-23', 'Gilberto Barros', '(11)94567-8901', 345678, 'Inovamed', 'Especial');
INSERT INTO paciente VALUES('345.678.901-45', 'Maria Pereira', '(12)95678-9012', 456789, 'Ultramed', 'Padrão');
INSERT INTO paciente VALUES('456.789.012-34', 'Arnaldo Coelho', '(19)96789-0123', 567890, 'Inovamed', 'Especial');

-- Inserindo Médicos
INSERT INTO medico VALUES(102030, 'Agildo Nunes', 'Cardiologia');
INSERT INTO medico VALUES(203040, 'Márcia Alvez', 'Gastrologia');
INSERT INTO medico VALUES(304050, 'Roberto Gusmão', 'Neurologia');
INSERT INTO medico VALUES(405060, 'Edna Cardoso', 'Ortopedia');
INSERT INTO medico VALUES(506070, 'Ricardo Souza', 'Otorrinolaringologia');
INSERT INTO medico VALUES(607080, 'Lúcia Marques', 'Pediatria');
INSERT INTO medico VALUES(708090, 'Beatriz Lucena', 'Oncologia');

-- Inserindo Exames
INSERT INTO exame VALUES(10020, 'Hemograma', 100.00);
INSERT INTO exame VALUES(10030, 'Tomografia', 250.00);
INSERT INTO exame VALUES(10040, 'Ultrassonografia', 550.00);
INSERT INTO exame VALUES(10050, 'Ressonância', 800.00);
INSERT INTO exame VALUES(10060, 'Radiografia', 70.00);
INSERT INTO exame VALUES(10070, 'Mamografia', 150.00);
INSERT INTO exame VALUES(10080, 'Endoscopia', 300.00);
INSERT INTO exame VALUES(10090, 'Colonoscopia', 300.00);
INSERT INTO exame VALUES(10100, 'Eletrocardiograma', 50.00);
INSERT INTO exame VALUES(10110, 'Ecocardiograma', 120.00);
INSERT INTO exame VALUES(10120, 'Audiometria', 65.00);

-- Inserindo Consultas
INSERT INTO consulta VALUES('2022/12/12', '14:30', '012.345.678-90', 102030);
INSERT INTO consulta VALUES('2022/12/13', '08:30', '123.456.789-12', 203040);
INSERT INTO consulta VALUES('2022/12/13', '11:00', '123.456.789-12', 304050);
INSERT INTO consulta VALUES('2022/12/14', '10:00', '234.567.890-23', 203040);
INSERT INTO consulta VALUES('2022/12/15', '15:00', '345.678.901-45', 405060);
INSERT INTO consulta VALUES('2022/12/16', '10:00', '123.456.789-12', 506070);
INSERT INTO consulta VALUES('2022/12/19', '16:45', '234.567.890-23', 102030);
INSERT INTO consulta VALUES('2022/12/19', '18:00', '345.678.901-45', 607080);
INSERT INTO consulta VALUES('2022/12/20', '09:00', '012.345.678-90', 304050);
INSERT INTO consulta VALUES('2022/12/20', '14:20', '123.456.789-12', 102030);

-- Inserindo Pedidos de Exames
INSERT INTO pedido_exame VALUES('Normal', '2022/12/15', 0.00, 22000, 10040);
INSERT INTO pedido_exame VALUES('', '2022/12/19', 0.00, 22000, 10100);
INSERT INTO pedido_exame VALUES('', '2022/12/16', 0.00, 22001, 10080);
INSERT INTO pedido_exame VALUES('Normal', '2022/12/15', 0.00, 22002, 10050);
INSERT INTO pedido_exame VALUES('Inconsistente', '2022/12/16', 0.00, 22003, 10080);
INSERT INTO pedido_exame VALUES('', '2022/12/17', 0.00, 22004, 10060);
INSERT INTO pedido_exame VALUES('Normal', '2022/12/21', 0.00, 22007, 10020);
INSERT INTO pedido_exame VALUES('', '2022/12/22', 0.00, 22008, 10030);
INSERT INTO pedido_exame VALUES('', '2022/12/22', 0.00, 22008, 10050);

-- Consultas de Verificação (DQL)
SELECT * FROM paciente;
SELECT * FROM medico;
SELECT * FROM exame;
SELECT * FROM consulta;
SELECT * FROM pedido_exame;

-- ============================================================================
-- 5. ALTERAÇÃO DE DADOS (DML - UPDATE)
-- ============================================================================

-- Atualizando nome do paciente
UPDATE paciente 
SET nome_paciente = 'Aguinaldo Coelho' 
WHERE cpf = '456.789.012-34';

-- Atualizando especialidade do médico
UPDATE medico 
SET especialidade = 'Ginecologia' 
WHERE crm = 708090;

-- Atualizando preço do exame
UPDATE exame 
SET preco = 135.00 
WHERE codigo = 10110;

-- ============================================================================
-- 6. EXCLUSÃO DE DADOS (DML - DELETE)
-- ============================================================================

-- Removendo um paciente (as consultas associadas serão removidas por CASCADE)
DELETE FROM paciente 
WHERE cpf = '456.789.012-34';

-- Removendo um médico (as consultas associadas serão removidas por CASCADE)
DELETE FROM medico 
WHERE crm = 708090;
