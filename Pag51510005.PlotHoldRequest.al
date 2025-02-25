page 51510005 "Plot Hold Request"
{
    CardPageID = "Plot Hold Card";
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Plot Hold";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Project Code"; Rec."Project Code")
                {
                }
                field("Plot No"; Rec."Plot No")
                {
                }
                field("Release Date"; Rec."Release Date")
                {
                    Editable = false;
                }
                field(Reason; Rec.Reason)
                {
                }
                field("Phone No to Notify"; Rec."Phone No to Notify")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("User Holding"; Rec."User Holding")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send for Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField(Rec.Approver);
                    if Confirm('Are you sure you want to send for approval') then begin
                        Rec.Status := Rec.Status::"Pending Approval";
                        Rec.
Modify;
                    end;
                end;
            }
            action(Hold)
            {
                Image = Segment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to hold the plot') then begin
                        Rec.Status := Rec.Status::Approved;
                        Plots.Reset;
                        Plots.SetRange(Project, Rec."Project Code");
                        Plots.SetRange("Plot No", Rec."Plot No");
                        if Plots.FindFirst then begin
                            Plots.TestField(Availability, Plots.Availability::Available);
                            Plots.Availability := Plots.Availability::Held;
                            Plots."Held By" := Rec."User Holding";
                            Plots.Modify;
                        end;
                        Rec.Modify;
                    end;
                end;
            }
            action("Release Plot")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to release the plot') then begin
                        Rec.Status := Rec.Status::Released;
                        Plots.Reset;
                        Plots.SetRange(Project, Rec."Project Code");
                        Plots.SetRange("Plot No", Rec."Plot No");
                        if Plots.FindFirst then begin
                            Plots.TestField(Availability, Plots.Availability::Held);
                            Plots.Availability := Plots.Availability::Available;
                            Plots."Held By" := '';
                            Plots.Modify;
                        end;
                        Rec.Modify;
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        UserSetup.Get(UserId);
        if UserSetup."Sales Executive" = true then
            Rec.FilterGroup(2);
        Rec.SetRange("User Holding", UserId);
        Rec.FilterGroup(0);
        if (UserSetup."Sales Manager" = true) or (UserSetup."Branch Manager" = true) then begin
            repeat
                if (Rec."User Holding" = UserId) or (Rec."User Sales Manager" = UserId) or (Rec."User Branch Manager" = UserId) then
                    Rec.Mark(true);
            until Rec.Next = 0;
            Rec.MarkedOnly(true);
        end;
    end;

    var
        Plots: Record Plots;
        UserSetup: Record "User Setup";
}

