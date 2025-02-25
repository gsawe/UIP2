page 51510233 "All Follow Ups"
{
    PageType = List;
    SourceTable = "Follow ups";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Lead No"; Rec."Lead No")
                {
                }
                field("Lead Name"; "Lead Name")
                {
                }
                field("Phone No"; Rec."Phone No")
                {
                }
                field("Entry Date"; Rec."Entry Date")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                }
                field("Follow Up Purpose"; Rec."Follow Up Purpose")
                {
                }
                field("Next Follow up Date"; Rec."Next Follow up Date")
                {
                }
                field("Sales Person"; Rec."Sales Person")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if Contact.Get(Rec."Lead No") then
            "Lead Name" := Contact.Name;
    end;

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(10);

        UserSetup.Get(UserId);
        if UserSetup."Sales Executive" = true then
            Rec.SetRange("Sales Person", UserId);

        if (UserSetup."Sales Manager" = true) or (UserSetup."Branch Manager" = true) then begin
            if Rec.FindFirst then
                repeat

                    //REPEAT
                    if (Rec."Sales Person" = UserId) or (Rec."User Sales Manager" = UserId) or (Rec."User Branch Manager" = UserId) then
                        Rec.Mark(true);
                // END;
                until Rec.Next = 0;
            Rec.MarkedOnly(true);
        end;
    end;

    var
        Contact: Record Contact;
        "Lead Name": Text;
        UserSetup: Record "User Setup";
}

