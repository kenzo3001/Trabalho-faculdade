Modelo Semântico

    Produto:
        id (PK)
        nome
        descricao
        preco
        estoque
        categoria_id (FK)

    Categoria:
        id (PK)
        nome

    Venda:
        id (PK)
        data
        total

    ItemVenda:
        id (PK)
        venda_id (FK)
        produto_id (FK)
        quantidade
        preco_unitario

Modelo Relacional

    Um produto pertence a uma categoria (Produtos -> Categoria).
    Uma venda pode ter muitos itens (Venda -> ItemVenda).
    Cada item de venda se refere a um produto (ItemVenda -> Produto).
