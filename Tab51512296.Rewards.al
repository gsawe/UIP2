table 51512296 "Rewards"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Branch; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'HQ,Ruiru,Ruai';
            OptionMembers = HQ,Ruiru,Ruai;
        }
        field(4; "Name of Employees"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Categories of rewards"; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Categories of rewards" = CONST('')) "Categories of Rewards"."Categories of Rewards";

            trigger OnValidate()
            begin
                Rewards.SetRange(Rewards."Categories of Rewards", "Categories of rewards");
            end;
        }
        field(6; "Sub categories"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Description of reward"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; No; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF (No = CONST('')) Employee."No.";

            trigger OnValidate()
            begin
                Staff.SetRange(Staff."No.", No);
                if Staff.FindFirst then begin
                    "Name of Employees" := Staff."First Name" + ' ' + Staff."Middle Name" + ' ' + Staff."Last Name";
                end;
            end;
        }
        field(10; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Canceled,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Canceled,Rejected;
        }
        field(11; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
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
            GenSetup.TestField(GenSetup."Reward Nos");
            NoSeriesMgt.InitSeries(GenSetup."Reward Nos", xRec."No. Series", 0D, Code, "No. Series");
        end;
    end;

    var
        Staff: Record Employee;
        Rewards: Record "Categories of Rewards";
        GenSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit 396;
}

