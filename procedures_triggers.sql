-- Nomes: Mariana Polícia (22308010), Tiago Guerreiro (22307998)
-- Triggers e store procedures


--Store Procedures
--Adicionar Novo Equipamento

CREATE OR REPLACE FUNCTION adicionar_equipamento(
    nome_equipamento VARCHAR(60),
    tipo_equipamento VARCHAR(60),
    dimensao_equipamento VARCHAR(40),
    capacidade_equipamento INT,
    estado_equipamento VARCHAR(50),
    preco_por_dia INT
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO equipamentos (nome, tipo, dimensao, cap, estado, ppd)
    VALUES (nome_equipamento, tipo_equipamento, dimensao_equipamento, capacidade_equipamento, estado_equipamento, preco_por_dia);
END;
$$ LANGUAGE plpgsql;

-- Obter Receita Total num Período

CREATE OR REPLACE FUNCTION obter_receita(
    data_inicio DATE,
    data_fim DATE
)
RETURNS NUMERIC AS $$
DECLARE
    receita_total NUMERIC;
BEGIN
    SELECT COALESCE(SUM(valor), 0) INTO receita_total
    FROM aluguer
    WHERE dt_inicio BETWEEN data_inicio AND data_fim;

    RETURN receita_total;
END;
$$ LANGUAGE plpgsql;


--Triggers
-- Atualizar Inventário Após Aluguer

CREATE OR REPLACE FUNCTION atualizar_inventario_apos_aluguer()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE inventario
    SET qnt_disp = qnt_disp - 1
    WHERE equip_id = NEW.equip_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_atualizar_inventario
AFTER INSERT ON aluguer
FOR EACH ROW
EXECUTE FUNCTION atualizar_inventario_apos_aluguer();

-- Registar Eliminação de Alugueres 

CREATE OR REPLACE FUNCTION registar_eliminacao_aluguer()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_table (mensagem_log, data_log)
    VALUES (CONCAT('ID do Aluguer ', OLD.alug_id, ' foi eliminado.'), NOW());
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_registar_eliminacao
AFTER DELETE ON aluguer
FOR EACH ROW
EXECUTE FUNCTION registar_eliminacao_aluguer();