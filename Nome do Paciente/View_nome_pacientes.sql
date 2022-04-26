/*
	Function: Criar View  para simplificar a busca de nome do pacientes.
	A View retorna o numero de atendimento, o numero de prontuario, a operadora do paciente e o id da complexidade do paciente.
	Excluindo o paciente teste.

	Author: José Francisco Azevedo da Silva
*/

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "DBIWSOLARCUIDADOS"."VW_PATIENTNAME" ("NUMERO_ATENDIMENTO", "PRONTUARIO", "PATIENTNAME", "ENTERPRISENAME", "IDCOMPLEXIDADE") AS 
  (
    SELECT 
        a.ID AS NUMERO_ATENDIMENTO,
        B.ID AS PRONTUARIO,
        c.name AS patientname,
        d.name AS enterprisename,
        a.attendanceprogram as idcomplexidade
    FROM 
        capadmission a
        INNER JOIN glbpatient b
            on (a.idpatient = b.id)
        INNER JOIN glbperson c
            on (b.idperson = c.id)
        INNER JOIN glbenterprise d
            on (a.IDENTERPRISE = D.ID)
    WHERE
        c.id <> 15290
);
