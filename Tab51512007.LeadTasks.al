table 51510007 "Lead Tasks"
{
    DrillDownPageID = "Lead Tasks";
    LookupPageID = "Lead Tasks";

    fields
    {
        field(1; "Lead No"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Contact;
        }
        field(2; "Task Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Phone Call",Message;
        }
        field(3; "Date Scheduled"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Contact.Get("Lead No");
                // Contact."Next Follow Up Date":="Date Scheduled";
                Contact.Modify;
            end;
        }
        field(4; "Time Scheduled"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Description; Text[1000])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Contact.Get("Lead No");
                // Contact."Follow Up Details":=Description;
                Contact.Modify;
            end;
        }
        field(6; "Actual Task Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Visitor Location / Town"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Project Visited"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Projects;
        }
        field(9; Comment; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Sales Person"; Code[120])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "User Sales Manager"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "User Branch Manager"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Key"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(14; "Entry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Phone No"; Text[30])
        {
            CalcFormula = Lookup(Contact."Phone No." WHERE("No." = FIELD("Lead No")));
            FieldClass = FlowField;
        }
        field(16; Name; Text[45])
        {
            CalcFormula = Lookup(Contact.Name WHERE("No." = FIELD("Lead No")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Lead No", "Task Type", "Date Scheduled", "Key")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Sales Person" := UserId;
        UserSetup.Get(UserId);
        "User Sales Manager" := UserSetup."User Sales Manager";
        "User Branch Manager" := UserSetup."User Branch Manager";
        "Entry Date" := Today;
    end;

    var
        Contact: Record Contact;
        UserSetup: Record "User Setup";
}

