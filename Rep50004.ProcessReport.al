report 50004 "Process Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\ProcessReport.rdlc';


    dataset
    {
        dataitem(MembersB; Projects)
        {
            column(MembersBEmp; MembersB."Project Name")
            {

            }
            trigger OnAfterGetRecord()
            var
                CustLedg: Record "Cust. Ledger Entry";
                dtldCust: Record "Detailed Cust. Ledg. Entry";
                PlotSales: Record "Plots Register";
                UpdateP: Codeunit "Update Available Plots";
                Titles: Record "Received Titles";
                GEntry: Record "Detailed Cust. Ledg. Entry";
                Customers: Record Customer;
                DueDiligence: Record "Due Diligence";
                Plotsold: Record "Plots Register";
            begin
                /*                 Diligence."Global Dimension 1 Code" := 'INVESTMENT';
                                Diligence."Global Dimension 2 Code" := 'NAIROBI';
                                Diligence.Modify(); */
                // AupdatePlot.Run();
                // Rtitle.Reset();
                // Rtitle.SetRange(Rtitle."Title Deed Number",Titles."Title Deed No");
                // if Rtitle.FindFirst() then begin
                //   //  Message('Here');
                //     Rtitle."Member Name":=Titles."Issued To Name";
                //    // Rtitle.Modify();
                // end;


                /*             PlotSales.Reset();
                            PlotSales.SetRange(PlotSales.No,PlotsB."Document Number");

                            if PlotSales.FindFirst() then begin
                                //Message('Here');
                              //repeat
                              //PlotSales."Plot No":=PlotsB."Correct Plot No";
                              PlotSales."Plot No":=PlotsB."Correct Plot No";
                              PlotSales.Modify(true);
                              //until PlotSales.Next()=0;  
                            end; */
                //PlotsB.Reset();;
                //PlotsB.SetRange(PlotsB."Document Number",plots);
                //   PlotsB."Plot No":=PlotsB."Correct Plot No";
                //      PlotsB.Modify();

                /*       CustLedg.Reset();
                      CustLedg.SetRange(CustLedg."Plot Sale Document No",PlotsB.No);
                      if CustLedg.FindFirst() then begin
                        repeat
                        CustLedg."Plot Number":=PlotsB."Plot No";
                        CustLedg.Modify();
                        until CustLedg.Next()=0;
                      end; */
                /*       dtldCust.Reset();
                      dtldCust.SetRange(dtldCust."Plot Sale Document No",PlotsB.No);
                      if dtldCust.FindFirst() then begin
                        repeat
                        dtldCust."Plot Number":=PlotsB."Plot No";
                        dtldCust.Modify();
                        until dtldCust.Next()=0;
                      end; */
                // UpdateP.Run();dili
                /* MembersB.Reset();
                MembersB.SetRange(MembersB."Member No",Customers."No.");
                if MembersB.FindFirst() then begin
                    Customers."Employee Id":=MembersB."Employee Id";
                    Customers.Modify();
                end; */

                /* Customers.Reset();;
                Customers.SetRange(Customers."No.",MembersB."Member No");
                if Customers.FindFirst() then begin
                    Customers."Employee Id":=MembersB."Employee Id";
                    Customers.Modify();
                end; */

                /*               MembersB.Reset();
                              MembersB.SetRange(MembersB."Entry No.", 618);
                              MembersB.SetRange(MembersB."Document No.", 'OPENBALPLOTS');
                              if MembersB.FindFirst() then begin
                                  MembersB.Amount:= 46667;
                                  MembersB.modify;
                              end; */
                //AupdatePlot.Run();
                /*     Memb.Reset();
                    Memb.SetRange(Memb."No.",MembersB."No.");
                    Memb.SetAutoCalcFields(Memb."Shares Retained");
                    Memb.SetFilter(Memb."Shares Retained",'%1',0);
                    if Memb.FindFirst() then begin
                        Memb."Member Type":=Memb."Member Type"::"Non-Member";
                        Memb.Modify();
                    end;

                        Memb.Reset();
                    Memb.SetRange(Memb."No.",MembersB."No.");
                    Memb.SetAutoCalcFields(Memb."Shares Retained");
                    Memb.SetFilter(Memb."Shares Retained",'>%1',0);
                    if Memb.FindFirst() then begin
                        Memb."Member Type":=Memb."Member Type"::Member;
                        Memb.Modify();
                    end;
                 */
                /* GEntry.Reset();
                GEntry.SetRange(GEntry."Customer No.",MembersB."Customer No.");
                GEntry.SetFilter(GEntry."Plot Number",'43');
                GEntry.SetRange(GEntry."Project Name",'132');
                GEntry.SetFilter(GEntry.Description,'Plot purchase KONZA PROJECT 2 2021 43');
                if GEntry.FindFirst() then begin
                    GEntry."Plot Number":=42;
                    GEntry.Description:='Plot purchase KONZA PROJECT 2 2021 42';
                    GEntry.Modify();
                end; */
                Plotsold.Reset();
                Plotsold.SetRange(Plotsold.Project, MembersB.Name);
                if Plotsold.FindFirst() then begin
                    repeat

                        Plotsold."Project Name" := MembersB."Project Name";
                        Plotsold."Plot Amount" := MembersB.Cost;
                        Plotsold.Modify();
                    until Plotsold.Next() = 0;
                end;
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Name; CompInf)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }



    var
        myInt: Integer;
        CompInf: Code[150];
        AupdatePlot: Codeunit "Update Available Plots";

        Memb: Record Customer;

}