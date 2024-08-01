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
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `artemis`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`produto` (
  `proid` INT NOT NULL AUTO_INCREMENT,
  `pronome` VARCHAR(65) NOT NULL,
  `propreco` DOUBLE(6,2) NOT NULL,
  `prosaldo` INT NULL DEFAULT NULL,
  `propetshop_ptsid` INT NOT NULL,
  `prodtvalidade` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`proid`),
  INDEX `fk_produto_petshop1_idx` (`propetshop_ptsid` ASC) VISIBLE,
  CONSTRAINT `fk_produto_petshop1`
    FOREIGN KEY (`propetshop_ptsid`)
    REFERENCES `artemis`.`petshop` (`ptsid`))
ENGINE = InnoDB
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
  `pttid` INT NOT NULL AUTO_INCREMENT,
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
  `ptrid` INT NOT NULL AUTO_INCREMENT,
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
-- Table `artemis`.`servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`servico` (
  `serid` INT NOT NULL AUTO_INCREMENT,
  `servalor` FLOAT NOT NULL,
  `pet_petid` INT NOT NULL,
  `petshop_ptsid` INT NOT NULL,
  `tiposervico_tpsid` INT NOT NULL,
  `serdescricao` VARCHAR(200) NULL,
  PRIMARY KEY (`serid`),
  INDEX `fk_tosa_pet1_idx` (`pet_petid` ASC) VISIBLE,
  INDEX `fk_tosa_petshop1_idx` (`petshop_ptsid` ASC) VISIBLE,
  INDEX `fk_servico_tiposervico1_idx` (`tiposervico_tpsid` ASC) VISIBLE,
  CONSTRAINT `fk_servico_tiposervico1`
    FOREIGN KEY (`tiposervico_tpsid`)
    REFERENCES `artemis`.`tiposervico` (`tpsid`),
  CONSTRAINT `fk_tosa_pet1`
    FOREIGN KEY (`pet_petid`)
    REFERENCES `artemis`.`pet` (`petid`),
  CONSTRAINT `fk_tosa_petshop1`
    FOREIGN KEY (`petshop_ptsid`)
    REFERENCES `artemis`.`petshop` (`ptsid`))
ENGINE = InnoDB
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
-- Table `artemis`.`formapagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`formapagamento` (
  `fpgid` INT NOT NULL AUTO_INCREMENT,
  `fpgdescricao` VARCHAR(65) NULL DEFAULT NULL,
  PRIMARY KEY (`fpgid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `artemis`.`venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`venda` (
  `venid` INT NOT NULL AUTO_INCREMENT,
  `venformapagamento_fpgid` INT NOT NULL,
  `venpessoa_pesid` INT NOT NULL,
  `venpetshop_ptsid` INT NOT NULL,
  `venvalor` FLOAT NOT NULL,
  PRIMARY KEY (`venid`),
  INDEX `fk_venda_formapagamento1_idx` (`venformapagamento_fpgid` ASC) VISIBLE,
  INDEX `fk_venda_pessoa1_idx` (`venpessoa_pesid` ASC) VISIBLE,
  INDEX `fk_venda_petshop1_idx` (`venpetshop_ptsid` ASC) VISIBLE,
  CONSTRAINT `fk_venda_formapagamento1`
    FOREIGN KEY (`venformapagamento_fpgid`)
    REFERENCES `artemis`.`formapagamento` (`fpgid`),
  CONSTRAINT `fk_venda_pessoa1`
    FOREIGN KEY (`venpessoa_pesid`)
    REFERENCES `artemis`.`pessoa` (`pesid`),
  CONSTRAINT `fk_venda_petshop1`
    FOREIGN KEY (`venpetshop_ptsid`)
    REFERENCES `artemis`.`petshop` (`ptsid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `artemis`.`itemvenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`itemvenda` (
  `produto_proid` INT NULL DEFAULT NULL,
  `itemvenda_venid` INT NOT NULL,
  `itvqtde` INT NOT NULL,
  `servico_serid` INT NULL DEFAULT NULL,
  PRIMARY KEY (`itemvenda_venid`),
  INDEX `fk_produto_has_venda_venda1_idx` (`itemvenda_venid` ASC) VISIBLE,
  INDEX `fk_produto_has_venda_produto1_idx` (`produto_proid` ASC) VISIBLE,
  INDEX `fk_itemvenda_servico1_idx` (`servico_serid` ASC) VISIBLE,
  CONSTRAINT `fk_itemvenda_servico1`
    FOREIGN KEY (`servico_serid`)
    REFERENCES `artemis`.`servico` (`serid`),
  CONSTRAINT `fk_produto_has_venda_produto1`
    FOREIGN KEY (`produto_proid`)
    REFERENCES `artemis`.`produto` (`proid`),
  CONSTRAINT `fk_produto_has_venda_venda1`
    FOREIGN KEY (`itemvenda_venid`)
    REFERENCES `artemis`.`venda` (`venid`))
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
-- Table `artemis`.`login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`login` (
  `logemail` VARCHAR(70) NOT NULL,
  `logsenha` VARCHAR(45) NULL DEFAULT NULL,
  `petshop_ptsid` INT NULL DEFAULT NULL,
  `pessoa_pesid` INT NULL DEFAULT NULL,
  `ong_ongid` INT NULL DEFAULT NULL,
  PRIMARY KEY (`logemail`),
  INDEX `fk_login_petshop1_idx` (`petshop_ptsid` ASC) VISIBLE,
  INDEX `fk_login_pessoa1_idx` (`pessoa_pesid` ASC) VISIBLE,
  INDEX `fk_login_ong1_idx` (`ong_ongid` ASC) VISIBLE,
  CONSTRAINT `fk_login_ong1`
    FOREIGN KEY (`ong_ongid`)
    REFERENCES `artemis`.`ong` (`ongid`),
  CONSTRAINT `fk_login_pessoa1`
    FOREIGN KEY (`pessoa_pesid`)
    REFERENCES `artemis`.`pessoa` (`pesid`),
  CONSTRAINT `fk_login_petshop1`
    FOREIGN KEY (`petshop_ptsid`)
    REFERENCES `artemis`.`petshop` (`ptsid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `artemis`.`notafiscal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`notafiscal` (
  `petshop_ptsid` INT NOT NULL,
  `venda_venid` INT NOT NULL,
  `ntfcod` INT NOT NULL,
  INDEX `fk_notaFiscal_petshop_idx` (`petshop_ptsid` ASC) VISIBLE,
  INDEX `fk_notaFiscal_venda1_idx` (`venda_venid` ASC) VISIBLE,
  CONSTRAINT `fk_notaFiscal_petshop`
    FOREIGN KEY (`petshop_ptsid`)
    REFERENCES `artemis`.`petshop` (`ptsid`),
  CONSTRAINT `fk_notaFiscal_venda1`
    FOREIGN KEY (`venda_venid`)
    REFERENCES `artemis`.`venda` (`venid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `artemis`.`pet_adocao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`pet_adocao` (
  `ong_ongid` INT NOT NULL,
  `pet_petid` INT NOT NULL,
  `adoid` INT NOT NULL AUTO_INCREMENT,
  INDEX `fk_pet_adocao_ong1_idx` (`ong_ongid` ASC) VISIBLE,
  PRIMARY KEY (`adoid`),
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
  INDEX `fk_pessoa_has_servico_servico1_idx` (`servico_serid` ASC) VISIBLE,
  INDEX `fk_pessoa_has_servico_pessoa1_idx` (`pessoa_pesid` ASC) VISIBLE,
  PRIMARY KEY (`solid`),
  CONSTRAINT `fk_pessoa_has_servico_pessoa1`
    FOREIGN KEY (`pessoa_pesid`)
    REFERENCES `artemis`.`pessoa` (`pesid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_has_servico_servico1`
    FOREIGN KEY (`servico_serid`)
    REFERENCES `artemis`.`servico` (`serid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `artemis`.`servico_foto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artemis`.`servico_foto` (
  `serftid` INT NOT NULL AUTO_INCREMENT,
  `serftvalor` VARCHAR(100) NOT NULL,
  `servico_serid` INT NOT NULL,
  PRIMARY KEY (`serftid`),
  INDEX `fk_servico_foto_servico1_idx` (`servico_serid` ASC) VISIBLE,
  CONSTRAINT `fk_servico_foto_servico1`
    FOREIGN KEY (`servico_serid`)
    REFERENCES `artemis`.`servico` (`serid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `artemis` ;

-- -----------------------------------------------------
-- procedure sp_alteraong
-- -----------------------------------------------------

DELIMITER $$
USE `artemis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_alteraong`(nome varchar(70), estado varchar(45), cidade varchar(70), bairro varchar(70), rua varchar(70), email varchar(70), numero int, telefone varchar(12), cod int)
begin

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

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_alterapessoa
-- -----------------------------------------------------

DELIMITER $$
USE `artemis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_alterapessoa`(cpf varchar(12), dtnascto date, sexo char(1), cidade varchar(70), bairro varchar(70), rua varchar(70), email varchar(70), numero int, telefone varchar(12), nome varchar(70), estado varchar(70), cod int)
begin

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

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_alterapet
-- -----------------------------------------------------

DELIMITER $$
USE `artemis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_alterapet`(nome varchar(65), sexo char(1), castrado enum('castrado','não castrado','não sei'), dtnascto date, peso float, pessoa int, porte int, raca int, tipo int, cod int)
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

-- -----------------------------------------------------
-- procedure sp_alterapetshop
-- -----------------------------------------------------

DELIMITER $$
USE `artemis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_alterapetshop`(nome varchar(70), cnpj varchar(20), estado varchar(45), cidade varchar(70), bairro varchar(70), rua varchar(70), email varchar(70), numero int, telefone varchar(12), cod int)
begin

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

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_alteraproduto
-- -----------------------------------------------------

DELIMITER $$
USE `artemis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_alteraproduto`(nome varchar(100), preco float, saldo int, petshop int, validade date, cod int)
begin

	update produto
	set ptsnome=nome,
    propreco = preco,
    prosaldo = saldo,
    propetshop_ptsid = petshop,
    prodtvalidade = validade
	where cod=proid;

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_alteraservico
-- -----------------------------------------------------

DELIMITER $$
USE `artemis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_alteraservico`(preco float,  agendado datetime, pet int, pessoa int, petshop int, tipo int, cod int)
begin

	update servico
	set servalor=preco,
    tosdatahora = agendado,
    pet_petid = pet,
    pessoa_pesid = pessoa,
    petshop_ptsid = petshop,
    tiposervico_tpsid = tipo
	where cod=proid;

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_exclui_petshop
-- -----------------------------------------------------

DELIMITER $$
USE `artemis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_exclui_petshop`(cod int)
begin

if (cod in (select ptsid from petshop)) then
	delete from petshop
	where ptsid = cod;
else
	select "Pethop não existe";
end if;

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_exclui_produto
-- -----------------------------------------------------

DELIMITER $$
USE `artemis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_exclui_produto`(cod int)
begin

if (cod in (select proid from produto)) then
	delete from produto
	where proid = cod;
else
	select "Produto não existe";
end if;

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_exclui_servico
-- -----------------------------------------------------

DELIMITER $$
USE `artemis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_exclui_servico`(cod int)
begin

if (cod in (select serid from servico)) then
	delete from servico
	where serid = cod;
else
	select "Serviço não existe";
end if;

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_excluiong
-- -----------------------------------------------------

DELIMITER $$
USE `artemis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_excluiong`(cod int)
begin

if (cod in (select ongid from ong)) then
	delete from ong
	where ongid = cod;
else
	select "Ong não existe";
end if;

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_excluipessoa
-- -----------------------------------------------------

DELIMITER $$
USE `artemis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_excluipessoa`(cod int)
begin

if (cod in (select pesid from pessoa)) then
	delete from pessoa
	where pesid = cod;
else
	select "Pessoa não existe";
end if;

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_excluipet
-- -----------------------------------------------------

DELIMITER $$
USE `artemis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_excluipet`(cod int)
begin

if (cod in (select petid from pet)) then
	delete from pet
	where petid = cod;
else
	select "Pet não existe";
end if;

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_insere_ong
-- -----------------------------------------------------

DELIMITER $$
USE `artemis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insere_ong`(nome varchar(100), estado varchar(45), cidade varchar(100), bairro varchar(100), rua varchar(100), num int, telefone varchar(100), email varchar(100))
begin
	if (email like '%@%') then
     insert into ong (ongnome,ongestado, ongcidade,ongbairro,ongrua,ongnum,ongtelefone,ongemail) values
     (nome, estado, cidade, bairro, rua, num, telefone, email);
    else
      select "E-mail inválido";
    end if;
    
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_insere_petshop
-- -----------------------------------------------------

DELIMITER $$
USE `artemis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insere_petshop`(nome varchar(100), cnpj varchar (14),estado varchar(45),cidade varchar(100), bairro varchar(100), rua varchar(100), num int, telefone varchar(100), email varchar(100))
begin
	if (email like '%@%') then
     insert into petshop (ptsnome,ptscnpj,ptsestado,ptscidade,ptsbairro,ptsrua,ptsnumero,ptstelefone,ptsemail) values
     (nome,cnpj, estado, cidade, bairro, rua, num, telefone, email);
    else
      select "E-mail inválido";
    end if;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_insere_produto
-- -----------------------------------------------------

DELIMITER $$
USE `artemis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insere_produto`(nome varchar(100), preco float, saldo int, petshop int, validade date)
begin

	if (petshop in (select ptsid from petshop)) then
    
     insert into produto (pronome, propreco,prosaldo,propetshop_ptsid,prodtvalidade) values
     (nome,preco, saldo, petshop, validade);
     
    else
      select "Petshop não existe";
    end if;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_insere_servico
-- -----------------------------------------------------

DELIMITER $$
USE `artemis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insere_servico`( preco float,  agendado datetime, pet int, pessoa int, petshop int, tipo int)
begin

	if (tipo in (select tpsid from tiposervico )) then
		if (pet in (select spetid from pet)) then
			if (pessoa in (select pesid from pessoa)) then
				if (petshop in (select ptsid from petshop)) then
    
					insert into servico (servalor,tosdatahora,pet_petid,pessoa_pesid,petshop_ptsid,tiposervico_tpsid) values
					(preco, agendado, pet, pessoa, petshop, tipo);
				else
					select "Petshop não existe";
				end if;
			else 
				select "Pessoa não existe";
			end if;
		else 
			select "Pet não existe";
		end if;
	else 
			select "Tipo de serviço não cadastrado";
		end if;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_inserepessoa
-- -----------------------------------------------------

DELIMITER $$
USE `artemis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserepessoa`(cpf varchar(12), dtnascto date, sexo char(1),  cidade varchar(70), bairro varchar(70), rua varchar(70), email varchar(70), numero int, telefone varchar(12), nome varchar(70), estado varchar(70))
begin

insert into pessoa (pescpf,pesdtnascto,pessexo,pescidade,pesbairro,pesrua,pesemail,pesnumero,pestelefone,pesnome,pesestado)
values (cpf, dtnascto, sexo, cidade, bairro, rua, email, numero, telefone, nome, estado);

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_inserepet
-- -----------------------------------------------------

DELIMITER $$
USE `artemis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserepet`(nome varchar(65), sexo char(1), castrado enum('castrado','não castrado','não sei'), dtnascto date, peso float, pessoa int, porte int, raca int, tipo int)
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
USE `artemis`;

DELIMITER $$
USE `artemis`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `artemis`.`tg_exclui_pessoa`
BEFORE DELETE ON `artemis`.`pessoa`
FOR EACH ROW
begin


delete from venda
where venpessoa_pesid = old.pesid;


delete from servico
where pessoa_pesid = old.pesid;

end$$

USE `artemis`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `artemis`.`tg_exclui_petshop`
BEFORE DELETE ON `artemis`.`petshop`
FOR EACH ROW
begin


delete from venda
where venpetshop_ptsid = old.ptsid;

delete from servico
where petshop_ptsid = old.ptsid;

delete from produto
where propetshop_ptsid = old.ptsid;

end$$

USE `artemis`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `artemis`.`tg_exclui_produto`
BEFORE DELETE ON `artemis`.`produto`
FOR EACH ROW
begin

delete from venda
where produto_proid = old.proid;

end$$

USE `artemis`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `artemis`.`tg_exclui_pet`
BEFORE DELETE ON `artemis`.`pet`
FOR EACH ROW
begin

delete from pet_foto
where pet_petid = old.petid;

delete from pet_adocao
where pet_petid = old.petid;

end$$

USE `artemis`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `artemis`.`tg_exclui_servico`
BEFORE DELETE ON `artemis`.`servico`
FOR EACH ROW
begin

delete from venda
where servico_serid=old.serid;

end$$

USE `artemis`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `artemis`.`tg_exclui_ong`
BEFORE DELETE ON `artemis`.`ong`
FOR EACH ROW
begin


delete from pet_adocao
where ong_ongid = old.ongid;

end$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;