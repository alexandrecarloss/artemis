-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema artemis
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema artemis
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `artemis` DEFAULT CHARACTER SET utf8mb3 ;
USE `artemis` ;

-- -----------------------------------------------------
-- Table `artemis`.`pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`pessoa` (
  `pesid` INT NOT NULL AUTO_INCREMENT,
  `pescpf` CHAR(11) NOT NULL,
  `pesdtnascto` DATE NOT NULL,
  `pessexo` CHAR(1) NOT NULL,
  `pescidade` VARCHAR(65) NOT NULL,
  `pesbairro` VARCHAR(65) NOT NULL,
  `pesrua` VARCHAR(65) NOT NULL,
  `pesemail` VARCHAR(70) NOT NULL,
  `pesnumero` SMALLINT NOT NULL,
  `pestelefone` VARCHAR(15) NOT NULL,
  `pesnome` VARCHAR(100) NOT NULL,
  `pesestado` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`pesid`),
  UNIQUE INDEX `pesid_UNIQUE` (`pesid` ASC) VISIBLE,
  UNIQUE INDEX `pescpf_UNIQUE` (`pescpf` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `artemis`.`petshop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`petshop` (
  `ptsid` INT NOT NULL AUTO_INCREMENT,
  `ptsnome` VARCHAR(65) NULL DEFAULT NULL,
  `ptscnpj` VARCHAR(20) NOT NULL,
  `ptscidade` VARCHAR(65) NULL DEFAULT NULL,
  `ptsbairro` VARCHAR(65) NULL DEFAULT NULL,
  `ptsrua` VARCHAR(65) NULL DEFAULT NULL,
  `ptsnumero` SMALLINT NULL DEFAULT NULL,
  `ptstelefone` VARCHAR(15) NULL DEFAULT NULL,
  `ptsemail` VARCHAR(70) NULL DEFAULT NULL,
  `ptsestado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ptsid`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `artemis`.`categoria_produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`categoria_produto` (
  `ctpid` INT NOT NULL AUTO_INCREMENT,
  `ctpnome` VARCHAR(60) NOT NULL,
  `ctpdescricao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ctpid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `artemis`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`produto` (
  `proid` INT NOT NULL AUTO_INCREMENT,
  `pronome` VARCHAR(65) NOT NULL,
  `propreco` DOUBLE(6,2) NOT NULL,
  `prosaldo` INT NULL DEFAULT NULL,
  `propetshop_ptsid` INT NOT NULL,
  `categoria_produto_ctpid` INT NOT NULL,
  PRIMARY KEY (`proid`),
  INDEX `fk_produto_petshop1_idx` (`propetshop_ptsid` ASC) VISIBLE,
  INDEX `fk_produto_categoria_produto1_idx` (`categoria_produto_ctpid` ASC) VISIBLE,
  CONSTRAINT `fk_produto_petshop1`
    FOREIGN KEY (`propetshop_ptsid`)
    REFERENCES `artemis`.`petshop` (`ptsid`),
  CONSTRAINT `fk_produto_categoria_produto1`
    FOREIGN KEY (`categoria_produto_ctpid`)
    REFERENCES `artemis`.`categoria_produto` (`ctpid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `artemis`.`tiposervico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`tiposervico` (
  `tpsid` INT NOT NULL AUTO_INCREMENT,
  `tpsnome` VARCHAR(70) NOT NULL,
  `tpsdescricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tpsid`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `artemis`.`servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`servico` (
  `serid` INT NOT NULL AUTO_INCREMENT,
  `servalor` FLOAT NOT NULL,
  `petshop_ptsid` INT NOT NULL,
  `tiposervico_tpsid` INT NOT NULL,
  `serdescricao` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`serid`),
  INDEX `fk_tosa_petshop1_idx` (`petshop_ptsid` ASC) VISIBLE,
  INDEX `fk_servico_tiposervico1_idx` (`tiposervico_tpsid` ASC) VISIBLE,
  CONSTRAINT `fk_servico_tiposervico1`
    FOREIGN KEY (`tiposervico_tpsid`)
    REFERENCES `artemis`.`tiposervico` (`tpsid`),
  CONSTRAINT `servico_ibfk_1`
    FOREIGN KEY (`petshop_ptsid`)
    REFERENCES `artemis`.`petshop` (`ptsid`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `artemis`.`avaliacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`avaliacao` (
  `produto_proid` INT NULL DEFAULT NULL,
  `servico_serid` INT NULL DEFAULT NULL,
  `avadescricao` VARCHAR(100) NULL DEFAULT NULL,
  `avavalor` INT NOT NULL,
  `pessoa_pesid` INT NOT NULL,
  `avacod` INT NOT NULL AUTO_INCREMENT,
  `avadthora` DATETIME NULL DEFAULT current_timestamp,
  PRIMARY KEY (`avacod`),
  INDEX `fk_avaliacao_servico1_idx` (`servico_serid` ASC) VISIBLE,
  INDEX `fk_avaliacao_pessoa1_idx` (`pessoa_pesid` ASC) VISIBLE,
  INDEX `fk_avaliacao_produto1` (`produto_proid` ASC) VISIBLE,
  CONSTRAINT `fk_avaliacao_pessoa1`
    FOREIGN KEY (`pessoa_pesid`)
    REFERENCES `artemis`.`pessoa` (`pesid`),
  CONSTRAINT `fk_avaliacao_produto1`
    FOREIGN KEY (`produto_proid`)
    REFERENCES `artemis`.`produto` (`proid`),
  CONSTRAINT `fk_avaliacao_servico1`
    FOREIGN KEY (`servico_serid`)
    REFERENCES `artemis`.`servico` (`serid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `artemis`.`carrinho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`carrinho` (
  `carid` INT NOT NULL AUTO_INCREMENT,
  `carpro` INT NULL DEFAULT NULL,
  `carpes` INT NOT NULL,
  `carser` INT NULL DEFAULT NULL,
  `carquant` INT NOT NULL,
  `carpreco` FLOAT NOT NULL,
  PRIMARY KEY (`carid`),
  INDEX `fk_carrinho_produto1_idx` (`carpro` ASC) VISIBLE,
  INDEX `fk_carrinho_pessoa1_idx` (`carpes` ASC) VISIBLE,
  INDEX `fk_carrinho_servico1_idx` (`carser` ASC) VISIBLE,
  CONSTRAINT `fk_carrinho_pessoa1`
    FOREIGN KEY (`carpes`)
    REFERENCES `artemis`.`pessoa` (`pesid`),
  CONSTRAINT `fk_carrinho_produto1`
    FOREIGN KEY (`carpro`)
    REFERENCES `artemis`.`produto` (`proid`),
  CONSTRAINT `fk_carrinho_servico1`
    FOREIGN KEY (`carser`)
    REFERENCES `artemis`.`servico` (`serid`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `artemis`.`formapagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`formapagamento` (
  `fpgid` INT NOT NULL AUTO_INCREMENT,
  `fpgdescricao` VARCHAR(65) NULL DEFAULT NULL,
  PRIMARY KEY (`fpgid`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `artemis`.`venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`venda` (
  `venid` INT NOT NULL auto_increment,
  `venser` INT NULL DEFAULT NULL,
  `venpro` INT NULL DEFAULT NULL,
  `venformapagamento_fpgid` INT NOT NULL,
  `venpessoa_pesid` INT NOT NULL,
  `venvalor` FLOAT NOT NULL,
  `vendthora` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `venqtd` INT NOT NULL,
  PRIMARY KEY (`venid`),
  INDEX `fk_venda_formapagamento1_idx` (`venformapagamento_fpgid` ASC) VISIBLE,
  INDEX `fk_venda_pessoa1_idx` (`venpessoa_pesid` ASC) VISIBLE,
  CONSTRAINT `fk_venda_formapagamento1`
    FOREIGN KEY (`venformapagamento_fpgid`)
    REFERENCES `artemis`.`formapagamento` (`fpgid`),
  CONSTRAINT `fk_venda_pessoa1`
    FOREIGN KEY (`venpessoa_pesid`)
    REFERENCES `artemis`.`pessoa` (`pesid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `artemis`.`ong`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`ong` (
  `ongid` INT NOT NULL AUTO_INCREMENT,
  `ongnome` VARCHAR(65) NOT NULL,
  `ongcidade` VARCHAR(70) NULL DEFAULT NULL,
  `ongbairro` VARCHAR(70) NOT NULL,
  `ongrua` VARCHAR(70) NOT NULL,
  `ongnum` SMALLINT NOT NULL,
  `ongtelefone` VARCHAR(15) NULL DEFAULT NULL,
  `ongemail` VARCHAR(70) NULL DEFAULT NULL,
  `ongestado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ongid`),
  UNIQUE INDEX `ongid_UNIQUE` (`ongid` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `artemis`.`pet_porte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`pet_porte` (
  `ptpid` INT NOT NULL AUTO_INCREMENT,
  `ptpnome` VARCHAR(65) NOT NULL,
  `ptpdescricao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ptpid`),
  UNIQUE INDEX `ptpid_UNIQUE` (`ptpid` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `artemis`.`pet_tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`pet_tipo` (
  `pttid` INT NOT NULL,
  `pttnome` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`pttid`),
  UNIQUE INDEX `pttid_UNIQUE` (`pttid` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `artemis`.`pet_raca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`pet_raca` (
  `ptrid` INT NOT NULL auto_increment,
  `ptrnome` VARCHAR(65) NULL DEFAULT NULL,
  `pet_tipo_pttid` INT NOT NULL,
  PRIMARY KEY (`ptrid`),
  UNIQUE INDEX `racaid_UNIQUE` (`ptrid` ASC) VISIBLE,
  INDEX `fk_pet_raca_pet_tipo1_idx` (`pet_tipo_pttid` ASC) VISIBLE,
  CONSTRAINT `fk_pet_raca_pet_tipo1`
    FOREIGN KEY (`pet_tipo_pttid`)
    REFERENCES `artemis`.`pet_tipo` (`pttid`))
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `artemis`.`pet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`pet` (
  `petid` INT NOT NULL AUTO_INCREMENT,
  `petnome` VARCHAR(65) NOT NULL,
  `petsexo` CHAR(1) NOT NULL,
  `petcastrado` ENUM('Castrado', 'Não Castrado', 'Não sei') NOT NULL,
  `petdtnascto` DATE NOT NULL,
  `petpeso` FLOAT NOT NULL,
  `pessoa_pesid` INT NULL DEFAULT NULL,
  `pet_porte_ptpid` INT NOT NULL,
  `pet_raca_ptrid` INT NOT NULL,
  `pet_tipo_pttid` INT NOT NULL,
  PRIMARY KEY (`petid`),
  UNIQUE INDEX `petid_UNIQUE` (`petid` ASC) VISIBLE,
  INDEX `fk_pet_pessoa1_idx` (`pessoa_pesid` ASC) VISIBLE,
  INDEX `fk_pet_pet_porte1_idx` (`pet_porte_ptpid` ASC) VISIBLE,
  INDEX `fk_pet_pet_raca1_idx` (`pet_raca_ptrid` ASC) VISIBLE,
  INDEX `fk_pet_pet_tipo1_idx` (`pet_tipo_pttid` ASC) VISIBLE,
  CONSTRAINT `fk_pet_pessoa1`
    FOREIGN KEY (`pessoa_pesid`)
    REFERENCES `artemis`.`pessoa` (`pesid`),
  CONSTRAINT `fk_pet_pet_porte1`
    FOREIGN KEY (`pet_porte_ptpid`)
    REFERENCES `artemis`.`pet_porte` (`ptpid`),
  CONSTRAINT `fk_pet_pet_raca1`
    FOREIGN KEY (`pet_raca_ptrid`)
    REFERENCES `artemis`.`pet_raca` (`ptrid`),
  CONSTRAINT `fk_pet_pet_tipo1`
    FOREIGN KEY (`pet_tipo_pttid`)
    REFERENCES `artemis`.`pet_tipo` (`pttid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `artemis`.`pet_adocao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`pet_adocao` (
  `ong_ongid` INT NOT NULL,
  `pet_petid` INT NOT NULL,
  `adoid` INT NOT NULL AUTO_INCREMENT,
  `adostatus` ENUM("Aguardando","Adotado") NOT NULL default "Aguardando",
  PRIMARY KEY (`adoid`),
  INDEX `fk_pet_adocao_ong1_idx` (`ong_ongid` ASC) VISIBLE,
  INDEX `fk_pet_adocao_pet1` (`pet_petid` ASC) VISIBLE,
  CONSTRAINT `fk_pet_adocao_ong1`
    FOREIGN KEY (`ong_ongid`)
    REFERENCES `artemis`.`ong` (`ongid`),
  CONSTRAINT `fk_pet_adocao_pet1`
    FOREIGN KEY (`pet_petid`)
    REFERENCES `artemis`.`pet` (`petid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `artemis`.`pet_foto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`pet_foto` (
  `pftid` INT NOT NULL AUTO_INCREMENT,
  `pftfoto` VARCHAR(100) NOT NULL,
  `pet_petid` INT NOT NULL,
  PRIMARY KEY (`pftid`),
  UNIQUE INDEX `pftid_UNIQUE` (`pftid` ASC) VISIBLE,
  INDEX `fk_pet_foto_pet_idx` (`pet_petid` ASC) VISIBLE,
  CONSTRAINT `fk_pet_foto_pet`
    FOREIGN KEY (`pet_petid`)
    REFERENCES `artemis`.`pet` (`petid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `artemis`.`produto_foto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`produto_foto` (
  `prfid` INT NOT NULL AUTO_INCREMENT,
  `prffoto` VARCHAR(100) NOT NULL,
  `produto_proid` INT NOT NULL,
  PRIMARY KEY (`prfid`),
  UNIQUE INDEX `prfid_UNIQUE` (`prfid` ASC) VISIBLE,
  INDEX `fk_produto_foto_produto1_idx` (`produto_proid` ASC) VISIBLE,
  CONSTRAINT `fk_produto_foto_produto1`
    FOREIGN KEY (`produto_proid`)
    REFERENCES `artemis`.`produto` (`proid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `artemis`.`solicita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`solicita` (
  `pessoa_pesid` INT NOT NULL,
  `servico_serid` INT NOT NULL,
  `solid` INT NOT NULL AUTO_INCREMENT,
  `soldthr` DATETIME NOT NULL,
  `solpetid` INT NOT NULL,
  `solstatus` ENUM("Requerido", "Cancelado", "Concluído") NOT NULL,
  PRIMARY KEY (`solid`),
  INDEX `fk_pessoa_has_servico_servico1_idx` (`servico_serid` ASC) VISIBLE,
  INDEX `fk_pessoa_has_servico_pessoa1_idx` (`pessoa_pesid` ASC) VISIBLE,
  CONSTRAINT `fk_pessoa_has_servico_pessoa1`
    FOREIGN KEY (`pessoa_pesid`)
    REFERENCES `artemis`.`pessoa` (`pesid`),
  CONSTRAINT `fk_pessoa_has_servico_servico1`
    FOREIGN KEY (`servico_serid`)
    REFERENCES `artemis`.`servico` (`serid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `artemis`.`tentativa_adota`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`tentativa_adota` (
  `ttaid` INT NOT NULL AUTO_INCREMENT,
  `ttapes` INT NOT NULL,
  `tta_petadocao` INT NOT NULL,
  `ttastatus` ENUM("Requisitado", "Aceito", "Negado", "Adotado", "Não Adotado") NOT NULL,
  `ttadthora` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ttaid`),
  INDEX `ttapes` (`ttapes` ASC) VISIBLE,
  INDEX `tta_petadocao` (`tta_petadocao` ASC) VISIBLE,
  CONSTRAINT `tentativa_adota_ibfk_1`
    FOREIGN KEY (`ttapes`)
    REFERENCES `artemis`.`pessoa` (`pesid`),
  CONSTRAINT `tentativa_adota_ibfk_2`
    FOREIGN KEY (`tta_petadocao`)
    REFERENCES `artemis`.`pet_adocao` (`adoid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

/* avaliação */

delimiter $$
create procedure sp_insere_avaliacao (produto int, servico int, descricao varchar(500), valor int, pessoa int)
begin
if (pessoa in (select pesid from pessoa)) then
	if((produto in (select proid from produto)) or (servico in(select serid from servico))) then
		insert into avaliacao (produto_proid,servico_serid,avadescricao,avavalor,pessoa_pesid)
        values (produto, servico, descricao, valor, pessoa);
    else
		select "Aavaliação não pode ser realizada";
    end if;
else
	select "Pessoa não existe";
end if;
end $$
delimiter ;

delimiter $$
create procedure sp_exclui_avaliacao (cod int)
begin
if (cod in (select avacod from avaliacao)) then
	delete from avaliacao
    where avacod = cod;
else
	select "Avaliação não existe";
end if;
end $$
delimiter ;
/* ong */

DELIMITER $$
CREATE PROCEDURE `sp_insere_ong`(nome varchar(100), estado varchar(45), cidade varchar(100), bairro varchar(100), rua varchar(100), num int, telefone varchar(100), email varchar(100))
begin
	if (email like '%@%') then
     insert into ong (ongnome,ongestado, ongcidade,ongbairro,ongrua,ongnum,ongtelefone,ongemail) values
     (nome, estado, cidade, bairro, rua, num, telefone, email);
    else
      select "E-mail inválido";
    end if;
    
end$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_excluiong`(cod int)
begin

if (cod in (select ongid from ong)) then
	delete from ong
	where ongid = cod;
else
	select "Ong não existe";
end if;

end$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_alteraong`(nome varchar(70), estado varchar(45), cidade varchar(70), bairro varchar(70), rua varchar(70), email varchar(70), numero int, telefone varchar(12), cod int)
begin
if (email like '%@%') then
	update ong 
	set ongnome=nome,
	ongcidade=cidade,
	ongbairro=bairro,
	ongrua=rua,
	ongemail=email,
	ongnum=numero,
	ongtelefone=telefone,
	ongestado=estado
	where cod=ongid;
else
      select "E-mail inválido";
end if;
end$$
DELIMITER ;

delimiter ##
CREATE TRIGGER `artemis`.`tg_exclui_ong`
BEFORE DELETE ON `artemis`.`ong`
FOR EACH ROW
begin

delete from pet_adocao
where ong_ongid = old.ongid;

end$$
DELIMITER ;


/* petshop */

DELIMITER $$
CREATE PROCEDURE `sp_insere_petshop`(nome varchar(100), cnpj varchar (14),estado varchar(45),cidade varchar(100), bairro varchar(100), rua varchar(100), num int, telefone varchar(100), email varchar(100))
begin
	if (email like '%@%') then
     insert into petshop (ptsnome,ptscnpj,ptsestado,ptscidade,ptsbairro,ptsrua,ptsnumero,ptstelefone,ptsemail) values
     (nome,cnpj, estado, cidade, bairro, rua, num, telefone, email);
    else
      select "E-mail inválido";
    end if;
end$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE `sp_exclui_petshop`(cod int)
begin

if (cod in (select ptsid from petshop)) then
	delete from petshop
	where ptsid = cod;
else
	select "Pethop não existe";
end if;

end$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_alterapetshop`(nome varchar(70), cnpj varchar(20), estado varchar(45), cidade varchar(70), bairro varchar(70), rua varchar(70), email varchar(70), numero int, telefone varchar(12), cod int)
begin
if (email like '%@%') then
	update petshop
	set ptsnome=nome,
    ptscnpj = cnpj,
	ptscidade=cidade,
	ptsbairro=bairro,
	ptsrua=rua,
	ptsemail=email,
	ptsnumero=numero,
	ptstelefone=telefone,
	ptsestado=estado
	where cod=ptsid;
else
      select "E-mail inválido";
end if;
end$$
DELIMITER ;

delimiter $$
CREATE TRIGGER `artemis`.`tg_exclui_petshop`
BEFORE DELETE ON `artemis`.`petshop`
FOR EACH ROW
begin

delete from servico
where petshop_ptsid = old.ptsid;

delete from produto
where propetshop_ptsid = old.ptsid;

end$$
DELIMITER ;

create view visualiza_cidades as
select distinct(ptscidade) as "Cidades" from petshop
group by ptsid, ptscidade;

delimiter $$
create procedure sp_busca_cidade (cidade varchar (100))
begin
	if (cidade in (select * from visualiza_cidades)) then
		select concat("Cidade: ",ptscidade,"; Bairro: ",ptsbairro, "; Rua: ",ptsrua,"; Número: ", ptsnumero) as "Endereço" from petshop
		where upper(ptscidade) = upper(cidade)
        group by ptsid, ptscidade;
    else 
		select "Cidade não cadastradas por petshops";
    end if;
end $$
delimiter ;

/* pessoa */

DELIMITER $$
CREATE PROCEDURE `sp_inserepessoa`(cpf varchar(12), dtnascto date, sexo char(1),  cidade varchar(70), bairro varchar(70), rua varchar(70), email varchar(70), numero int, telefone varchar(12), nome varchar(70), estado varchar(70))
begin
if (email like '%@%') then
insert into pessoa (pescpf,pesdtnascto,pessexo,pescidade,pesbairro,pesrua,pesemail,pesnumero,pestelefone,pesnome,pesestado)
values (cpf, dtnascto, sexo, cidade, bairro, rua, email, numero, telefone, nome, estado);
else
      select "E-mail inválido";
end if;
end$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_excluipessoa`(cod int)
begin

if (cod in (select pesid from pessoa)) then
	delete from pessoa
	where pesid = cod;
else
	select "Pessoa não existe";
end if;

end$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_alterapessoa`(cpf varchar(12), dtnascto date, sexo char(1), cidade varchar(70), bairro varchar(70), rua varchar(70), email varchar(70), numero int, telefone varchar(12), nome varchar(70), estado varchar(70), cod int)
begin
if (email like '%@%') then
	update pessoa 
	set pescpf=cpf,
	pesdtnascto=dtnascto,
	pessexo=sexo,
	pescidade=cidade,
	pesbairro=bairro,
	pesrua=rua,
	pesemail=email,
	pesnumero=numero,
	pestelefone=telefone,
	pesnome=nome,
	pesestado=estado
	where cod=pesid;
else
      select "E-mail inválido";
end if;
end$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `artemis`.`tg_exclui_pessoa`
BEFORE DELETE ON `artemis`.`pessoa`
FOR EACH ROW
begin

delete from venda
where venpessoa_pesid = old.pesid;

delete from solicita
where pessoa_pesid = old.pesid;

delete from pet
where pessoa_pesid = old.pesid;

delete from carrinho
where carpes = old.pesid;

delete from avaliacao
where pessoa_pesid = old.pesid;

end$$
DELIMITER ;

delimiter $$
create procedure sp_pessoa_endereco (pessoa int)
begin
if (pessoa in (select pesid from pessoa)) then

	select concat("Bairro :",pesbairro," ;Rua: ", pesrua, " ;Numero: ",pesnumero,". ",pescidade,"/",pesestado) as "Endereço" from pessoa
    where pesid = pessoa;
else
	select "Pessoa não existe";
end if;
end $$
delimiter ;

/* pet */

DELIMITER $$
CREATE PROCEDURE `sp_inserepet`(nome varchar(65), sexo char(1), castrado enum('castrado','não castrado','não sei'), dtnascto date, peso float, pessoa int, porte int, raca int, tipo int)
begin
if(pessoa in (select pesid from pessoa)or pessoa=0) then
	if(porte in (select ptpid from pet_porte)) then
		if (raca in (select ptrid from pet_raca)) then
			if (tipo in (select pttid from pet_tipo)) then
				insert into pet (petnome, petsexo, petcastrado, petdtnascto, petpeso, pessoa_pesid, pet_porte_ptpid, pet_raca_ptrid, pet_tipo_pttid)
				values (nome, sexo, castrado, dtnascto, peso, pessoa, porte, raca, tipo);
			else
				select "Tipo de pet não registrado";
			end if;
		else
			select "Tipo de reça não registrado";
		end if;
	else
		select "Porte não registrado";
	end if;
else
	select "Pessoa não existe";
end if;

end$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_excluipet`(cod int)
begin

if (cod in (select petid from pet)) then
	delete from pet
	where petid = cod;
else
	select "Pet não existe";
end if;

end$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_alterapet`(nome varchar(65), sexo char(1), castrado enum('castrado','não castrado','não sei'), dtnascto date, peso float, pessoa int, porte int, raca int, tipo int, cod int)
begin
if(pessoa in (select pesid from pessoa) or pessoa = 0) then
	if(porte in (select ptpid from pet_porte)) then
		if (raca in (select ptrid from pet_raca)) then
			if (tipo in (select pttid from pet_tipo)) then
				update pet 
                set petnome=nome,
                petsexo=sexo, 
                petcastrado= castrado, 
                petdtnascto=dtnascto, 
                petpeso=peso, 
                pessoa_pesid=pessoa,
                pet_porte_ptpid=porte, 
                pet_raca_ptrid=raca, 
                pet_tipo_pttid = tipo
                where cod= petid;
			else
				select "Tipo de pet não registrado";
			end if;
		else
			select "Tipo de reça não registrado";
		end if;
	else
		select "Porte não registrado";
	end if;
else
	select "Pessoa não existe";
end if;

end$$
DELIMITER ;


delimiter ##
CREATE TRIGGER `artemis`.`tg_exclui_pet`
BEFORE DELETE ON `artemis`.`pet`
FOR EACH ROW
begin

delete from pet_foto
where pet_petid = old.petid;

delete from pet_adocao
where pet_petid = old.petid;

delete from solicita
where solpetid = old.petid;

end$$
DELIMITER ;


/* produto */

DELIMITER $$
CREATE PROCEDURE `sp_insere_produto`(nome varchar(100), preco float, saldo int, petshop int, categoria int)
begin

	if (petshop in (select ptsid from petshop)) then
    if (categoria in (select ctpid from categoria_produto)) then
     insert into produto (pronome, propreco,prosaldo,propetshop_ptsid,categoria_produto_ctpid) values
     (nome,preco, saldo, petshop, categoria);
   else
      select "Categoria não existe";
    end if;  
    else
      select "Petshop não existe";
    end if;
end$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_exclui_produto`(cod int)
begin

if (cod in (select proid from produto)) then
	delete from produto
	where proid = cod;
else
	select "Produto não existe";
end if;

end$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_altera_produto`(nome varchar(100), preco float, saldo int, petshop int, categoria int , cod int)
begin
if (petshop in (select ptsid from petshop)) then
    if (categoria in (select ctpid from categoria_produto)) then
	update produto
	set pronome=nome,
    propreco = preco,
    prosaldo = saldo,
    propetshop_ptsid = petshop,
    categoria_produto_ctpid = categoria
	where cod=proid;
else
      select "Categoria não existe";
    end if;  
    else
      select "Petshop não existe";
    end if;
end$$
DELIMITER ;

DELIMITER $$
create procedure sp_produto_petshop (petshop int)
begin

if(petshop in (select ptsid from petshop)) then

	select * from produto
    where propetshop_ptsid= petshop;
    
else
select "Petshop não existe";
end if;
end $$
DELIMITER ;


delimiter $$
create procedure sp_altera_quantidade (produto int, quantidade int)
begin
if (produto in (select proid from produto)) then
	update produto
    set prosaldo = quantidade
    where proid = produto;
else
 select "Produto não cadastrado";
end if;

end$$
delimiter ;

delimiter $$
create procedure sp_altera_preco (produto int, preco float)
begin
if (produto in (select proid from produto)) then
	update produto
    set propreco = preco
    where proid = produto;
else
 select "Produto não cadastrado";
end if;
end$$
delimiter ;

delimiter $$
CREATE TRIGGER `artemis`.`tg_exclui_produto`
BEFORE DELETE ON `artemis`.`produto`
FOR EACH ROW
begin

delete from venda
where venpro = old.proid;

delete from carrinho
where carpro = old.proid;

delete from produto_foto
where produto_proid = old.proid;

end$$
DELIMITER ;

/*serviço*/

DELIMITER $$
CREATE PROCEDURE `sp_insere_servico`( preco float, petshop int, tipo int, descricao varchar(200))
begin

	if (tipo in (select tpsid from tiposervico )) then
				if (petshop in (select ptsid from petshop)) then
                
					insert into servico (servalor,petshop_ptsid,tiposervico_tpsid,serdescricao) values
					(preco, petshop, tipo, descricao);
				
				else
					select "Petshop não existe";
				end if;
	else 
			select "Tipo de serviço não cadastrado";
	end if;
end$$
DELIMITER ;

DELIMITER $$
CREATE  PROCEDURE `sp_exclui_servico`(cod int)
begin

if (cod in (select serid from servico)) then
	delete from servico
	where serid = cod;
else
	select "Serviço não existe";
end if;

end$$

DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_altera_servico`(preco float, petshop int, tipo int, descricao varchar (200), cod int)
begin
if (tipo in (select tpsid from tiposervico )) then
				if (petshop in (select ptsid from petshop)) then
	update servico
	set servalor=preco,
    petshop_ptsid = petshop,
    tiposervico_tpsid = tipo,
    serdescricao = descricao
	where cod=proid;
		else
					select "Petshop não existe";
				end if;
	else 
			select "Tipo de serviço não cadastrado";
	end if;
end$$
DELIMITER ;

DELIMITER $$
create procedure sp_servico_petshop (petshop int)
begin

if(petshop in (select ptsid from petshop)) then

	select * from servico
    where petshop_ptsid = petshop;
    
else
select "Petshop não existe";
end if;
end $$
delimiter ;

delimiter $$
CREATE TRIGGER `artemis`.`tg_exclui_servico`
BEFORE DELETE ON `artemis`.`servico`
FOR EACH ROW
begin

delete from venda
where venser=old.serid;

delete from servico_foto
where servico_serid = old.serid;

delete from carrinho
where carser = old.serid;

delete from solicita
where servico_serid = old.serid;
end$$
delimiter ;

delimiter $$
create procedure sp_cidade_tpservico (tipo_servico int, cidade varchar(100))
begin

select tpsnome, tiposervico_tpsid, serdescricao, ptscidade from servico
inner join tiposervico on tiposervico_tpsid = tpsid
inner join petshop on ptsid = petshop_ptsid
where cidade = ptscidade and tipo_servico =tiposervico_tpsid;

end $$
delimiter ;

/* solicita */

DELIMITER $$
CREATE procedure sp_insere_solicita (pessoa int, servico int, agendamento datetime, pet int)
begin
	if(pessoa in (select pesid from pessoa)) then
		if(servico in (select serid from servico )) then
			if(pet in (select petid from pet)) then
				
                insert into solicita (pessoa_pesid,servico_serid,soldthr,solpetid, solstatus) values
                (pessoa, servico, agendamento, pet, "Requerido");
                
			else
				select "Pessoa não existe";
			end if;
		else
			select "Serviço não cadastrado";
		end if;
	else
		select "Pet não cadastrado";
	end if;
 end$$
DELIMITER ;

DELIMITER $$
CREATE procedure sp_exclui_solicita (cod int)
begin
	if (cod in (select solid from solicita)) then
    
		delete from solicita
        where solid = cod;
	else
		select "Solicitação não realizada";
	end if;
 end$$
DELIMITER ;

DELIMITER $$
CREATE procedure sp_altera_solicita (pessoa int, servico int, agendamento datetime, pet int, cod int)
begin
	if(pessoa in (select pesid from pessoa)) then
		if(servico in (select serid from servico )) then
			if(pet in (select petid from pet)) then
				
					update solicita
					set 
					pessoa_pesid = pessoa,
                    servico_serid = servico,
                    soldthr = agendamento,
                    solpetid = pet
					where cod=solid;
			else
				select "Pessoa não existe";
			end if;
		else
			select "Serviço não cadastrado";
		end if;
	else
		select "Pet não cadastrado";
	end if;
 end$$
DELIMITER ;

delimiter $$
create procedure sp_altera_status_solicita (cod int, novo varchar(15))
begin
if (cod in (select solid from solicita)) then
 if (upper(novo)in ("CANCELADO","CONCLUÍDO")) then
	update solicita
    set solstatus = novo
    where solid = cod;
 else
	select "Opção inválida";
 end if;
 else
	select "Solicitação inexistente";
 end if;
end$$
delimiter ;

DELIMITER $$

CREATE PROCEDURE sp_verifica_solicitacao(fpg int, solicita int)
BEGIN
    DECLARE v_pessoa_id INT;
    DECLARE v_servico_id INT;
    DECLARE v_solid INT;
    DECLARE v_soldthr DATETIME;
    DECLARE v_solpetid INT;
    DECLARE v_solstatus ENUM('Requerido', 'Cancelado', 'Concluído');
    DECLARE v_done BOOLEAN DEFAULT FALSE;
    declare v_valor float;

    DECLARE cur_solicita CURSOR FOR 
        SELECT pessoa_pesid, servico_serid, solid, soldthr, solpetid, solstatus
        FROM solicita;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = TRUE;

    OPEN cur_solicita;

    WHILE NOT v_done DO
        FETCH cur_solicita INTO v_pessoa_id, v_servico_id, v_solid, v_soldthr, v_solpetid, v_solstatus;
        
        IF NOT v_done THEN

            IF (v_solstatus = 'Concluído') and (v_solid = solicita) THEN
            set v_valor = (select servalor from servico
            where serid = v_servico_id);
                
                insert into venda (venser,venformapagamento_fpgid, venpessoa_pesid, venvalor, venqtd)
                values (v_servico_id, fpg, v_pessoa_id, v_valor, 1);
                
                delete from solicita
                where solid = solicita;
                
            END IF;
        END IF;

    END WHILE;

    CLOSE cur_solicita;
END$$
DELIMITER ;
/* carrinho */

delimiter $$
create procedure sp_total_carrinho (pessoa int)
begin

if(pessoa in (select pesid from pessoa)) then
	select sum(carpreco) as "Valor total" from carrinho
	where carpes = pessoa;
else
 select "Pessoa não existe";
end if;
end ##
delimiter ;

delimiter ##
create procedure sp_insere_servico_carrinho (servico int, pessoa int, quantidade int)
begin
declare v_preco float default 0;

if(servico in (select serid from servico)) then
	if(pessoa in (select pesid from pessoa)) then
		
        set v_preco = (select servalor from servico
        where serid = servico) * quantidade;
        
        insert into carrinho (carser,carpes,carquant,carpreco) values
        (servico, pessoa, quantidade, v_preco);
        
    else
		select "Pessoa não existe";
    end if;
else
	select "Servico não existe";
end if;
end ##
delimiter ;

delimiter ##
create procedure sp_insere_produto_carrinho (produto int, pessoa int, quantidade int)
begin
declare v_preco float default 0;

if(produto in (select proid from produto)) then
	if (quantidade <= (select prosaldo from produto where proid=produto)) then
	if(pessoa in (select pesid from pessoa)) then
		
        set v_preco = (select propreco from produto
        where proid = produto) * quantidade;
        
        insert into carrinho (carpro,carpes,carquant,carpreco) values
        (produto, pessoa, quantidade, v_preco);
        
        update produto
        set prosaldo = (prosaldo - quantidade)
        where proid = produto;
        
    else
		select "Pessoa não existe";
    end if;
     else
		select "Quantidade inválida";
    end if;
else
	select "Produto não existe";
end if;

end ##
delimiter ;

delimiter ##
create procedure sp_exclui_obj_carrinho (carrinho int)
begin
if (carrinho in (select carid from carrinho)) then

delete from carrinho
where carid=carrinho;
else
select "Carrinho não existe";
end if;
end ##
delimiter ;

DELIMITER $$
CREATE PROCEDURE sp_finaliza_compra (pessoa_id INT, fpg int)
BEGIN

 DECLARE v_carrinho_id INT;
    DECLARE v_produto_id INT;
    DECLARE v_servico_id INT;
    DECLARE v_quantidade INT;
    DECLARE v_preco FLOAT;
    DECLARE v_total FLOAT;
    DECLARE v_done BOOLEAN DEFAULT FALSE;
    
     DECLARE cur_carrinho CURSOR FOR 
        SELECT carid
        FROM carrinho
        WHERE carpes = pessoa_id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = TRUE;


if(pessoa_id in (select pesid from pessoa)) then
	if(fpg in (select fpgid from formapagamento)) then

    OPEN cur_carrinho;

        WHILE NOT v_done DO
        FETCH cur_carrinho INTO v_carrinho_id;
        IF NOT v_done THEN
        
		SET v_total = v_quantidade * v_preco;

            INSERT INTO venda (venpro, venformapagamento_fpgid, venpessoa_pesid, venvalor,venqtd)
            SELECT  carpro, fpg, pessoa_id, carpreco, carquant
            FROM carrinho
            WHERE carid = v_carrinho_id;

            DELETE FROM carrinho
            WHERE carid = v_carrinho_id;
        END IF;
    END WHILE;
    CLOSE cur_carrinho;
    
	else
		select "forma de pagamento não cadastrada";
	end if;
else
	select "Pessoa não cadastrada";
end if;
END$$
DELIMITER ;

/* vendas */

delimiter $$
create procedure sp_venda_produto_pessoa (produto int, pessoa int)
begin
if (pessoa in (select pesid from pessoa)) then
	if (produto in (select proid from produto)) then
		if (produto in (select venpro from venda)) then
		
        select venid, pronome, ctpnome, ptsnome, pesnome from venda
        inner join produto on venpro = proid
        inner join categoria_produto on categoria_produto_ctpid = ctpid
        inner join petshop on propetshop_ptsid = ptsid
        inner join pessoa on venpessoa_pesid = pesid
        where ((venpro = produto) and (venpessoa_pesid = pessoa));
        
		else
			select "Produto não vendido";
		end if;
	else
		select "Produto não cadastrado";
    end if;
else
		select "Pessoa não cadastrada";
end if;

end$$
delimiter ;

delimiter $$
create procedure sp_venda_produto_petshop (produto int, petshop int)
begin
if (petshop in (select ptsid from petshop)) then
	if (produto in (select proid from produto)) then
		if (produto in (select venpro from venda)) then
		
        select venid, pronome, ctpnome, ptsnome, pesnome from venda
        inner join produto on venpro = proid
        inner join categoria_produto on categoria_produto_ctpid = ctpid
        inner join petshop on propetshop_ptsid = ptsid
        inner join pessoa on venpessoa_pesid = pesid
        where (venpro = produto and propetshop_ptsid = petshop);
        
		else
			select "Produto não vendido";
		end if;
	else
		select "Produto não cadastrado";
    end if;
else
		select "Petshop não cadastrado";
end if;

end$$
delimiter ;


delimiter $$
create procedure sp_venda_servico_pessoa (servico int, pessoa int)
begin
if (pessoa in (select pesid from pessoa)) then
	if (servico in (select serid from serid)) then
		if (servico in (select venser from venda)) then
		
        select venid, tpsnome, serdescricao, ptsnome, pesnome from venda
        inner join servico on venser = serid
        inner join tiposervico on venda.tiposervico_tpsid = tpsid
        inner join petshop on venda.petshop_ptsid = ptsid
        inner join pessoa on venpessoa_pesid = pesid
        where (venser = servico and  venpessoa_pesid= pessoa);
        
		else
			select "Serviço não vendido";
		end if;
	else
		select "Serviço não cadastrado";
    end if;
else
		select "Pessoa não cadastrada";
end if;

end$$
delimiter ;


delimiter $$
create procedure sp_venda_servico_petshop (servico int, petshop int)
begin
if (petshop in (select ptsid from petshop)) then
	if (servico in (select serid from serid)) then
		if (servico in (select venser from venda)) then
		
        select venid, tpsnome, serdescricao, ptsnome, pesnome from venda
        inner join servico on venser = serid
        inner join tiposervico on venda.tiposervico_tpsid = tpsid
        inner join petshop on venda.petshop_ptsid = ptsid
        inner join pessoa on venpessoa_pesid = pesid
        where (venser= servico and servico.petshop_ptsid = petshop);
        
		else
			select "Serviço não vendido";
		end if;
	else
		select "Serviço não cadastrado";
    end if;
else
		select "Petshop não cadastrado";
end if;

end$$
delimiter ;

/* adoção */
delimiter $$
create procedure sp_insere_pet_adocao (ong int, pet int)
begin
if (ong in (select ongid from ong)) then
	if (pet in (select petid from pet) and (pet not in(select pet_petid from pet_petid))) then
		
        insert into pet_adocao (ong_ongid,pet_petid) values
        (ong, pet);
    else
		select "Pet inválido";
    end if;
else
	select "Ong inválida";
end if;

end $$
delimiter ;

delimiter $$
create procedure sp_inicia_adocao (pessoa int, adocao int)
begin
if (pessoa in (select pesid from pessoa)) then
	if(adocao in (select adoid from pet_adocao)) then
		insert into tentativa_adota (ttapes, tta_petadocao,ttastatus) values
        (pessoa, adocao, "Requisitado");
    else 
		select "Cadastro de adoção não realizado";
    end if;
else
	select "Pessoa não existe";
end if;
end $$
delimiter ;

delimiter $$
create procedure sp_altera_status_adocao (cod int, novo varchar(15))
begin
if (cod in (select ttaid from tentativa_adota)) then
	if(upper(novo) in ("REQUISITADO","ACEITO","NEGADO","ADOTADO","NÃO ADOTADO")) then
		update tentativa_adota
        set ttastatus = novo,
        ttadthora = current_timestamp()
        where cod = ttaid;
    else
		select "Valor inválido";
    end if;
else
	select "Tentativa de adoção não realizada";
end if;
end $$
delimiter ;

delimiter $$
create trigger tg_tira_pet_adocao
after update on tentativa_adota
for each row
begin

if (new.ttastatus = "Adotado") then
	update pet_adocao
	set adostatus = "Adotado"
	where adoid = new.tta_petadocao;
end if;
end $$
delimiter ;

/* inserts subclasses*/

select * from formapagamento;
select * from tiposervico;
select * from categoria_produto;
select * from pet_raca;
select * from pet_tipo;
select * from pet_porte;

INSERT INTO `artemis`.`formapagamento` ( `fpgdescricao`) VALUES ('pix - transferência online');
INSERT INTO `artemis`.`formapagamento` (`fpgdescricao`) VALUES ('espécie');
INSERT INTO `artemis`.`formapagamento` (`fpgdescricao`) VALUES ('Débito - Cartão');
INSERT INTO `artemis`.`formapagamento` (`fpgdescricao`) VALUES ('Crédito - Cartão');

INSERT INTO `artemis`.`tiposervico` (`tpsnome`, `tpsdescricao`) VALUES ('tosa', 'tosa o bicho');
INSERT INTO `artemis`.`tiposervico` (`tpsnome`, `tpsdescricao`) VALUES ('banho', 'dá banho');
INSERT INTO `artemis`.`tiposervico` (`tpsnome`, `tpsdescricao`) VALUES ('passear', 'bora ver o mundo');


INSERT INTO `artemis`.`categoria_produto` (`ctpnome`, `ctpdescricao`) VALUES ('Categoria Geral', 'Pode ser usado por diversos pets');
INSERT INTO `artemis`.`categoria_produto` (`ctpnome`, `ctpdescricao`) VALUES ('Para Cães', 'Usados por cães');
INSERT INTO `artemis`.`categoria_produto` (`ctpnome`, `ctpdescricao`) VALUES ('Para Gatos', 'Usados por gatos');

INSERT INTO `artemis`.`pet_tipo` (`pttnome`, pttid) VALUES ('Cão',1);
INSERT INTO `artemis`.`pet_tipo` (`pttnome`, pttid) VALUES ('Gato', 2);
INSERT INTO `artemis`.`pet_tipo` (`pttnome`, pttid) VALUES ('Coelho',3);
INSERT INTO `artemis`.`pet_tipo` (`pttnome`, pttid) VALUES ('Papagaio', 4);

INSERT INTO `artemis`.`pet_porte` (`ptpnome`, `ptpdescricao`) VALUES ('Grande', 'masseta');
INSERT INTO `artemis`.`pet_porte` (`ptpnome`, `ptpdescricao`) VALUES ('Médio', 'normal');
INSERT INTO `artemis`.`pet_porte` (`ptpnome`, `ptpdescricao`) VALUES ('Pequeno', 'nanico');

INSERT INTO `artemis`.`pet_raca` (`ptrnome`, `pet_tipo_pttid`) VALUES ('vira-lata', '1');
INSERT INTO `artemis`.`pet_raca` (`ptrnome`, `pet_tipo_pttid`) VALUES ('vira-lata', '2');
INSERT INTO `artemis`.`pet_raca` (`ptrnome`, `pet_tipo_pttid`) VALUES ('buldog', '1');
INSERT INTO `artemis`.`pet_raca` (`ptrnome`, `pet_tipo_pttid`) VALUES ('persa', '1');
INSERT INTO `artemis`.`pet_raca` (`ptrnome`, `pet_tipo_pttid`) VALUES ('Pastor Alemão', '1');
INSERT INTO `artemis`.`pet_raca` (`ptrnome`, `pet_tipo_pttid`) VALUES ('Rex', '6');
INSERT INTO `artemis`.`pet_raca` (`ptrnome`, `pet_tipo_pttid`) VALUES ('Siamês', '2');


select carpes, sum(carpreco) as "Valor total" from carrinho
group by carpes;

select * from servico;
select * from petshop;
select * from pessoa;
select * from produto;
select * from carrinho;
select * from venda;
select * from solicita;
select * from ong;
select * from tentativa_adota;

create view visualiza_forma_pagamento as
select distinct(fpgdescricao) as "Formas de pagamento" from formapagamento
group by fpgid, fpgdescricao;

select * from visualiza_forma_pagamento;
show create table solicita;

-- DASHBOARDS --
-- VENDA
 delimiter $$
 create procedure sp_venda_ano (ano year, petshop int)
 begin
if (petshop in (select ptsid from petshop)) then
	
    select pronome as "Produto", pesnome as "Cliente", venqtd as  "Quantidade", venvalor as "Total", vendthora "Data e hora" from venda
	inner join pessoa on pesid = venda.venpessoa_pesid
	inner join produto on proid=venpro
    where (petshop = propetshop_ptsid) and (year(vendthora)= ano);
    
else
	select "Petshop não existe";
end if;
 
end $$
delimiter ;

 delimiter $$
 create procedure sp_venda_mes (mes int, ano year, petshop int)
 begin
if (petshop in (select ptsid from petshop)) then
	if (mes between 1 and 12) then
    
    select pronome as "Produto", pesnome as "Cliente", venqtd as  "Quantidade", venvalor as "Total", vendthora "Data e hora" from venda
	inner join pessoa on pesid = venda.venpessoa_pesid
	inner join produto on proid=venpro
    where (petshop = propropetshop_ptsid) and ( (year(vendthora)= ano) and (month(vendthora)= mes));
    
    else
		select "Mês inválido";
	end if;
else
	select "Petshop não existe";
end if;
 
end $$
delimiter ;

 delimiter $$
 create procedure sp_venda_produtos (petshop int)
 begin
if (petshop in (select ptsid from petshop)) then
    
	select pronome as "Produto", sum(venqtd) as "Quantidade vendida", sum(venvalor) as "Valor arrecadado" from venda
	inner join produto on proid = venpro
    where propetshop_ptsid = petshop
	group by proid
	order by sum(venqtd) desc;
    
else
	select "Petshop não existe";
end if;
 
end $$
delimiter ;


 delimiter $$
 create procedure sp_produtos_avaliacao (petshop int)
 begin
if (petshop in (select ptsid from petshop)) then
    
	select pronome as "Produto", avg(avavalor) as "Média das avaliações" from avaliacao
	inner join produto on proid = avaliacao.produto_proid
    where petshop = propetshop_ptsid
	group by proid
	order by avg(avavalor) desc;
    
else
	select "Petshop não existe";
end if;
end $$
delimiter ;

 delimiter $$
 create procedure sp_servicos_petshop (petshop int, estado varchar(15))
 begin
if (petshop in (select ptsid from petshop)) then
    if (upper(estado) in ("REQUERIDO","CANCELADO","CONCLUÍDO")) then
		select serdescricao as "Serviço", tpsnome "Tipo de serviço", count(servico_serid) as "Quantidade", solstatus as "Status" from solicita
		inner join servico on serid = solicita.servico_serid
		inner join tiposervico on tpsid =servico.tiposervico_tpsid
        where petshop = servico.petshop_ptsid and estado = solstatus
		group by solid, servico_serid
		order by count(servico_serid) desc;
        
    elseif (estado is null) then
		select serdescricao as "Serviço", tpsnome "Tipo de serviço", count(servico_serid) as "Quantidade", solstatus as "Status" from solicita
		inner join servico on serid = solicita.servico_serid
		inner join tiposervico on tpsid =servico.tiposervico_tpsid
        where petshop = servico.petshop_ptsid
		group by solid, servico_serid
		order by count(servico_serid) desc;
    else
		select "Status inválido";
	end if;
else
	select "Petshop não existe";
end if;
end $$
delimiter ;

-- ADOÇÃO

 delimiter $$
 create procedure sp_adocao_estado (ong int, estado varchar(15))
 begin
if (ong in (select ongid from ong)) then
   if (estado in ('Requisitado','Aceito','Negado','Adotado','Não Adotado')) then
		
        select petnome as "Pet", pttnome as "Tipo", ptrnome as "Raça", ttastatus as  "status", ttadthora as "Data e hora" from tentativa_adota
		inner join pet_adocao on adoid = tta_petadocao
		inner join pet on petid = pet_adocao.pet_petid
		inner join pet_tipo on pet_tipo_pttid = pttid
		inner join pet_raca on pet_raca_ptrid = ptrid
        where pet_adocao.ong_ongid = ong and estado=ttastatus;
        
	else
		select "Status inválido";
    end if;
else
	select "Ong não existe";
end if;
end $$
delimiter ;


 delimiter $$
 create procedure sp_adocao_data (ong int, mes int, ano year)
 begin
if (ong in (select ongid from ong)) then
   if(mes between 1 and 12) then
   
		select petnome as "Pet", pttnome as "Tipo", ptrnome as "Raça", ttastatus as  "status", ttadthora as "Data e hora" from tentativa_adota
		inner join pet_adocao on adoid = tta_petadocao
		inner join pet on petid = pet_adocao.pet_petid
		inner join pet_tipo on pet_tipo_pttid = pttid
		inner join pet_raca on pet_raca_ptrid = ptrid
        where pet_adocao.ong_ongid = ong and ( (year(ttadthora)= ano) and (month(ttadthora)= mes));
   
   else
	select "Mês inválido";
   end if;
else
	select "Ong não existe";
end if;
end $$
delimiter ;


 delimiter $$
 create procedure sp_adocao_bicho (ong int, tipo varchar (20))
 begin
if (ong in (select ongid from ong)) then
   if (tipo in (select pttnome from pet_tipo)) then
		
        select petnome as "Pet", pttnome as "Tipo", ptrnome as "Raça", ttastatus as  "status", ttadthora as "Data e hora" from tentativa_adota
		inner join pet_adocao on adoid = tta_petadocao
		inner join pet on petid = pet_adocao.pet_petid
		inner join pet_tipo on pet_tipo_pttid = pttid
		inner join pet_raca on pet_raca_ptrid = ptrid
        where pet_adocao.ong_ongid = ong and pttnome = tipo;
        
   else
		select "Tipo não existe";
	end if;
else
	select "Ong não existe";
end if;
end $$
delimiter ;

-- Pessoa

delimiter $$
create procedure sp_gastos_produto_data (pessoa int, mes int, ano year)
begin
if (pessoa in(select pesid from pessoa)) then
   if (mes between 1 and 12) then
   
		select pesnome as "Pessoa", pronome as "Produto", venqtd as "Quantidade", propreco as "Preço", venvalor as "Valor", vendthora as "Data e hora" from venda
		inner join produto on proid = venpro
		inner join pessoa on pesid = venpessoa_pesid
        where ((mes = month(vendthora) and ano = year(vendthora)) and (pessoa = venpessoa_pesid));

	else
		select "Mês inválido";
	end if;
else
	select "Pessoa não existe";
end if;
end $$
delimiter ;



delimiter $$
create procedure sp_gastos_servico_data (pessoa int, mes int, ano year)
begin
if (pessoa in(select pesid from pessoa)) then
   if (mes between 1 and 12) then

	select tpsnome as "Tipo", serdescricao as "Descrição", servalor as "Preço", soldthr as "Data e hora" from solicita
	inner join servico on serid = solicita.servico_serid
	inner join tiposervico on tpsid = tiposervico_tpsid
    where (pessoa = solicita.pessoa_pesid) and (solstatus in("Concluído")) and ((mes = month(soldthr)) and (ano = year(soldthr)));

	else
		select "Mês inválido";
	end if;
else
	select "Pessoa não existe";
end if;
end $$
delimiter ;
