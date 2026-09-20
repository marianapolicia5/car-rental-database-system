-- Nomes: Mariana Polícia (22308010), Tiago Guerreiro (22307998)
-- Interrogações 

--1. Quais clientes realizaram alugueres no último mês?

SELECT cliente.nome, cliente.email, aluguer.dt_inicio
FROM cliente
NATURAL JOIN aluguer
WHERE aluguer.dt_inicio >= CURRENT_DATE - INTERVAL '1 MONTH';

--2. Qual cliente realizou o maior número de alugueres no ano passado?

SELECT cliente.nome, COUNT(aluguer.alug_id) AS total_alugueres
FROM cliente
NATURAL JOIN aluguer
WHERE aluguer.dt_inicio >= CURRENT_DATE - INTERVAL '1 YEAR'
GROUP BY cliente.nome
ORDER BY total_alugueres DESC
LIMIT 1;

--3. Quais equipamentos estão disponíveis para aluguer em uma data específica?

SELECT equipamentos.nome, inventario.qnt_disp, inventario.local
FROM equipamentos
NATURAL JOIN inventario
WHERE equipamentos.estado = 'Disponível' AND inventario.qnt_disp > 0;

--4. Qual equipamento foi mais alugado nos últimos seis meses?

SELECT equipamentos.nome, COUNT(aluguer.equip_id) AS total_alugueres
FROM equipamentos
NATURAL JOIN aluguer
WHERE aluguer.dt_inicio >= CURRENT_DATE - INTERVAL '6 MONTH'
GROUP BY equipamentos.nome
ORDER BY total_alugueres DESC
LIMIT 1;

--5. Quais equipamentos necessitam de manutenção?

SELECT equipamentos.nome, equipamentos.estado
FROM equipamentos
WHERE equipamentos.estado = 'Manutenção';

--6. Quantos clientes

SELECT COUNT(DISTINCT cliente.cliente_id) AS total_clientes
FROM cliente
INNER JOIN cartao ON cliente.cliente_id = cartao.cliente_id
WHERE cartao.promo_id = 2;

--7. Quantos eventos foram atendidos por cada funcionário em um determinado período?

SELECT funcionario.nome, COUNT(aluguer.alug_id) AS total_eventos
FROM funcionario
INNER JOIN aluguer ON funcionario.func_id = aluguer.func_id
WHERE aluguer.dt_inicio BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY funcionario.nome
ORDER BY total_eventos DESC;


--8. Qual foi a receita total gerada por alugueres em um determinado período?

SELECT SUM(aluguer.valor) AS receita_total
FROM aluguer
WHERE aluguer.dt_inicio BETWEEN '2024-01-01' AND '2024-06-01';

