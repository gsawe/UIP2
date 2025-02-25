table 51510043 "Allocation Header"
{
    //DrillDownPageID = "Line Allocations";
    //LookupPageID = "Line Allocations";

    fields
    {
        field(1; "Allocation No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        /*  field(3;"Total Amount";Decimal)
         {
             CalcFormula = Sum("Allocation Line".Amount);
             FieldClass = FlowField;
         } */
        field(4; Blocked; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Posting Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Allocation No")
        {
        }
    }

    fieldgroups
    {
    }
}

