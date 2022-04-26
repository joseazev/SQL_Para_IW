create or replace PACKAGE material_pac
IS
    PROCEDURE matterial_active_yes(
        p_scmaterial in MatMaterialType.scmaterial%type
    );

    PROCEDURE matterial_active_no(
        p_scmaterial in MatMaterialType.scmaterial%type
    );
END;


-----------

create or replace PACKAGE BODY material_pac
IS
    PROCEDURE matterial_active_yes(
        p_scmaterial in MatMaterialType.scmaterial%type
    )
    IS
        v_scmaterial_error EXCEPTION;
    BEGIN

        UPDATE MatMaterialType set active = 1 WHERE scmaterial = p_scmaterial;

        UPDATE PscMaterialType set active = 1 WHERE scmaterial = p_scmaterial;

        IF SQL%NOTFOUND THEN
            RAISE v_scmaterial_error;
        END IF;
        COMMIT;
    EXCEPTION
        WHEN v_scmaterial_error THEN
            RAISE_APPLICATION_ERROR(-20000, 'Informe um código válido');
    END;



    PROCEDURE matterial_active_no(
        p_scmaterial in MatMaterialType.scmaterial%type
    )
    IS
        v_scmaterial_error EXCEPTION;
    BEGIN

        UPDATE MatMaterialType set active = 0 WHERE scmaterial = p_scmaterial;

        UPDATE PscMaterialType set active = 0 WHERE scmaterial = p_scmaterial;

        IF SQL%NOTFOUND THEN
            RAISE v_scmaterial_error;
        END IF;
        COMMIT;
    EXCEPTION
        WHEN v_scmaterial_error THEN
            RAISE_APPLICATION_ERROR(-20000, 'Informe um código válido');
    END;
END;