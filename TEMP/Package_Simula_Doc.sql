create or replace PACKAGE PAYMENT_PAC
IS
    PROCEDURE PAYMENT_SIMULATION_YES(
        p_id IN cappayment.id%type
    );

    PROCEDURE PAYMENT_SIMULATION_NO(
        p_id IN cappayment.id%type
    );
END;

---------

create or replace PACKAGE BODY PAYMENT_PAC
IS
    FUNCTION VERIFICA_DOC
        (p_id in cappayment.id%type)
        RETURN BOOLEAN
    IS
        v_dummy NUMBER;
    BEGIN
        SELECT 1 into v_dummy
        FROM cappayment
        WHERE id = p_id;
        RETURN true;
    EXCEPTION
        WHEN no_data_found THEN
            RETURN false;        
    END;

    PROCEDURE PAYMENT_SIMULATION_YES(
        p_id IN cappayment.id%type
    )
    IS
        v_dummy BOOLEAN;
        e_document EXCEPTION;
    BEGIN
        v_dummy := VERIFICA_DOC(p_id);
        IF v_dummy = false THEN
           RAISE e_document;
        END IF;
         UPDATE cappayment SET simulation = 1 WHERE id = p_id;
         COMMIT;
    EXCEPTION
        WHEN e_document THEN
            raise_application_error(-20001,'Informe um documento válido');
        END;

    PROCEDURE PAYMENT_SIMULATION_NO(
        p_id IN cappayment.id%type
    )
    IS
        v_dummy BOOLEAN;
        e_document EXCEPTION;
    BEGIN
        v_dummy := VERIFICA_DOC(p_id);
        IF v_dummy = false THEN
           RAISE e_document;
        END IF;
         UPDATE cappayment SET simulation = 0 WHERE id = p_id;
         COMMIT;
    EXCEPTION
        WHEN e_document THEN
            raise_application_error(-20001,'Informe um documento válido');
        END;
END;