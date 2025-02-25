table 173007 "Change Request"
{

    fields
    {
        field(1;"Code";Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2;"Record Date";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3;"Previous Sales Agent";Code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(4;"New Sales Agent";Code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(5;"Completion Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Change Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Change Sales Agent,Change Completion Date,Release Plot,Plot Transfer,InterProject Transfer,Change Plot Status';
            OptionMembers = ,"Change Sales Agent","Change Completion Date","Release Plot","Plot Transfer","InterProject Transfer","Change Plot Status";
        }
        field(7;Updated;Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8;"Updated By";Code[60])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9;"Updated Date";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10;Customer;Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(11;"Project Code";Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = Projects.Name;
        }
        field(12;"Plot No";Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = Plots."Plot No" WHERE (Project=FIELD("Project Code"));
        }
        field(13;"No. Series";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14;"New Sales Manager";Code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(15;"New Branch Manager";Code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(16;"New Project Code";Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = Projects.Name;
        }
        field(17;"New Plot No";Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = Plots."Plot No" WHERE (Project=FIELD("New Project Code"));
        }
        field(18;Availability;Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Available,Held,Sold;
        }
    }

    keys
    {
        key(Key1;"Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if Code = '' then begin
        PurchSetup.Get;
        PurchSetup.TestField("Change Nos");
        NoSeriesMgt.InitSeries(PurchSetup."Change Nos",xRec."No. Series",0D,Code,"No. Series");
        end;
        "Record Date":=Today;
    end;

    var
        NoSeriesMgt: Codeunit 396;
        PurchSetup: Record "Purchases & Payables Setup";
}

