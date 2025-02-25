tableextension 51510012 "Contact" extends Contact
{
    fields
    {
        // Add changes to table fields here
        field(50000; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Male,female;
        }
        field(50001; Source; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Sales Person"; Code[40])
        {
            DataClassification = ToBeClassified;
        }

        field(50003; "Campaign / Page or Group"; Code[40])
        {
            DataClassification = ToBeClassified;
        }

        field(50004; Status; Code[40])
        {
            DataClassification = ToBeClassified;
        }

        field(50005; "Customer No"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Next Follow Up Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(50007; "Follow Up Details"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Follow Up Purpose"; Text[80])
        {
            DataClassification = ToBeClassified;
        }


    }

    var
        myInt: Integer;
}