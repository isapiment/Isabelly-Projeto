create database bd_DentalTech;
use bd_DentalTech;

create table Paciente(
id_pac int primary key auto_increment not null,
cpf_pac varchar(15) not null,
status_pac varchar(15) not null,
rg_pac int not null,
expedidor_pac varchar(100) not null,
estadoCivil_pac varchar(100) not null,
genero_pac varchar(100) not null,
email_pac varchar(300) not null,
telefone_pac float not null,
dataDeNascimento_pac date not null,
cep_pac float not null,
cidade_pac varchar(300) not null,
bairro_pac varchar(300) not null,
rua_pac varchar(300) not null,
numero_pac int not null
);

create table Funcionario(
id_func int primary key auto_increment not null,
cpf_func varchar(15) not null,
status_func varchar(15) not null,
rg_func int not null,
expedidor_func varchar(100) not null,
estadoCivil_func varchar(100) not null,
genero_func varchar(100) not null,
cargo_func varchar(100) not null,
email_func varchar(300) not null,
telefone_func float not null,
dataDeNascimento_func date not null,
cep_func float not null,
cidade_func varchar(300) not null,
bairro_func varchar(300) not null,
rua_func varchar(300) not null,
numero_func int not null,
dataDeAdmissao_func date not null,
ctps_func varchar(15) not null,
cnh_func varchar(15) not null,
senha_func varchar(50) not null
);

create table Agendamento(
id_age int primary key auto_increment not null,
data_age date not null,
hora_age time not null,
id_pac_fk int,
id_func_fk int,
foreign key(id_pac_fk)references Paciente(id_pac),
foreign key(id_func_fk)references Funcionario(id_func)
);

create table Anamnese(
id_anam int primary key auto_increment not null,
data_anam date not null,
febre_anam bool not null,
tratamento_anam bool not null,
cicatrizacao_anam bool not null,
anestesia_anam bool not null,
drogas_anam bool not null,
diabetes_anam bool not null,
doencas_anam bool not null,
hipertensao_anam bool not null,
id_pac_fk int,
id_func_fk int,
foreign key(id_pac_fk)references Paciente (id_pac),
foreign key(id_func_fk)references Funcionario (id_func)
);

create table Consulta(
id_cons int primary key auto_increment not null,
data_cons date not null,
hora_cons time not null,
valor_cons double not null,
descricao_cons varchar(500) not null,
id_pac_fk int,
id_func_fk int,
id_anam_fk int,
foreign key(id_pac_fk)references Paciente (id_pac),
foreign key(id_func_fk)references Funcionario (id_func),
foreign key(id_anam_fk)references Anamnese (id_anam)
);

create table Orcamento(
id_orca int primary key auto_increment not null,
id_pac_fk int,
id_func_fk int,
foreign key(id_pac_fk)references Paciente (id_pac),
foreign key(id_func_fk)references Funcionario (id_func)
);

create table Fornecedor(
id_forn int primary key auto_increment not null,
razaosocial_forn varchar (200),
nomefantasial_forn varchar (100),
representante_forn varchar (100),
telefone_forn varchar (100)
);

create table Produto(
id_prod int primary key auto_increment not null,
nome_prod varchar(300) not null,
dataFabricacao_prod date not null,
dataValidade_prod date not null,
codigoBarras_prod int not null,
valor_prod float not null
);

create table Compra_Produto (
id_comp int not null primary key auto_increment,
data_comp date,
valor_total_comp double,
forma_pagamento_comp varchar (100),
id_func_fk int not null,
id_forn_fk int not null,
foreign key (id_func_fk) references Funcionario (id_func),
foreign key (id_forn_fk) references Fornecedor (id_forn)
);

create table Itens_Compra (
id_itc int not null primary key auto_increment,
quant_itc int not null,
valor_itc float not null,
id_prod_fk int not null,
id_comp_fk int not null,
foreign key (id_prod_fk) references Produto (id_prod),
foreign key (id_comp_fk) references Compra_Produto (id_comp)
);

create table Caixa (
id_cai int not null primary key auto_increment,
data_abertura_cai date not null,
data_fechamento_cai date,
saldo_inicial_cai double not null,
troco_cai double,
valor_creditos_cai double,
valor_debitos_cai double,
saldo_final_cai double,
status_cai varchar (100) not null
);

create table Servico(
id_serv int primary key auto_increment not null,
nome_serv varchar(200) not null,
descricao_serv varchar(500) not null,
id_func_fk int,
id_orca_fk int,
foreign key(id_func_fk)references Funcionario(id_func)
);

create table Venda (
id_vend int not null primary key auto_increment,
data_vend date,
valor_total_vend double not null,
desconto_vend double,
forma_recebimento_vend varchar (50),
parcelas_vend int,
id_func_fk int not null,
id_pac_fk int not null,
foreign key (id_func_fk) references Funcionario (id_func),
foreign key (id_pac_fk) references Paciente (id_pac)
);

create table Servico_Venda (
id_itv int not null primary key auto_increment,
quant_itv int not null,
id_serv_fk int not null,
id_vend_fk int not null,
id_orca_fk int not null,
foreign key (id_serv_fk) references Servico (id_serv),
foreign key (id_vend_fk) references Venda (id_vend),
foreign key (id_orca_fk) references Orcamento (id_orca)
);

create table Recebimentos (
id_rec int not null primary key auto_increment,
data_vencimento_rec date,
valor_rec double,
parcela_rec varchar(100),
status_rec varchar (100),
forma_recebimento_rec varchar (100),
data_recebimento_rec date,
id_func_fk int,
id_cai_fk int,
id_vend_fk int not null,
foreign key (id_func_fk) references Funcionario (id_func),
foreign key (id_cai_fk) references Caixa (id_cai),
foreign key (id_vend_fk) references Venda (id_vend)
);

create table Despesa(
id_desp int not null primary key auto_increment,
descricao_desp varchar (200),
valor_desp double,
numero_documento_desp int,
id_forn_fk int,
foreign key (id_forn_fk) references Fornecedor (id_forn)
);

create table Pagamentos (
id_pag int not null primary key auto_increment,
data_vencimento_pag date,
valor_pag float,
parcela_pag varchar (100),
status_pag varchar (100),
forma_pagamento_pag varchar (100),
data_pagamento_pag date,
id_func_fk int,
id_cai_fk int,
id_desp_fk int,
id_comp_fk int,
foreign key (id_func_fk) references Funcionario (id_func),
foreign key (id_cai_fk) references Caixa (id_cai),
foreign key (id_desp_fk) references Despesa (id_desp),
foreign key (id_comp_fk) references Compra_produto (id_comp)
);














