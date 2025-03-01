//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51512550 "Membership App Products"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Membership Reg. Products Appli";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Product; Rec.Product)
                {
                    ApplicationArea = Basic;
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Product Source"; Rec."Product Source")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        if ObjMemberApp.Get(Rec."Membership Applicaton No") then begin
            Rec."Account Category" := ObjMemberApp."Account Category";
        end;
    end;

    var
        ObjMemberApp: Record "Membership Applications";
}




