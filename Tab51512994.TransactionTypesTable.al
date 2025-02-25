//************************************************************************
table 51512994 "Transaction Types Table"
{
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Plot Repayment,Deposit Contribution,Plot,Share Capital,Commission Paid,Registration Fee,Title Storage Due,Title Storage Paid,Commission Due,Dividend';
            OptionMembers = " ","Plot Repayment","Deposit Contribution",Plot,"Share Capital","Commission Paid","Registration Fee","Title Storage Due","Title Storage Paid","Commission Due","Dividend";

        }
        field(2; "Posting Group Code"; code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group".Code;
        }
    }

    keys
    {
        key(Key1; "Transaction Type")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}


