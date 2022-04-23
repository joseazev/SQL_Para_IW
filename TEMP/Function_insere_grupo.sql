/*
	Function: Esta procedure insere na tabela de grupos os grupos de um colaborador baseado em um outro colaborador mais aontigo

	author: José Francisco Azevedo da Silva
*/

create or replace PROCEDURE insere_grupos(
    p_old_iduser glbperson.iduser%type,
    p_new_iduser glbperson.iduser%type,
    p_id glbperson.id%type
)
IS
    CURSOR CUR_GROUP IS SELECT a.idusergroup from secusergroupitem a WHERE iduser = p_old_iduser;

BEGIN
    FOR v_idgroup in cur_group LOOP
        INSERT INTO secusergroupitem(idusergroup,iduser) VALUES (v_idgroup.idusergroup, p_new_iduser);
    END LOOP;

    UPDATE glbperson SET IDUSER = p_new_iduser where id = p_id;

    COMMIT;

    EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(20020, 'Erro ao inserir grupo a usuário');
END;