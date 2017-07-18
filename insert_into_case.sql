DO $$
DECLARE nv integer;
BEGIN
   SELECT nextval('case_seq') INTO nv;
   INSERT INTO public.case VALUES (nv, 'Subject ' || nv, 'Description ' || nv);
END $$;
