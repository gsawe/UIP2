table 51513005 "Signitories"
{
    DrillDownPageID = "Add Customer";
    LookupPageID = "Add Customer";

    fields
    {
        field(1; "Customer No"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if Customer.Get("Customer No") then begin
                    Name := Customer.Name;
                    "Phone No" := Customer."Phone No.";
                    ID := Customer."ID NO";
                end;
            end;
        }
        field(2; "Project Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Projects.Name;
        }
        field(3; "Plot No"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = Plots."Plot No" WHERE(Project = FIELD("Project Code"));
        }
        field(4; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Phone No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; ID; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Signatory; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Customer No", "Project Code", "Plot No", Name)
        {
        }
    }

    fieldgroups
    {
    }

    var
        Customer: Record Customer;
}

