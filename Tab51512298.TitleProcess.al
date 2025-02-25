table 51512298 "Title Process"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Title Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Title Code" = CONST('')) "Title Processing"."Title Code";

            trigger OnValidate()
            begin
                TL.SetRange(TL."Title Code", "Title Code");
            end;
        }
        field(3; "Reasons for Collecting"; Text[45])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Date Collected"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Collected by"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'CEO,Advocate,Surveyor';
            OptionMembers = CEO,Advocate,Surveyor;
        }
        field(6; "Date Received"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Recieved By"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'CEO,Advocate,Surveyor';
            OptionMembers = CEO,Advocate,Surveyor;
        }
        field(8; Comments; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Issued By"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Reasons For Receiving"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Issue No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Issue No" = CONST('')) Employee."No.";

            trigger OnValidate()
            begin
                Staff.SetRange(Staff."No.", "Issue No");
                if Staff.FindFirst then begin
                    "Issued By" := Staff."First Name" + ' ' + Staff."Middle Name" + ' ' + Staff."Last Name";
                end;
            end;
        }
        field(13; "Approximate Area"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Title; Text[45])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Good,Poor';
            OptionMembers = Good,Poor;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if Code = '' then begin
            GenSetup.Get;
            GenSetup.TestField(GenSetup."Process Nos");
            NoSeriesMgt.InitSeries(GenSetup."Process Nos", xRec."No. Series", 0D, Code, "No. Series");
        end;
    end;

    var
        Staff: Record Employee;
        GenSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TL: Record "Title Processing";
}

