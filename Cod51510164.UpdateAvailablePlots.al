codeunit 51510164 "Update Available Plots"
{
    trigger OnRun()
    begin
        PlotsR.SetRange(PlotsR.Posted, true);
        if PlotsR.FindFirst() then begin
            repeat
                Plots.Reset();
                Plots.SetRange(Plots.Project, PlotsR.Project);
                Plots.SetRange(Plots."Plot No", PlotsR."Plot No");
                if Plots.FindFirst() then begin
                    Plots.Availability := Plots.Availability::Sold;
                    Plots.Modify();
                end;
            until PlotsR.Next() = 0;
        end;

        PlotsR.SetRange(PlotsR.Posted, false);
        if PlotsR.FindFirst() then begin
            repeat
                Plots.Reset();
                Plots.SetRange(Plots.Project, PlotsR.Project);
                Plots.SetRange(Plots."Plot No", PlotsR."Plot No");
                if NOT Plots.FindFirst() then begin

                    Plots.Availability := Plots.Availability::Available;
                    Plots.Modify();
                end;
            until PlotsR.Next() = 0;
        end;



    end;

    var
        PlotsR: record "Plots Register";
        Plots: Record Plots;
        plotsB: record "Plots Buffer";


}