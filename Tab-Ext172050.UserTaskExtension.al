tableextension 172050 "UserTaskExtension" extends "Sales Cue"
{
    fields
    {
        field(30; "Total Members"; Integer)
        {
            CalcFormula = count(Customer where(ISNormalMember = filter(true)));
            FieldClass = FlowField;
        }

        field(31; "Female Members"; Integer)
        {
            CalcFormula = count(Customer where(ISNormalMember = filter(true), Gender = filter(Female)));
            FieldClass = FlowField;
        }

        field(32; "Male Members"; Integer)
        {
            CalcFormula = count(Customer where(ISNormalMember = filter(true), Gender = filter(Male)));
            FieldClass = FlowField;
        }

        field(33; "Total Deposits"; Decimal)
        {
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Transaction Type" = const("Deposit Contribution")));
            FieldClass = FlowField;
        }

        field(300; "Total Plot Outstanding Amount"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Transaction Type" = filter('Plot|Plot Repayment')));
            FieldClass = FlowField;
        }

        field(35; "Total Projects"; Integer)
        {
            CalcFormula = count(Projects where(Name = filter(<> '')));
            FieldClass = FlowField;
        }
        field(36; "Plots Sold"; Integer)
        {
            CalcFormula = count("Plots" where(Availability = const(Sold)));
            FieldClass = FlowField;
        }
        field(37; "Total Plots"; Integer)
        {
            CalcFormula = count(Plots);
            FieldClass = FlowField;
        }
        field(38; "Plots Being Repaid"; Integer)
        {
            CalcFormula = count("Plots Register" where(Posted = const(true), "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }


        field(39; "Total Shares"; Decimal)
        {
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Transaction Type" = const("Share Capital")));
            FieldClass = FlowField;
        }
    }

    var
        myInt: Integer;
}