table 51512011 "Witness"
{

    fields
    {
        field(1; "Customer No"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
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
}

