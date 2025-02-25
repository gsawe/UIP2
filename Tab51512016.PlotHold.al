table 51512016 "Plot Hold"
{

    fields
    {
        field(1; "Project Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Projects;

            trigger OnValidate()
            var
                TotalPlots: Integer;
                SoldPlots: Integer;
                PercentageSold: Decimal;
            begin
                UserSetup.Get(UserId);
                if UserSetup."PLot Holding" <> true then begin
                    Plots.Reset;
                    Plots.SetRange(Plots.Project, "Project Code");
                    if Plots.FindFirst then begin
                        TotalPlots := Plots.Count;
                    end;

                    Plots.Reset;
                    Plots.SetRange(Plots.Project, "Project Code");
                    Plots.SetRange(Plots.Availability, Plots.Availability::Sold);
                    if Plots.FindFirst then begin
                        SoldPlots := Plots.Count;
                    end;

                    PercentageSold := SoldPlots / TotalPlots * 100;

                    if 20 > PercentageSold then
                        Error('Plots sold  %1 % should be more than 20%.', PercentageSold);
                end;
            end;
        }
        field(2; "Plot No"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = Plots WHERE(Project = FIELD("Project Code"),
                                         Availability = CONST(Available));
        }
        field(3; "Release Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Reason; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Phone No to Notify"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "User Holding"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(7; "Date Held"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Approver; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(9; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New,"Pending Approval",Approved,Released,Rejected;
        }
        field(10; "User Sales Manager"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "User Branch Manager"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Project Code", "Plot No", "User Holding", "Date Held")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Date Held" := Today;
        "User Holding" := UserId;
        UserSetup.Get(UserId);
        UserSetup.TestField(UserSetup."Approver ID");
        Approver := UserSetup."Approver ID";
        datestring := '+' + Format(UserSetup."Plot hold days") + 'D';
        "Release Date" := CalcDate(datestring, Today);
        "User Sales Manager" := UserSetup."User Sales Manager";
        "User Branch Manager" := UserSetup."User Branch Manager";
    end;

    var
        UserSetup: Record "User Setup";
        datestring: Text;
        Plots: Record Plots;
}

