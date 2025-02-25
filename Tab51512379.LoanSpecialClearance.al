//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51512379 "Loan Special Clearance"
{

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(2; "Loan Off Set"; Code[20])
        {
            NotBlank = true;

        }
        field(3; "Client Code"; Code[20])
        {
        }
        field(4; "Loan Type"; Code[20])
        {
        }
        field(5; "Principle Off Set"; Decimal)
        {

            trigger OnValidate()
            begin
                Loans.Reset;
                Loans.SetRange(Loans."Loan  No.", "Loan Off Set");
                if Loans.Find('-') then begin
                    Loans.CalcFields(Loans."Outstanding Balance");
                    if "Principle Off Set" > Loans."Outstanding Balance" then
                        Error('Amount cannot be greater than the loan oustanding balance.');

                end;

                "Total Off Set" := "Principle Off Set" + "Interest Off Set";
            end;
        }
        field(6; "Interest Off Set"; Decimal)
        {

            trigger OnValidate()
            begin
                "Total Off Set" := "Principle Off Set" + "Interest Off Set";

                if "Interest Off Set" <> 0 then begin
                    Loans.Reset;
                    Loans.SetRange(Loans."Loan  No.", "Loan Off Set");
                    if Loans.Find('-') then begin
                        Loans.CalcFields(Loans."Interest Due");
                        if "Interest Off Set" > Loans."Interest Due" then
                            Error('Amount cannot be greater than the interest due.');

                    end;
                end;
            end;
        }
        field(7; "Total Off Set"; Decimal)
        {
            Editable = false;
        }
        field(8; "Monthly Repayment"; Decimal)
        {
        }
        field(9; Source; Option)
        {
            OptionCaption = 'BOSA,FOSA';
            OptionMembers = BOSA,FOSA;
        }
    }

    keys
    {
        key(Key1; "Loan No.", "Client Code", "Loan Off Set")
        {
            Clustered = true;
            SumIndexFields = "Total Off Set";
        }
    }

    fieldgroups
    {
    }

    var
        Loans: Record "Loans Register";
        PrincipleRepayment: Decimal;
}




