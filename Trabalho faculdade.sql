-- Criação do banco de dados
CREATE DATABASE Loja;

-- Uso do banco de dados
USE Loja;

-- Tabela de Categorias
CREATE TABLE Categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

-- Tabela de Produtos
CREATE TABLE Produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL,
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES Categorias(id)
);

-- Tabela de Vendas
CREATE TABLE Vendas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data DATE NOT NULL,
    total DECIMAL(10, 2) NOT NULL
);

-- Tabela de Itens de Venda
CREATE TABLE ItensVenda (
    id INT AUTO_INCREMENT PRIMARY KEY,
    venda_id INT,
    produto_id INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (venda_id) REFERENCES Vendas(id),
    FOREIGN KEY (produto_id) REFERENCES Produtos(id)
);

-- Inserindo Categorias
INSERT INTO Categorias (nome) VALUES
('Eletrônicos'),
('Informática'),
('Periféricos');

-- Inserindo 10.000 Produtos
-- Usando um loop de geração de produtos
DELIMITER $$

CREATE PROCEDURE InsertProducts()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE categoryId INT DEFAULT 1;
    WHILE i <= 10000 DO
        SET categoryId = (i % 3) + 1; -- Distribuindo produtos nas 3 categorias
        INSERT INTO Produtos (nome, descricao, preco, estoque, categoria_id) 
        VALUES (
            CONCAT('Produto ', i), 
            CONCAT('Descrição do produto ', i, ' com recursos exclusivos e design inovador.'), 
            ROUND((RAND() * (5000 - 10) + 10), 2), -- Preço aleatório entre 10.00 e 5000.00
            FLOOR(RAND() * (100 - 1) + 1), -- Estoque aleatório entre 1 e 100
            categoryId
        );
        SET i = i + 1;
    END WHILE;
END $$

DELIMITER ;

CALL InsertProducts();

DROP PROCEDURE IF EXISTS InsertProducts;

-- Consultas de produtos com suas categorias
SELECT p.id, p.nome, p.descricao, p.preco, p.estoque, c.nome AS categoria
FROM Produtos p
JOIN Categorias c ON p.categoria_id = c.id
LIMIT 10;

-- Consultas de vendas e seus itens
SELECT v.id, v.data, v.total, iv.produto_id, iv.quantidade, iv.preco_unitario
FROM Vendas v
JOIN ItensVenda iv ON v.id = iv.venda_id;
