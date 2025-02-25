table 51510118 "Update Contact IDS"
{

    fields
    {
        field(1; "Contact No"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Contact;
        }
        field(2; "User ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
    }

    keys
    {
        key(Key1; "Contact No", "User ID")
        {
        }
    }

    fieldgroups
    {
    }
}

