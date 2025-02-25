//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50035 "Online Portal Users"
{
    Caption = 'Online Portal Users';

    fields
    {
        field(1; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            TableRelation = Customer;
        }

        field(2; "Member Name"; Code[1000])
        {
            Caption = 'Member Name';
        }
        field(3; "ID Number"; Code[20])
        {
            Caption = 'ID Number';
        }
        field(4; "Email Address"; Text[100])
        {
            Caption = 'Email Address';
        }
        field(5; "Date Created"; Date)
        {
            Caption = 'Date Created';
        }


        field(6; Password; Text[50])
        {
            Caption = 'Password';
        }
        field(7; "Changed Password"; Boolean)
        {
            Caption = 'Changed Password';
        }



    }

    keys
    {
        key(PK; "Member No.")
        {

        }
    }







}








